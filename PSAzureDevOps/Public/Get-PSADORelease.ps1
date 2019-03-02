
function Get-PSADORelease {
        <#
    .SYNOPSIS
    Get information about Releases within a project in Azure DevOps
    .DESCRIPTION
    List Azure Devops Releases that belong to a project.
    You can list them all, or select builds based on Buildnumbers or the source repository
    .PARAMETER Organization
    The name of the Companyaccount in Azure Devops. So https://dev.azure.com/{Organization}
    .PARAMETER Project
    The name of the Project to search within. So https://dev.azure.com/{Organization}/{Project}
    .PARAMETER ReleaseName
    The number of the Release that is needed
    .PARAMETER ReleaseDefinition
    The Definition that the release is based on.
    .PARAMETER User
    A username, with format user@Company.com
    .PARAMETER Token
    the PAT for the connection.
    https://docs.microsoft.com/en-us/azure/devops/organizations/accounts/use-personal-access-tokens-to-authenticate?view=azure-devops
    .EXAMPLE
    Get-PSADORelease -Organization Company -Project Project01

    Shows all Releases for the project Project01 in the Organization Company

    Get-PSADORelease -Organization Company -Project Project01 -ReleaseDefinition Rep01-CD

    Returns all releases that have been pushed for the definition Rep01-CD

    .NOTES
    Author: Barbara Forbes
    Module: PSAzureDevOps
    https://4bes.nl
    @Ba4bes
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true, Position = 0)]
        [ValidateNotNullorEmpty()]
        [string]$Organization,
        [Parameter(Mandatory = $true, Position = 1)]
        [ValidateNotNullorEmpty()]
        [string]$Project,
        [Parameter()]
        [string]$ReleaseName,
        [Parameter()]
        [string]$ReleaseDefinition,
        [ValidateNotNullorEmpty()]
        [string]$User,
        [Parameter()]
        [ValidateNotNullorEmpty()]
        [string]$Token
    )

    $Header = New-Header -User $User -Token $Token  
    [uri]$uri = "https://vsrm.dev.azure.com/$Organization/$Project/_apis/release/releases?api-version=5.0"

    $Releases = Get-PSADOApi -Uri $Uri -Header $Header

    if ($ReleaseName) {
        $Releases = $Releases | Where-Object {$_.name -eq $ReleaseName}
    }
    elseif ($ReleaseDefinition) {
        $Releases = $Releases | Where-Object {$_.releasedefinition.name -eq $ReleaseDefinition}
    }

    foreach ($Release in $Releases) {
        $Release.PSObject.TypeNames.Insert(0, 'PSADO.ADORelease')
    }
    $Releases

}

