$taskName = "InstallWSLDistro"
$task = Get-ScheduledTask | Where-Object TaskName -eq $taskName

if ($task) {
  $winVer = [int](Get-Item "HKLM:SOFTWARE\Microsoft\Windows NT\CurrentVersion").GetValue('ReleaseID')
  if ($winVer -ge 2004) {
    # wsl 2 rocks 🚀
    wsl --set-default-version 2
  }
  $item = "wsl-ubuntu-1804"
  $file = "$env:TEMP\$item.appx"
  Write-Host "Downloading $item"
  curl.exe -sL https://aka.ms/$item -o $file
  Add-AppxPackage $file
  Remove-Item $file
  $task | Unregister-ScheduledTask -Confirm:$false
  # Run ubuntu as blocking so we can setup the initial username password
  # Once you type exit or logout, wsl.sh script will run.
  ubuntu1804.exe
  wsl -d Ubuntu-18.04 sudo bash ./wsl.sh
} else {
  $scriptlocation = Get-ChildItem .\wsldistro.ps1 | Select-Object -ExpandProperty FullName
  $TaskTrigger = (New-ScheduledTaskTrigger -AtLogOn)
  $TaskAction = New-ScheduledTaskAction -Execute pwsh.exe -argument "$scriptlocation"
  $TaskUserID = New-ScheduledTaskPrincipal -UserId "$env:USERNAME" -RunLevel Highest
  Register-ScheduledTask -Force -TaskName $taskName -Action $TaskAction -Principal $TaskUserID -Trigger $TaskTrigger
}
