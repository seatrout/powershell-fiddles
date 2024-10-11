# Andrew's powershell script to restore a fuckup
Set-Location C:\Users\Andrew\OneDrive\Documents
$uniques=@()
foreach ($docfile in Get-ChildItem -filter *.doc -Exclude *docx -Recurse){
   $docpath=$docfile.DirectoryName
   $odtversion=-join($docpath,"\",$docfile.BaseName,".odt")
#   Write-Output $odtversion
   if (-not (Test-Path $odtversion)){
        Write-Host "there is no copy of $docfile"
        $uniques+=$docfile
    }       
}
foreach ($unconverted in $uniques){
    try {
        (soffice.exe --convert-to odt --outdir $docpath $unconverted) 
        Write-Host "Converted $unconverted"
    }
    catch {
        Write-Host "Fuckit. Something went wrong"
    }
}