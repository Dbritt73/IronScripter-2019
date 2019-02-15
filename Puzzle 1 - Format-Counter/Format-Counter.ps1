Function Format-Counter {
  <#
    .SYNOPSIS
    Format-Counter is a function to take the output of Get-Counter and make more readable

    .DESCRIPTION
    Format-Counter take the output of a single or multiple Get-Counter calls and parses the information into a more
    user friendly custom object.

    .PARAMETER InputObject
    The InputObject paramter is of the type Microsoft.PowerShell.Commands.GetCounter.PerformanceCounterSampleSet, which
    is the returned object type when using Get-Counter

    .EXAMPLE
    Format-Counter -InputObject (Get-Counter)

        Timestamp: 02/15/2019 10:56:53


    ComputerName CounterSet                                                 Counter                   Value
    ------------ ----------                                                 -------                   -----
    localhost    network interface(intel[r] ethernet connection [7] i219-v) bytes total/sec           5208.94900036242
    localhost    processor(_total)                                          % processor time          5.12268387538373
    localhost    memory                                                     % committed bytes in use  66.704196638126
    localhost    memory                                                     cache faults/sec          1.99844580869458
    localhost    physicaldisk(_total)                                       % disk time               0.0322248639813879
    localhost    physicaldisk(_total)                                       current disk queue length 0

    .NOTES
    Author: Darrin Britton
    Date: 2/15/2019
    My Solution to puzzle 1 of the 2019 Iron Scripter challenge

    .LINK
    https://ironscripter.us/iron-scripter-2019-is-coming/

    .INPUTS
    Microsoft.PowerShell.Commands.GetCounter.PerformanceCounterSampleSet

    .OUTPUTS
    Format.PerformanceCounter
  #>


    [CmdletBinding()]
    Param (

        [Parameter( ValueFromPipeline = $true,
                    ValueFromPipelineByPropertyName = $true,
                    position = 0,
                    Mandatory = $true,
                    HelpMessage = 'Object of the output from Get-Counter')]
        [object]$InputObject

    )

    Begin {}

    Process {

        foreach ($Obj in $InputObject) {

            foreach ($Counter in $obj.CounterSamples) {

                $props = @{

                    'DateTime' = $Counter.TimeStamp

                    'ComputerName' = ($Counter.path -split '\\')[2]

                    'CounterSet' = (($Counter.path -replace '\\\\', '\') -split '\\')[2]

                    'Counter' = $Counter.path -replace '^.*\\'

                    'Value' = $Counter.CookedValue

                }

                $OutputObject = New-Object -TypeName PSObject -Property $Props
                $OutputObject.PSObject.typenames.insert(0, 'Format.PerformanceCounter')
                Write-Output -InputObject $OutputObject

            }

        }

    }

    End {}

}