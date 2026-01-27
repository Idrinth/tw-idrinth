/**
 * Fixes Crowdin TSV export that adds unnecessary quotes around fields
 * and over-escapes internal quotes.
 * 
 * @param {string} tsvContent - The raw TSV file content from Crowdin
 * @returns {string} - Fixed TSV matching the original source format
 */
function fixCrowdinTsv(tsvContent) {
  return tsvContent
    .replace(/\r\n|\n\r/g, "\n")
    .split('\n')
    .map(line => {
      if (!line.trim()) {
        return line;
      }
      return line.split('\t').map(field => {
        field = field.replace(/""+/g, '"');
        if (field.startsWith('"') && field.endsWith('"')) {
          field = field.slice(1, -1);
        }        
        return field;
      }).join('\t');
    })
    .join('\n');
}

if (fileName.endsWith(".tsv")) {
  content = fixCrowdinTsv(content);
  if (fileName.endsWith(".steam.tsv")) {
    fileName = fileName.replace(/\.tsv$/, "");
    content =  content.replace(/^steam_description\t/, "").replace(/\\\\n/g, "\n")
  } else {
    content = content.replace(/\n/, "\n#Loc;1;text/db/!"+fileName.replace(/\.tsv$/, "")+"\t\t\n");
  }
}
