function Invoke-PSADORelease {
    <#
    .SYNOPSIS
    Trigger an Azure DevOps Release
    
    .DESCRIPTION
    Trigger a Release to run by defining the ReleasedefinitionName.
    After this command has run the release of the pipeline will be queued
    
    .PARAMETER Organization
    The name of the Companyaccount in Azure DevOps. So https://dev.azure.com/{Organization}
    
    .PARAMETER Project
    The name of the Project the release is in. So https://dev.azure.com/{Organization}/{Project}
    
    .PARAMETER BuildDefinitionName
    The name of the release definition that needs to get a new Release queued
    
    .PARAMETER User
    A username, with format user@Company.com
    
    .PARAMETER Token
    the PAT for the connection.
    https://docs.microsoft.com/en-us/azure/devops/organizations/accounts/use-personal-access-tokens-to-authenticate?view=azure-devops
    
    .EXAMPLE
    Invoke-PSADORelease -Organization "Company" -Project "Project01" -ReleaseDefinitionName "Rep-CD"

    Will trigger the Releasedefinition Rep-CI to create a new Release
    
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
    
        [Parameter(Mandatory = $true)]
        [ValidateNotNullorEmpty()]
        [string]$ReleaseDefinitionName,
    
        [Parameter()]
        [ValidateNotNullorEmpty()]
        [string]$User,
    
        [Parameter()]
        [ValidateNotNullorEmpty()]
        [string]$Token
    )
    
    $Header = New-Header -User $User -Token $Token

    [int]$ReleaseId = (Get-PSADOReleaseDefinition -Organization $Organization -Project $Project -ReleaseDefinitionName $ReleaseDefinitionName -User $User -Token $Token).Id

    if ([string]::IsNullOrEmpty($ReleaseId)) {
        throw "BuildDefinition with name $ReleaseDefinitionName was not found"
    }
    
    $body = @{
        "definitionId" = $ReleaseId
    }

    [uri]$uri = "https://vsrm.dev.azure.com/$Organization/$Project/_apis/release/releases?api-version=5.1-preview.8"
    $Result = New-PSADOApi -Uri $uri -Header $Header -Body $body
    Write-output "Release has been queued"
    $Status = Get-PSADORelease -Organization $Organization -Project $Project -ReleaseName $Result.name -User $User -Token $token
    $Status
}
