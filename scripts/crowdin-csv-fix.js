/**
 * Fixes Crowdin TSV export that adds unnecessary quotes around fields
 * and over-escapes internal quotes.
 * 
 * @param {string} tsvContent - The raw TSV file content from Crowdin
 * @returns {string} - Fixed TSV matching the original source format
 */
function fixCrowdinTsv(tsvContent) {
  return tsvContent
    .split('\n')
    .map(line => {
      if (!line.trim()) return line;
      
      // Split by tab, process each field
      return line.split('\t').map(field => {
        // Remove wrapping quotes if present
        if (field.startsWith('"') && field.endsWith('"')) {
          field = field.slice(1, -1);
        }
        
        // Collapse any sequence of 2+ quotes down to a single quote
        // This handles ""  """"  """"""""""  etc. all becoming "
        field = field.replace(/""+/g, '"');
        
        return field;
      }).join('\t');
    })
    .join('\n');
}
content = fixCrowdinTsv(content);
