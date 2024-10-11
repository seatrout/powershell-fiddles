Function GetFolder {
    Add-Type -AssemblyName System.Windows.Forms
    $FileDialog = New-Object System.Windows.Forms.FolderBrowserDialog
    $FileDialog.Description = 'Select a folder'
    if ($FileDialog.ShowDialog() -eq 'OK') {
        return $FileDialog.SelectedPath
    }
    else {
        exit
    }
}

Write-Host "File selected: $(GetFolder)"
GetFolder