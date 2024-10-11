#Requires -Version 7.0
param ($MarkdownFile =$('Needs a file passed to it, duh'))
$tempfolder = (Split-Path -Path $MarkdownFile -Parent) + "\doublespaced copies"
$tempfile = $tempfolder + "\" + (Split-Path -Leaf $MarkdownFile)
if (!(Test-Path -Path $tempfolder)) {
    New-Item -ItemType Directory -Path $tempfolder
}
$singlespace=(get-content $MarkdownFile -Raw)
$singlespace -replace "`n","`n`n"`
-replace "\-\n+", "-\n" # restoring single line after YAML`
-replace "\|`n`n","|`n" | set-content $tempfile # restoring single line breaks in the tables
Write-Host "Temp file written to $tempfile"
