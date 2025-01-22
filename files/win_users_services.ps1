param(
    [string]$Argument
)

# Function to show all local users
function Show-Users {
    $users = Get-WmiObject -Class Win32_UserAccount -Filter "LocalAccount='True'"
    $users | Format-Table -Property Name, Disabled, Lockout
}

# Function to show all services
function Show-Services {
    $services = Get-Service
    $services | Format-Table -Property Name, Status, DisplayName
}

# Check the argument and take appropriate action
if ($Argument -eq "userlist") {
    Write-Host "Listing all local users:"
    Show-Users
} elseif ($Argument -eq "servicelist") {
    Write-Host "Listing all services:"
    Show-Services
} else {
    Write-Host "Invalid argument. Please use 'userlist' or 'servicelist'."
}
