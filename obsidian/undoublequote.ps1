param ($SText =$(throw "No selection made."))
# to replace curly quotes with their reverse
$SText -replace "\u201d|`" ", "doubleclose " `
 -replace "\u201c|`"","doubleopen" `
 -replace "\u2018| '", "singleopen" `
 -replace "\u2019|' ", "singleclose " `
 -replace 'singleopen', " `u{201c}" `
 -replace 'singleclose', "`u{201d} "`
 -replace 'doubleopen',  "`u{2018}" `
 -replace 'doubleclose',"`u{2019} "                              
# pastes the rresult straight back into the document
# Never forget the horrors of outputting unicode to the console