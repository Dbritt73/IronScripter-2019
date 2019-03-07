Function Copy-WindowsServerRoles {
    [CmdletBinding()]
    Param (

        [String]$Source,

        [string[[]]$Destination

    )

    Begin {

        #$SourceCapability = Invoke-Command -ComputerName $Source -ScriptBlock {Get-WindowsOptionalFeature -Online}
        $SourceCapability = Get-WindowsFeature -ComputerName $Source

    }

    Process {

        foreach ($server in $Destination) {

            Try {

                $CurrentCapability = Get-WindowsFeature -ComputerName $Destination

                foreach ($role in $SourceCapability) {



                }

            } Catch {}

        }

    }

    End {}

}