function Connect-PSADO {
    <#
.SYNOPSIS
Create a connection to PSADO, using a PATkey
.DESCRIPTION
This function sets up a connection to Azure DevOps to test the credentials.
If they are correct, the token and username are stored in the current session.
.PARAMETER CompanyName
The name of the Companyaccount in Azure Devops. so https://dev.azure.com/{companyname}
.PARAMETER User
A username, with format user@Company.com
.PARAMETER Token
the PAT for the connection.
https://docs.microsoft.com/en-us/azure/devops/organizations/accounts/use-personal-access-tokens-to-authenticate?view=azure-devops
.EXAMPLE
Connect-PSADO -CompanyName "Company" -UserName User@Company.com -token 203fn320fh3ainfaowinf23023f9n39naf89wnf9
.NOTES
Part of the PSAzureDevOps-module
Tested in Powershell 5.1
#>


    param(
        [Parameter(Mandatory = $true)]
        [string]$CompanyName,
        [Parameter()]
        [string]$User,
        [Parameter()]
        [String]$Token

    )
    #Encode the credentials so you can perform basic authentication.
    $base64AuthInfo = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(("{0}:{1}" -f $User, $Token)))
    $testheader = @{
        Authorization = ("Basic {0}" -f $base64AuthInfo)
    }
    # a connection is made to test the authentication and store values if they are correct
    $testUri = "https://dev.azure.com/$CompanyName/_apis/projects?api-version=2.0"
    try {
        $testLogin = Invoke-RestMethod -Uri $testUri -Method Get -Headers $testHeader
    }
    catch {
        Write-Error $_
        exit
    }
    $errorpage = $testlogin | Select-String  "Azure DevOps Services | Sign In"
    if (($null -ne $errorpage) -or ($null -eq $testLogin)) {
        Write-error "Authentication failed. Please check CompanyName, username, token and permissions"
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

    Write-output "Connection with Azure Devops for $CompanyName has been made"

}
