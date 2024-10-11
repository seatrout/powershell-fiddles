# teeny script to end each line with two spaces so that markdown will render it as a line break
param ($MarkdownFile =$(throw "No file passed in."))
(get-content $MarkdownFile -Raw) -replace '\n\s*\n',"  \n" `
-replace '^---  \n','---\n\n'                             
| set-content $MarkdownFile                              # note the pipe
