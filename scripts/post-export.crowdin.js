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

if (fileName.endsWith(".tsv")) {
  if (! fileName.endsWith(".loc.tsv")) {
    fileName = fileName.replace(/\.loc(\..+)\.tsv$/, "$1.loc.tsv");
  }
  content = fixCrowdinTsv(content)
    .replace(/\n/, "\n#Loc;1;text/"+fileName.replace(/^.+\.loc(\..+)\.tsv$/, "$1")+"/"+fileName.replace(/\.tsv$/, "")+"\t\t\n");
} else if (fileName.endsWith(".steam")) {
  content =  fixCrowdinTsv(content).replace(/^steam_description\t/, "").replace(/\\n/g, "\\\\n")
}
