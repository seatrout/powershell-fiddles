$work_dir=GetFolder
Set-Location $work_dir
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