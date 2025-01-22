# Get all local users
$users = Get-WmiObject -Class Win32_UserAccount -Filter "LocalAccount='True'"

# Get the last logon time for each user
$users | ForEach-Object {
    # Get user details
    $userName = $_.Name
    
    # Get the last logon time using Get-EventLog, filtering for user logons
    $lastLogon = Get-EventLog -LogName Security -InstanceId 528 -Message "*$userName*" -MaxEvents 1 | Select-Object -ExpandProperty TimeGenerated
    
    # If no logon found, show "Never Logged On"
    if ($lastLogon) {
        [PSCustomObject]@{
            UserName    = $userName
            LastLogon   = $lastLogon
        }
    } else {
        [PSCustomObject]@{
            UserName    = $userName
            LastLogon   = "Never Logged On"
        }
    }
}
