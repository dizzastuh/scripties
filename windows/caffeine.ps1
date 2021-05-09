Clear-Host
Echo "Keep-alive with Scroll Lock..."

$WShell = New-Object -com "Wscript.Shell"

function sendScrollLock {
  $WShell.sendkeys("{SCROLLLOCK}")
  Start-Sleep -s 15
}

while ($true)
{  
  sendScrollLock
}
