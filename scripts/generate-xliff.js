#!/usr/bin/env node
/**
 * Generates XLIFF files from TSV translation files.
 * Organizes content by origin file (source category).
 *
 * XLIFF 1.2 format: https://docs.oasis-open.org/xliff/v1.2/os/xliff-core.html
 */

const fs = require('fs');
const path = require('path');

const TEXT_DB_DIR = path.join(__dirname, '..', 'idrinth', 'text', 'db');
const OUTPUT_DIR = path.join(__dirname, '..', 'xliff');

// Language code mapping (TW:WH3 to standard)
const LANG_CODES = {
  'br': 'pt-BR',
  'cn': 'zh-CN',
  'cz': 'cs',
  'de': 'de',
  'es': 'es',
  'fr': 'fr',
  'it': 'it',
  'kr': 'ko',
  'pl': 'pl',
  'ru': 'ru',
  'tr': 'tr',
  'zh': 'zh-TW'
};

/**
 * Parse a TSV file and return key-value pairs
 * @param {string} filePath
 * @returns {Map<string, {text: string, tooltip: string}>}
 */
function parseTsv(filePath) {
  const content = fs.readFileSync(filePath, 'utf8');
  const lines = content.split('\n');
  const entries = new Map();

  for (let i = 0; i < lines.length; i++) {
    const line = lines[i].trim();
    if (!line) continue;
    if (i === 0 && line.startsWith('key')) continue; // Skip header
    if (line.startsWith('#Loc;')) continue; // Skip metadata

    const parts = line.split('\t');
    if (parts.length >= 2) {
      const key = parts[0];
      const text = parts[1] || '';
      const tooltip = parts[2] || 'false';
      entries.set(key, { text, tooltip });
    }
  }

  return entries;
}

/**
 * Determine which source file a key belongs to based on its prefix
 * @param {string} key
 * @param {string[]} sourceFiles
 * @returns {string|null}
 */
function findSourceFile(key, sourceFilePrefixes) {
  // Sort by length descending to match most specific prefix first
  const sorted = [...sourceFilePrefixes].sort((a, b) => b.length - a.length);

  for (const prefix of sorted) {
    if (key.startsWith(prefix)) {
      return prefix;
    }
  }
  return null;
}

/**
 * Escape XML special characters
 * @param {string} str
 * @returns {string}
 */
function escapeXml(str) {
  return str
    .replace(/&/g, '&amp;')
    .replace(/</g, '&lt;')
    .replace(/>/g, '&gt;')
    .replace(/"/g, '&quot;')
    .replace(/'/g, '&apos;');
}

/**
 * Generate XLIFF content for a single source file with all translations
 * @param {string} sourceFileName
 * @param {Map<string, {text: string, tooltip: string}>} sourceEntries
 * @param {Map<string, Map<string, {text: string, tooltip: string}>>} translationsByLang
 * @returns {string}
 */
function generateXliff(sourceFileName, sourceEntries, translationsByLang) {
  let xliff = `<?xml version="1.0" encoding="UTF-8"?>
<xliff version="1.2" xmlns="urn:oasis:names:tc:xliff:document:1.2">
`;

  // Create a file element for each target language
  for (const [langCode, twCode] of Object.entries(LANG_CODES)) {
    const translations = translationsByLang.get(langCode);
    if (!translations) continue;

    xliff += `  <file source-language="en" target-language="${twCode}" datatype="plaintext" original="${sourceFileName}">
    <body>
`;

    // Add trans-unit for each source entry
    for (const [key, sourceData] of sourceEntries) {
      const targetData = translations.get(key);
      const targetText = targetData ? targetData.text : '';

      // Determine state based on whether translation exists
      const state = targetText ? 'translated' : 'needs-translation';

      xliff += `      <trans-unit id="${escapeXml(key)}" xml:space="preserve">
        <source xml:lang="en">${escapeXml(sourceData.text)}</source>
        <target xml:lang="${twCode}" state="${state}">${escapeXml(targetText)}</target>
      </trans-unit>
`;
    }

    xliff += `    </body>
  </file>
`;
  }

  xliff += `</xliff>
`;

  return xliff;
}

function main() {
  console.log('Generating XLIFF files from translation data...\n');

  // Create output directory
  if (!fs.existsSync(OUTPUT_DIR)) {
    fs.mkdirSync(OUTPUT_DIR, { recursive: true });
  }

  // Get all files in the text/db directory
  const allFiles = fs.readdirSync(TEXT_DB_DIR).filter(f => f.endsWith('.loc.tsv'));

  // Separate source files from translation files
  // Source files: idrinth_{category}__.loc.tsv (double underscore before .loc)
  // Translation files: idrinth__{lang}.loc.tsv (double underscore after idrinth)
  const sourceFiles = allFiles.filter(f =>
    f.match(/^idrinth_[^_].*__\.loc\.tsv$/) && !f.match(/^idrinth__[a-z]{2}\.loc\.tsv$/)
  );
  const translationFiles = allFiles.filter(f => f.match(/^idrinth__[a-z]{2}\.loc\.tsv$/));

  console.log(`Found ${sourceFiles.length} source files`);
  console.log(`Found ${translationFiles.length} translation files\n`);

  // Parse source files
  const sourceData = new Map();
  const sourcePrefixToFile = new Map();

  for (const file of sourceFiles) {
    const filePath = path.join(TEXT_DB_DIR, file);
    const entries = parseTsv(filePath);
    sourceData.set(file, entries);

    // Extract the category prefix from filename
    // e.g., idrinth_cultures__.loc.tsv -> cultures_
    // e.g., idrinth_ancillaries__.loc.tsv -> ancillaries_
    const match = file.match(/^idrinth_(.+)__\.loc\.tsv$/);
    if (match) {
      const category = match[1];
      sourcePrefixToFile.set(category, file);
    }

    console.log(`  Parsed ${file}: ${entries.size} entries`);
  }

  // Build a mapping from key prefixes to source files
  // We need to determine which keys belong to which source file
  const keyPrefixMap = new Map();
  for (const [file, entries] of sourceData) {
    for (const key of entries.keys()) {
      // Extract the prefix up to the first identifier
      // Keys follow pattern: {category}_{field}_{identifier}
      // We want to map based on the key prefix pattern
      keyPrefixMap.set(key, file);
    }
  }

  // Parse translation files
  console.log('\nParsing translation files...');
  const translationsByLang = new Map();

  for (const file of translationFiles) {
    const match = file.match(/^idrinth__([a-z]{2})\.loc\.tsv$/);
    if (!match) continue;

    const langCode = match[1];
    const filePath = path.join(TEXT_DB_DIR, file);
    const entries = parseTsv(filePath);
    translationsByLang.set(langCode, entries);

    console.log(`  Parsed ${file}: ${entries.size} entries`);
  }

  // Generate XLIFF files for each source file
  console.log('\nGenerating XLIFF files...');
  let totalGenerated = 0;

  for (const [sourceFile, entries] of sourceData) {
    if (entries.size === 0) continue;

    const xliffContent = generateXliff(sourceFile, entries, translationsByLang);

    // Output filename: replace .loc.tsv with .xliff
    const outputName = sourceFile.replace('.loc.tsv', '.xliff');
    const outputPath = path.join(OUTPUT_DIR, outputName);

    fs.writeFileSync(outputPath, xliffContent, 'utf8');
    console.log(`  Generated ${outputName}`);
    totalGenerated++;
  }

  console.log(`\nDone! Generated ${totalGenerated} XLIFF files in ${OUTPUT_DIR}`);
}

main();
