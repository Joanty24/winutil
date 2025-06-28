function Set-WinUtilNTP{
    <#

    .SYNOPSIS
        Sets the NTP server. It will lookup the values from the ntp.Json file

    .PARAMETER NTPProvider
        The NTP provider to set the NTP server to

    .EXAMPLE
        Set-WinUtilNTP -NTPProvider "google"

    #>
    param($NTPProvider)
    if($NTPProvider -eq "Default") {return}
    try {
        reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\DateTime\Servers" /v 3 /t REG_SZ /d "$($sync.configs.ntp.$NTPProvider.Server)" /f
        reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\W32Time\Parameters" /v NtpServer /t REG_SZ /d "$($sync.configs.ntp.$NTPProvider.Server)" /f
        w32tm /config /manualpeerlist:"$($sync.configs.ntp.$NTPProvider.Server)" /syncfromflags:manual /update
        net stop w32time
        net start w32time
        w32tm /resync /force
    } catch {
        Write-Warning "Unable to set NTP server due to an unhandled exception"
        Write-Warning $psitem.Exception.StackTrace
    }
}
