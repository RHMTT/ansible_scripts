# Get all services
$services = Get-Service

# Get running services
$runningServices = $services | Where-Object { $_.Status -eq 'Running' }

# Get stopped services
$stoppedServices = $services | Where-Object { $_.Status -eq 'Stopped' }

# Display running services
Write-Host "Running Services:"
$runningServices | Format-Table -Property Name, Status, DisplayName

Write-Host "`nStopped Services:"
# Display stopped services
$stoppedServices | Format-Table -Property Name, Status, DisplayName
