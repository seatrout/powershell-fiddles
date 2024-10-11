# teeny script to end each line with two spaces so that markdown will render it as a line break
param ($MarkdownFile =$(throw "No file passed in."))
(get-content $MarkdownFile) -replace '(\S)$',"`$1  " `
 -replace '(\S) $', "`$1  " `
 -replace '^---  $','---'                             
| set-content $MarkdownFile                              # note the pipe
