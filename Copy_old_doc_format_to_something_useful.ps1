# Andrew's powershell script to restore a fuckup
Set-Location C:\Users\Andrew\OneDrive\Documents
foreach ($docfile in Get-ChildItem -Filter *.doc -Recurse -Exclude *.docx ){
   $docpath=$docfile.DirectoryName
   $odtversion=-join($docpath,"\",$docfile.BaseName,".odt")
   Write-Output $odtversion# echo
   if (-not (Test-Path $odtversion)){
       try {
           (soffice.exe --convert-to odt --outdir $docpath $docfile) 
           Write-Host "Converted $docfile"
       }
       catch {
           Write-Host "Fuckit. Something went wrong"
       }
   }
    else{
        Write-Host "an ODT version already exists for $docfile"
    }
       
}