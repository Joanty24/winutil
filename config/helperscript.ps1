#This file is meant to assist in building out the json files inside this folder.

#===========================================================================
# applications.json
#===========================================================================

<#
    Applications.json
    -----------------
    This file holds all the install commands to install the applications.
    This file has the ability to expect multiple frameworks per checkbox.
    You can also add multiple install commands by separating them with ;

    The structure of the json is as follows

{
    "NameofButton": {
        "winget":"Wingetcommand",
        "choco":"na"
    },
}
#>

#Modify the variables and run his code. It will import the current file and add your addition. From there you can create a pull request.
#------Do not delete WPF------

$NameofButton = "WPF" + ""
$WingetCommand = ""
$ChocoCommand = ""

$ButtonToAdd = New-Object psobject
$jsonfile = Get-Content ./config/applications.json | ConvertFrom-Json

#remove if already exists
if($jsonfile.$NameofButton){
    $jsonfile.psobject.Properties.remove($NameofButton)
}

Add-Member -InputObject $ButtonToAdd -MemberType NoteProperty -Name "Winget" -Value $WingetCommand
Add-Member -InputObject $ButtonToAdd -MemberType NoteProperty -Name "choco" -Value $ChocoCommand
Add-Member -InputObject $jsonfile.install -MemberType NoteProperty -Name $NameofButton -Value $ButtonToAdd

$jsonfile | ConvertTo-Json | Out-File ./config/applications.json

#===========================================================================
# feature.json
#===========================================================================

<#
    feature.json
    -----------------
    This file holds all the windows commands to install specific features (IE Hyper-v)

    The structure of the json is as follows

{
    "Name of Button": [
        "Array of",
        "commands"
    ]
}
#>

#Modify the variables and run his code. It will import the current file and add your addition. From there you can create a pull request.

$NameofButton = ""
$commands = @(

)

$jsonfile = Get-Content ./config/feature.json | ConvertFrom-Json

#remove if already exists
if($jsonfile.$NameofButton){
    $jsonfile.psobject.Properties.remove($NameofButton)
}

Add-Member -InputObject $jsonfile -MemberType NoteProperty -Name $NameofButton -Value $commands

$jsonfile | ConvertTo-Json | Out-File ./config/feature.json

#===========================================================================
# preset.json
#===========================================================================

<#
    preset.json
    -----------------
    This file holds all check boxes you wish to check when clicking a preset button in the tweaks section.

    The structure of the json is as follows

{
    "Name of Button": [
        "Array of",
        "checkboxes to check"
    ]
}
#>

#Modify the variables and run his code. It will import the current file and add your addition. From there you can create a pull request.

$NameofButton = "WPF" + ""
$commands = @(
    
)

$jsonfile = Get-Content ./config/preset.json | ConvertFrom-Json

#remove if already exists
if($jsonfile.$NameofButton){
    $jsonfile.psobject.Properties.remove($NameofButton)
}

Add-Member -InputObject $jsonfile -MemberType NoteProperty -Name $NameofButton -Value $commands

$jsonfile | ConvertTo-Json | Out-File ./config/preset.json

#===========================================================================
# tweaks.json
#===========================================================================

<#
    tweaks.json
    -----------------
    This file holds all the tweaks needed to make modifications to windows. This file is the most complicated so modify with care.

    The structure of the json is as follows

{
    "Name of button": {
        "registry" : [
            {
                "Path":  "Path in registry",
                "Name":  "Name of Registry key",
                "Type": "Item type",
                "Value":  "Value to modify", 
                "OriginalValue": "value to reset"
            }
        ],
        "service" : [
            {
                "Name":  "Name of service",
                "StartupType":  "Startup type to set", 
                "OriginalType": "Startup type to reset"
            }
        ],
        "ScheduledTask" : [
            {
                "Name":  "Path to scheduled task",
                "State":  "State to set", 
                "OriginalState": "State to reset"
            }
        ],
        "appx": [
            List of appx,
            files to uninstall
        ],
        "InvokeScript": [
            "Script to make modifications not possible with the above types
            Special care needs to be taken here as converting from json to a scriptblock
            can cause weird issues. Please look at the example below to get an idea of how things should work"                 
        ],
        "UndoScript": [
            "Same as above however is meant to undo what you did above"                 
        ]
    }
}
#>

#Modify the variables and run his code. It will import the current file and add your addition. From there you can create a pull request.
#Make sure to uncomment the sections you which to add.

#$Registry = @(
#    #to add more repeat this separated by a comma
#    @{
#        Path = ""
#        Name = ""
#        Type = ""
#        Value = ""
#        OriginalValue = ""
#    }
#)

#$Service = @(
#    #to add more repeat this separated by a comma
#    @{
#        Name = ""
#        StartupType = ""
#        OriginalType = ""
#    }
#)

#$ScheduledTask = @(
#    #to add more repeat this separated by a comma
#    @{
#        Name = ""
#        State = ""
#        OriginalState = ""
#    }
#)

#$Appx = @(
#    ""
#)

#$InvokeScript = @(
#    "" 
#)

#$UndoScript = @(
#    "" 
#)

$NameofButton = "WPF" + ""

$ButtonToAdd = New-Object psobject
$jsonfile = Get-Content ./config/tweaks.json | ConvertFrom-Json

#remove if already exists
if($jsonfile.$NameofButton){
    $jsonfile.psobject.Properties.remove($NameofButton)
}

if($Registry){Add-Member -InputObject $ButtonToAdd -MemberType NoteProperty -Name "registry" -Value $Registry}
if($Service){Add-Member -InputObject $ButtonToAdd -MemberType NoteProperty -Name "service" -Value $Service}
if($ScheduledTask){Add-Member -InputObject $ButtonToAdd -MemberType NoteProperty -Name "ScheduledTask" -Value $ScheduledTask}
if($Appx){Add-Member -InputObject $ButtonToAdd -MemberType NoteProperty -Name "Appx" -Value $Appx}
if($InvokeScript){Add-Member -InputObject $ButtonToAdd -MemberType NoteProperty -Name "InvokeScript" -Value $InvokeScript}
if($UndoScript){Add-Member -InputObject $ButtonToAdd -MemberType NoteProperty -Name "UndoScript" -Value $UndoScript}

Add-Member -InputObject $jsonfile -MemberType NoteProperty -Name $NameofButton -Value $ButtonToAdd

($jsonfile | ConvertTo-Json -Depth 5).replace('\r\n',"`r`n") | Out-File ./config/tweaks.json

#===========================================================================
# dns.json
#===========================================================================

<#
    dns.json
    -----------------
    This file holds all the DNS entries.

    The structure of the json is as follows

{
    "DNS Provider": [
        "Primary": "IP address",
        "Secondary": "IP address"
    ]
}
#>

#Modify the variables and run his code. It will import the current file and add your addition. From there you can create a pull request.

$NameofProvider = "" -replace " ","_"
$IPAddress = @{
    "Primary" = "0.0.0.0"
    "Secondary" = "0.0.0.0"
}

$ButtonToAdd = New-Object psobject
$jsonfile = Get-Content ./config/dns.json | ConvertFrom-Json

#remove if already exists
if($jsonfile.$NameofProvider){
    $jsonfile.psobject.Properties.remove($NameofProvider)
}

Add-Member -InputObject $jsonfile -MemberType NoteProperty -Name $NameofProvider -Value $IPAddress

($jsonfile | ConvertTo-Json -Depth 5).replace('\r\n',"`r`n") | Out-File ./config/dns.json