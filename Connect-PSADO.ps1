function Connect-PSADO {
    <#
    .SYNOPSIS
    Retrieves a token.

    .DESCRIPTION
    This cmdlet retrieves a TasToken object containing the login type, token and hostname of the server. The resulting token can be used in other cmdlets in this module. This cmdlet assumes that HTTPS will be used and will not work with HTTP TOPdesk servers.
    Can create the older type of token or the newer 'application password' token.

    .EXAMPLE
    PS C:\> Grant-TasToken -HostName $tasHostName -Credential $tasCredential -LoginType Operator -TimeOutSec 3

    LoginType Token                                HostName
    --------- -----                                --------
    Operator  784b466b-752c-4f10-9a64-4f26111d83dd servicedesk.contoso.com

    Description
    -----------
    This example retrieves a token from the TOPdesk server.

    .NOTES
    None.
    #>
    [CmdletBinding()]
  #  [OutputType('TasToken')]
  #  [Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSAvoidUsingConvertToSecureStringWithPlainText", "")]
    param(
        [Parameter(Mandatory = $true)]
        [string]$CompanyName,
        [Parameter()]
        [string]$User,
        [Parameter()]
        [string]$token

    )
    begin {
        #Encode the credentials so you can perform basic authentication.
        $base64AuthInfo = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(("{0}:{1}" -f $user,$token)))
        $testheader = @{
            Authorization=("Basic {0}" -f $base64AuthInfo)
        }
    #     $base64Credentials = convertToBase64 -String "$( $Credential.UserName ):$( $Credential.GetNetworkCredential().Password )"
    #     $authorization = ConvertTo-SecureString -String "Basic $base64Credentials" -AsPlainText -Force
     }
    process {
            $testUri = "https://dev.azure.com/$CompanyName/_apis/projects?api-version=2.0"

            $testLogin = Invoke-RestMethod -Uri $testUri -Method Get -Headers $testHeader
            if ($null -ne $testLogin) {
                write-host "it works"
                 if ($Global:PSDefaultParameterValues.ContainsKey("*-PSADO*:Token")) {
                     $Global:PSDefaultParameterValues.Item("*-PSADO*:Token") = $tasToken
                 }
                 else {
                     $Global:PSDefaultParameterValues.Add("*-PSADO*:Token", $testheader.Authorization)
                 }
            }
        }
        # catch {
        #     $PSCmdlet.ThrowTerminatingError($PSitem)
        # }

    end {

    }
}
