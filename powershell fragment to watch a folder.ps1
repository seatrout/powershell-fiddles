<# // Powershell fragment to watch download folder
// This code demonstrates how to listen for new file creation on a specific folder and its subfolders. Set the IncludeSubdirectories property to $false, or simply remove the line if that is not a requirement.
// In its Action block, it gathers the data you want to log, writes a message to the host and moves the file to a destination folder. You may need to check for file existence at the destination folder for cases where files with same name, and decide to overwrite or modify the name.
// You don’t say how you’ll log the activity. Check my reply to this thread, it shows one way to append data to an Excel worksheet. But if you’ll be appending to a CSV file, check this blog entry.
// #>
$folder = '<full path to the folder to watch>'
$filter = '*.*'                             # <-- set this according to your requirements
$destination = '<full path to the destination folder>'
$fsw = New-Object IO.FileSystemWatcher $folder, $filter -Property @{
 IncludeSubdirectories = $true              # <-- set this according to your requirements
 NotifyFilter = [IO.NotifyFilters]'FileName, LastWrite'
}
$onCreated = Register-ObjectEvent $fsw Created -SourceIdentifier FileCreated -Action {
 $path = $Event.SourceEventArgs.FullPath
 $name = $Event.SourceEventArgs.Name
 $changeType = $Event.SourceEventArgs.ChangeType
 $timeStamp = $Event.TimeGenerated
 Write-Host "The file $name  was $changeType at $timeStamp"
 Move-Item $path -Destination $destination -Force -Verbose # Force will overwrite files with same name
}
Unregister-Event -SourceIdentifier FileCreated
