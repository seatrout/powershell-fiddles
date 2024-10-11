param ($MarkdownFile =$(throw "No file passed in."))
$tempfile = (Split-Path -Path $MarkdownFile -Parent) + "\temp.md"
(get-content $MarkdownFile) -replace '`n','`r`n'| set-content $tempfile
$out_word = (Split-Path -Path $MarkdownFile -LeafBase) + ".docx"
Start-Process 'pandoc' -ArgumentList '--from markdown', '--output $out_word', '$tempfile'
# Remove-Item $tempfile

