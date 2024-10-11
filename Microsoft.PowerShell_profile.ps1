set-alias -name which -Value Get-command
set-alias -name la -Value gci -Force
set-alias -name ll -Value gci -Force
function Prompt {( pwd |split-path -Leaf) +' -> ' }
