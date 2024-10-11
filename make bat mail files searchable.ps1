 # An example powershell script to find all the bat mail files and make copies that windows will search
 # This works, swiftly and silently
 # note the use of the "no extension" construct, and the foreach loop to copy
 # and the general "$_." syntax to access properties
 ls * -Recurse | where { !($_.Extension) -and $_.Length -ge 100} | Sort-Object Length -descending | ForEach-Object {Copy-Item $_.FullName ($_.Name + ".txt")}