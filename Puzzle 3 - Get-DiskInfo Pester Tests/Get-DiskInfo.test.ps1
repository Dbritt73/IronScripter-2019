[CmdletBinding()]
Param ()

Describe Get-DiskInfo {

    Context -Name 'Gets disk information from one or more computers' -Fixture {

        $FunctionCall = Get-DiskInfo -ComputerName 'Localhost', 'Localhost'

        It 'Returns object type Report.DiskInfo' {

            ($FunctionCall | Get-Member).TypeName[0] | Should be 'Report.DiskInfo'

        }

        It 'Gets information from one or more computers' {

            ($FunctionCall | Measure-Object).Count | should be 2

        }

    }

    Context -Name 'Accepts computer names via parameter and pipeline' -Fixture {

        It 'Accepts computer name via parameter' {

            Get-DiskInfo -ComputerName 'Localhost' | Should be $true

        }

        It 'Accepts computer name via pipeline' {

            'Localhost' | Get-DiskInfo | should be $true

        }

    }

    Context -Name 'Only accepts drive letters C through G' {

        It 'Accepts Drive letter in range of C - G' {

            Get-DiskInfo -ComputerName 'LocalHost' -Drive 'C' | Should be $true

        }

        It 'Rejects drive letters outside of range C - G' {

            {Get-DiskInfo -ComputerName 'LocalHost' -Drive 'H'} | Should Throw

        }

    }

    It 'Errors logged to a text file with a file names that include a timestamp in the form YearMonthDayHourMinute' {}

}