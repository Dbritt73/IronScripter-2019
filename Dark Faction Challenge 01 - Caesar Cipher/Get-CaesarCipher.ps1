function Get-CaesarCipher {
  <#
    .SYNOPSIS
    Encrypt or decrypt text using a Caesar Cipher

    .DESCRIPTION
    Get-CaesarCipher scrambles and unscrambles text based off a cipher key and shifts the ASCII code of the character by
    a delta of the key

    .PARAMETER Text
    The text you wish to scramble or unscramble

    .PARAMETER Key
    The cipher key, adds or subtracts this value from the cuirrent character ASCII code.

    .PARAMETER Decode
    Use this switch to unscramble text

    .PARAMETER Encode
    Use this switch to scramble text

    .EXAMPLE
    Get-CaesarCipher -Text 'Value' -Key 5 -Encode

    Scrambles the string 'Value' by 5

    .EXAMPLE
    (Get-content .\file.txt -raw) | Get-CaesarCipher -Key 5 -Decode

    Unscrambles the content of file.txt with a cipher key of 5

    .NOTES
    Place additional notes here.

    .LINK
    Original code for Caesar Cipher borrowed from:
    https://rosettacode.org/wiki/Caesar_cipher#PowerShell

    .INPUTS
    List of input types that are accepted by this function.

    .OUTPUTS
    List of output types produced by this function.
  #>

    [Cmdletbinding()]
    Param (

        [Parameter( Mandatory = $true,
                    HelpMessage = 'Text to manipulate',
                    ValueFromPipeline = $true)]
        [string[]]$Text,

        [int]$Key = 1,

        [Parameter(ParameterSetName = 'Decode')]
        [switch]$Decode,

        [Parameter(ParameterSetName = 'Encode')]
        [switch]$Encode

    )

    Begin {

        $ASCIIRange = [char]' '..[char]'~'

    }

    Process {

        $Chars = $Text.ToCharArray()

        foreach ($Char in $Chars) {

            #this if block required to maintain formatting, new line character not in specified ascii range
            if ([int]$Char -in $ASCIIRange) {

                if ($Decode) {

                    $Index = $ASCIIRange.IndexOf([int]$Char)
                    $int = $Index - $Key

                    if ($int -lt 0) {

                        $NewIndex = $int + $ASCIIRange.Length

                    } else {

                        $NewIndex = $int

                    }

                    $char = $ASCIIRange[$NewIndex]

                }

                if ($encode) {

                    $Index = $ASCIIRange.IndexOf([int]$Char)
                    $NewIndex = ($Index + $Key) - $ASCIIRange.Length

                    $char = $ASCIIRange[$NewIndex]

                }

            }

            $Char = [char]$Char
            [string]$OutText += $Char

        }

        $OutText
        $OutText = $null

    }

    End {}

}