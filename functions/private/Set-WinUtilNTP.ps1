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
        w32tm /config /manualpeerlist:"$($sync.configs.ntp.$NTPProvider.Server)" /syncfromflags:manual /update
    } catch {
        Write-Warning "Unable to set NTP server due to an unhandled exception"
        Write-Warning $psitem.Exception.StackTrace
    }
}
