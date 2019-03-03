function Get-PSADOReleaseDefinition {
     <#
    .SYNOPSIS
    Get a list of Release Definitions and their properties
    .DESCRIPTION
    List Azure Devops Release Definitions that belong to a project.
    You can list them all, or select Releases based on Releasenumber or ReleaseDefinitionID
    .PARAMETER Organization
    The name of the Companyaccount in Azure Devops. So https://dev.azure.com/{Organization}
    .PARAMETER Project
    The name of the Project to search within. So https://dev.azure.com/{Organization}/{Project}
    .PARAMETER ReleaseDefinitionName
    The Name of the ReleaseDefinition
    .PARAMETER ReleaseDefinitionID
    The ID for the Release Definition
    .PARAMETER User
    A username, with format user@Company.com
    .PARAMETER Token
    the PAT for the connection.
    https://docs.microsoft.com/en-us/azure/devops/organizations/accounts/use-personal-access-tokens-to-authenticate?view=azure-devops
    .EXAMPLE
    Get-PSADOReleaseDefinition Company Project01

    Shows all Release definitions for the project Project01 in the Organization Company
    .EXAMPLE
    Get-PSADOReleaseDefinition -Organization Company -Project Project01 -ReleaseDefinitionName Release01

    Returns the Release definition Release01
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
        [string]$ReleaseDefinitionName,
        [Parameter()]
        [string]$ReleaseDefinitionID,
        [Parameter()]
        [ValidateNotNullorEmpty()]
        [string]$User,
        [Parameter()]
        [ValidateNotNullorEmpty()]
        [string]$Token
    )

    $Header = New-Header -User $User -Token $Token

    [uri]$uri = "https://vsrm.dev.azure.com/$Organization/$Project/_apis/release/definitions?api-version=5.1-preview.3"

    $ReleaseDefs = Get-PSADOApi -Uri $Uri -Header $Header

    if ($ReleaseDefinitionName) {
        $ReleaseDefs = $ReleaseDefs | Where-Object {$_.Name -eq $ReleaseDefinitionName}
        if ($null -eq $ReleaseDefs) {
            Throw "ReleaseDefinition with name $ReleaseDefinitionName does not exist"
        }
    }
    elseif ($ReleaseDefinitionID) {
        $ReleaseDefs = $ReleaseDefs | Where-Object {$_.id -eq $ReleaseDefinitionID}
        if ($null -eq $ReleaseDefs) {
            Throw "ReleaseDefinition with ID $ReleaseDefinitionID do not exist"
        }
    }

    foreach ($ReleaseDef in $ReleaseDefs) {
        $ReleaseDef.PSObject.TypeNames.Insert(0, 'PSADO.ADOReleaseDef')
    }
    $ReleaseDefs


}

