function Connect-PSADO {
    <#
    .SYNOPSIS
    Create a connection to PSADO, using a PAT

    .DESCRIPTION
    This function sets up a connection to Azure DevOps to test the credentials.
    If they are correct, the token and username are stored in the current session.
    
    .PARAMETER Organization
    The name of the Companyaccount in Azure DevOps. so https://dev.azure.com/{Organization}
    
    .PARAMETER User
    A username, with format user@Company.com
    
    .PARAMETER Token
    The PAT for the connection.
    https://docs.microsoft.com/en-us/azure/devops/organizations/accounts/use-personal-access-tokens-to-authenticate?view=azure-devops
    
    .EXAMPLE
    Connect-PSADO -Organization "Company" -User User@Company.com -Token 203fn320fh3ainfaowinf23023f9n39naf89wnf9

    Stores User- and Token-variable in the session so they only have to be provided once.
    
    .NOTES
    Author: Barbara Forbes
    Module: PSAzureDevOps
    https://4bes.nl
    @Ba4bes
#>

    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [ValidateNotNullorEmpty()]
        [string]$organization,
    
        [Parameter(Mandatory = $true)]
        [ValidateNotNullorEmpty()]
        [string]$User,
    
        [Parameter(Mandatory = $True)]
        [ValidateNotNullorEmpty()]
        [String]$Token
    )

    # Encode the credentials so you can perform basic authentication.
    $Header = New-Header -User $User -Token $Token
    
    # A connection is made to test the authentication and store values if they are correct
    $testUri = "https://dev.azure.com/$organization/_apis/projects?api-version=2.0"

    try {
        $testLogin = Invoke-RestMethod -Uri $testUri -Method Get -Headers $Header
    }
    catch {
        throw $_
    }

    $errorpage = $testlogin | Select-String  "Azure DevOps Services | Sign In"

    if (($null -ne $errorpage) -or ($null -eq $testLogin)) {
        throw "Authentication failed. Please check Organization, username, token and permissions"
    }

    #Store variables
    if ($Global:PSDefaultParameterValues.ContainsKey("*-PSADO*:Token")) {
        $Global:PSDefaultParameterValues.Item("*-PSADO*:Token") = $Token
    }
    else {
        $Global:PSDefaultParameterValues.Add("*-PSADO*:Token", $Token)
    }

    if ($Global:PSDefaultParameterValues.ContainsKey("*-PSADO*:User")) {
        $Global:PSDefaultParameterValues.Item("*-PSADO*:User") = $User
    }
    else {
        $Global:PSDefaultParameterValues.Add("*-PSADO*:User", $User)
    }

    Write-Output "Connection with Azure DevOps for $organization has been made"
}
