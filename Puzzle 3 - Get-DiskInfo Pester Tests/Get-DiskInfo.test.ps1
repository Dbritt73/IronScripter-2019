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

    It 'Accepts computer names via parameter and pipeline' {$true | should be $true}

    It 'Only accepts drive letters C through G' {}

    It 'Errors logged to a text file with a file names that include a timestamp in the form YearMonthDayHourMinute' {}

}