if (fileName.endsWith(".loc.tsv")) {
    content = content.replace(/\n#.*?\n/g, "\n");
} else if (fileName.endsWith(".steam")) {
    fileName = fileName + ".tsv";
    content = "ID\tContent\nsteam_description\t"+content.replace(/\r\n|\n\r|\n/g, "\\\\n")+"\n";
}
type = "csv";
