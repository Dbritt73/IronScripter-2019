Function Get-DiskInfo {
  <#
    .SYNOPSIS
    Describe purpose of "Get-DiskInfo" in 1-2 sentences.

    .DESCRIPTION
    Add a more complete description of what the function does.

    .PARAMETER Computername
    Describe parameter -Computername.

    .PARAMETER Drive
    Describe parameter -Drive.

    .PARAMETER LogPath
    Describe parameter -LogPath.

    .EXAMPLE
    Get-DiskInfo -Computername Value -Drive Value -LogPath Value
    Describe what this call does

    .NOTES
    Place additional notes here.

    .LINK
    https://ironscripter.us/iron-scripter-2019-prelude-challenge-2/

    .INPUTS
   [String[]]ComputerName
   [String]Drive
   [String]LogPath

    .OUTPUTS
    Report.DiskInfo
  #>


    [cmdletbinding()]
    Param(

        [Parameter( Position = 0,
                    HelpMessage='Name of computer to query',
                    Mandatory = $True,
                    ValueFromPipeline = $True,
                    ValueFromPipelineByPropertyName = $True)]
        [ValidateNotNullorEmpty()]
        [string[]]$Computername,

        [ValidateScript({[char[]](67..71) -contains $_})]
        [string]$Drive = 'C',

        [string]$LogPath = $env:temp

    )

    Begin {

        Write-Verbose -Message "Starting $($myinvocation.mycommand)"
        $filename = '{0}_DiskInfo_Errors.txt' -f (Get-Date -format 'yyyyMMddhhmm')
        $errorLog = Join-Path -path $LogPath -ChildPath $filename

    }

    Process {

        foreach ($computer in $computername) {

            Write-Verbose -Message "Getting disk information from $computer for drive $($drive.toUpper())"
            try {

                $data = Get-Volume -DriveLetter $drive -CimSession $computer -ErrorAction 'Stop'

                $props = [Ordered]@{

                    'DriveLetter' = $data.DriveLetter
                    'SizeGB' = ($Data.Size / 1GB -as [int])
                    'FreeGB' = ($Data.SizeRemaining / 1GB)
                    'PctFree' = (($Data.SizeRemaining / $Data.Size * 100) -as [int])
                    'HealthStatus' = $Data.HealthStatus
                    'ComputerName' = ($Data.PSComputername).ToUpper()

                }

                $Object = New-Object -TypeName PSObject -Property $props
                $object.PSObject.typenames.insert(0, 'Report.DiskInfo')
                Write-Output -InputObject $Object

            } catch {

                Add-Content -path $errorlog -Value "[$(Get-Date)] Failed to get disk data for drive $drive from $computername"
                Add-Content -path $errorlog -Value "[$(Get-Date)] $($_.exception.message)"
                $newErrors = $True

            }

        }

    }

    End {

        If ((Test-Path -path $errorLog) -AND $newErrors) {

            Write-Warning -Message "Errors have been logged to $errorlog"

        }

        Write-Verbose -Message "Ending $($myinvocation.MyCommand)"

    }

}