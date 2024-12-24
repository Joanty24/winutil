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
        Push-Location
        Set-Location HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\DateTime\Servers
        Set-ItemProperty . 0 "$($sync.configs.ntp.$NTPProvider.Server)"
        Set-ItemProperty . "(Default)" "0"
        Set-Location HKLM:\SYSTEM\CurrentControlSet\services\W32Time\Parameters
        Set-ItemProperty . NtpServer "$($sync.configs.ntp.$NTPProvider.Server)"
        Pop-Location
        Stop-Service w32time
        Start-Service w32time
    } catch {
        Write-Warning "Unable to set NTP server due to an unhandled exception"
        Write-Warning $psitem.Exception.StackTrace
    }
}
