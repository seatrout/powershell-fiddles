#Requires -Version 7.0
# First, addd a filepicker dialogue
# Add the necessary assembly for Windows Forms
Add-Type -AssemblyName System.Windows.Forms

# Create an instance of the OpenFileDialog class
$openFileDialog = New-Object System.Windows.Forms.OpenFileDialog

# Configure the dialog properties
$openFileDialog.Title = "Select a file"
$openFileDialog.Filter = "All Files (*.*)|*.*"

# Show the dialog and capture the result
$result = $openFileDialog.ShowDialog()

# Handle the selected file path
if ($result -eq [System.Windows.Forms.DialogResult]::OK) {
    $MarkdownFile = $openFileDialog.FileName
    Write-Output "Selected file: $MarkdownFile"
} else {
    Write-Output "No file selected."
}

# param ($MarkdownFile =$('C:\Users\Andrew\Vaults\Floradora\Drafts\2 - the cottage.md'))
$tempfile = (Split-Path -Path $MarkdownFile -Parent) + "\temp_file_for_MSWord.md"
if (Test-Path $tempfile) {
    Remove-Item $tempfile
}
$singlespace=(get-content $MarkdownFile -Raw)
# now strip the YAML, if there is any
if ($singlespace -match "---") {
    $fakepython=$singlespace -split "---",3
    $singlespace=$fakepython[2]
}
$singlespace -replace "`n","`n`n"`
-replace "\|`n`n","|`n" | set-content $tempfile # restoring single line breaks in the tables
Write-Host "Temp file written to $tempfile"
$outpath=$env:userprofile+"\Vaults\Pandoc_exports\"
$out_word = Split-Path -LeafBase $MarkdownFile
$out_word = $out_word + ".docx"
$outfile = $outpath + $out_word
Write-Host "Output file will be $outfile"
if (Test-Path $outfile) {
    Remove-Item $outfile
    Write-Host "removing last attempt at $outfile"
}
start-process  -FilePath "C:\Program Files\Pandoc\pandoc.exe" -ArgumentList "--output=`"$outfile`" -t docx -f markdown+footnotes+mmd_title_block --standalone --reference-doc=C:\Users\Andrew\Vaults\Pandoc_exports\custom-reference.docx $tempfile"
Write-Host "Pandoc complete"

