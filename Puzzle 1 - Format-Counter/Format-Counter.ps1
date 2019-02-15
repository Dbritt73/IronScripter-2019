Function Format-Counter {
    [CmdletBinding()]
    Param (

        [Parameter( ValueFromPipeline = $true,
                    ValueFromPipelineByPropertyName = $true)]
        [object]$InputObject

    )

    Begin {}

    Process {

        foreach ($Obj in $InputObject) {

            foreach ($Counter in $obj.CounterSamples) {

                $props = [Ordered]@{

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