[CmdletBinding()]
Param ()

Describe Get-DiskInfo {

    Context -Name 'Output Validation' -Fixture {

        $FunctionCall = Get-DiskInfo -ComputerName 'Localhost', 'Localhost'

        It 'Returns object type Report.DiskInfo' {

            ($FunctionCall | Get-Member).TypeName[0] | Should be 'Report.DiskInfo'

        }

        It 'Gets information from one or more computers' {

            ($FunctionCall | Measure-Object).Count | should be 2

        }

    }

    Context -Name 'Parameter Handling' -Fixture {

        It 'Accepts computer name via parameter' {

            Get-DiskInfo -ComputerName 'Localhost' | Should be $true

        }

        It 'Accepts computer name via pipeline' {

            'Localhost' | Get-DiskInfo | should be $true

        }

    }

    Context -Name 'Parameter Validation' {

        It 'Accepts Drive letter in range of C - G' {

            Get-DiskInfo -ComputerName 'LocalHost' -Drive 'C' | Should be $true

        }

        It 'Rejects drive letters outside of range C - G' {

            #Curly braces required to pass test
            {Get-DiskInfo -ComputerName 'LocalHost' -Drive 'H'} | Should Throw

        }

    }

    Context -Name 'Error Logging' -Fixture {

        $LogFile = Get-DiskInfo -ComputerName 'LocalHost' -Drive 'D' 3>&1

        It 'Generates a log file' {

            Test-path ($LogFile -split ' ')[5] | should be $true

        }

        It 'Log file name includes time stamp in the YearMonthDayHourMinute format' {

            $file = Split-Path (($LogFile -split ' ')[5]) -Leaf

            ($file -like "$(Get-Date -format 'yyyyMMddhhmm')*") | should be $true

        }

    }

}