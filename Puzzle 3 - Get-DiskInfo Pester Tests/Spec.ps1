https://ironscripter.us/iron-scripter-2019-prelude-challenge-2/

Iron Scripter 2019 Prelude Challenge #2

To continue preparing you for the upcoming battle, the Chairman has arranged another prelude challenge. If the Chairman
is feeling generous, a sample solution may be provided in about a week’s time.

Premise
    You have been given a function from a previous co-worker that you need to maintain. The code does not work as expected
    any more. Correct the function according to your faction’s scripting philosophy and create a Pester test file to unit
    test the code. You do not necessarily have to re-write the function from scratch. This is the code that needs to be
    corrected and serve as the basis of your Pester unit test.

Function Get-DiskInfo {
    [cmdletbinding()]
    Param(
        [Parameter(Position = 0,Mandatory,ValueFromPipeline,ValueFromPipelinebyName)]
        [ValidateNotNullorEmpty()]
        [string]$Computername,
        [ValidatePattern("[C..G]")]
        [string]$Drive = "C",
        [string]$LogPath = $env:temp
    )
    Begin {
        Write-Verbose "Starting $($myinvocation.mycommand)"
        $filename = "{0}_DiskInfo_Errors.txt" -f (Get-Date -format "YYYYMMddhhmm")
        $errorLog = Join-Path -path $LogPath -ChildPath $filename
    }
    Process {
        foreach ($computer in $computername) {
            Write-Verbose "Getting disk information from $computer for drive $($drive.toUpper())"
            try {
                $data = Get-Volume -DriveLetter $drive -CimSession $computr
                $data | Select  Drive,@{Name="SizeGB";Expression = {$_.Size/1gb -as [int]}},
                @{Name="FreeGB";Expression = {$_.SizeRemaining/1GB}},@{Name="PctFree";Expression = {($_.SizeRemaining/$_.size*100)}}
                HealthStatus,@{Name = "Computername";Expression = {$_.PSComputername.toUpper}}
            }
            catch {
                Add-Content -path $errorlog -Value "[$(Get-Date)] Failed to get disk data for drive $drive from $computername"
                Add-Content -path $errorlog -Value "[$(Get-Date)] $($_.exception.message)"
                $newErrors = $True
            }
        }
    }
    End {
        If ((Test-Path -path $errorLog) -AND $newErrors) {
            Write-Warning "Errors have been logged to $errorlog"
        }

        Write-Verbose "Ending $($myinvocation.MyCommand)"
    }
}


Background

    This function should get disk information from one or more computers. It should accept computer names via a parameter and
    from the pipeline and should only get a drive C through G. Errors should be logged to a text file with a file name that
    includes a timestamp value in the form YearMonthDayHourMinute.

    For non-North Americans feel free to adjust the date time format in the function and Pester tests.

Be sure to verify that the logging errors feature works as expected.