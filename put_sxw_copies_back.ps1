# Andrew's powershell script to restore a fuckup
Set-Location C:\Users\Andrew\OneDrive\Documents
foreach ($fuckup in Get-ChildItem -file *.odt){
    $original= (-join ($fuckup.Basename,".sxw"))
    foreach ($Originalsxw in Get-ChildItem -Recurse -file $original){
        $originalhome=$Originalsxw.PSParentPath
        try {
            Move-Item -Path $fuckup -Destination $originalhome
            Write-Output (-join($fuckup.PSChildName, " moved to ", $originalhome))
        }
        catch {
            "File existed. Skipping, I hope"
        }
        
    }

}