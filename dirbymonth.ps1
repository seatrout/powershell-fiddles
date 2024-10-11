 $work_dir=GetFolder
 Set-Location $work_dir
 $entries= Get-ChildItem -Path $work_dir -Filter *2024*
 ForEach ($entry in $entries) {
 $entry.name -match '-(?<month>\d\d)-'
	  if (!(Get-ChildItem -Path . -Filter $Matches.month)) {
                New-item -Name $Matches.month  -ItemType "directory"
                Move-Item -Path $entry.FullName -Destination $Matches.month
                }
        else {Move-Item -Path $entry.FullName -Destination $Matches.month}  
}
# then rename them to real month names
$dirs = Get-ChildItem -Path $work_dir -Directory -Filter ?? 
foreach ($dir in $dirs) {
  # Convert the directory name to an integer
  $num = [int]$dir.Name
  # Check if the number is between 1 and 12
  if ($num -ge 1 -and $num -le 12) {
    # Get the month name from the culture info
    $month = [cultureinfo]::InvariantCulture.DateTimeFormat.GetMonthName($num)
	# Rename the directory with the month name
    Rename-Item -Path $dir.FullName -NewName $month
  }
}