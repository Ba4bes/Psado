function Get-PSADOBuildDefinition {
    <#
    .SYNOPSIS
    Get a list of Build Definitions and their properties
    
    .DESCRIPTION
    List Azure DevOps Builds Definitions that belong to a project.
    You can list them all, or select builds based on Builnumber or BuildDefinitionID
    
    .PARAMETER Organization
    The name of the Companyaccount in Azure DevOps. So https://dev.azure.com/{Organization}
    
    .PARAMETER Project
    The name of the Project to search within. So https://dev.azure.com/{Organization}/{Project}
    
    .PARAMETER BuildDefinitionName
    The Name of the BuildDefinition
    
    .PARAMETER BuildDefinitionID
    The ID for the Build Definition
    
    .PARAMETER User
    A username, with format user@Company.com
    
    .PARAMETER Token
    the PAT for the connection.
    https://docs.microsoft.com/en-us/azure/devops/organizations/accounts/use-personal-access-tokens-to-authenticate?view=azure-devops
    
    .EXAMPLE
    Get-PSADOBuildDefinition Company Project01

    Shows all build definitions for the project Project01 in the Organization Company
    
    .EXAMPLE
    Get-PSADOBuildDefinition -Organization Company -Project Project01 -BuildDefinitionName Build01

    Returns the build definition Build01
    
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
        [string]$BuildDefinitionName,
    
        [Parameter()]
        [string]$BuildDefinitionID,
    
        [Parameter()]
        [ValidateNotNullorEmpty()]
        [string]$User,
    
        [Parameter()]
        [ValidateNotNullorEmpty()]
        [string]$Token
    )
    
    $Header = New-Header -User $User -Token $Token

    [uri]$uri = "https://dev.azure.com/$Organization/$Project/_apis/build/definitions?api-version=5.1-preview.7"

    $BuildDefs = Get-PSADOApi -Uri $Uri -Header $Header
    
    if ($BuildDefinitionName) {
        $BuildDefs = $BuildDefs | Where-Object {$_.Name -eq $BuildDefinitionName}
        if ([string]::IsNullOrEmpty($BuildDefs)) {
             throw "BuildDefinition with name $BuildDefinitionName does not exist"
        }
    }

    if ($BuildDefinitionID) {
        $BuildDefs = $BuildDefs | Where-Object {$_.id -eq $BuildDefinitionID}
        if ($null -eq $BuildDefs) {
             throw "BuildDefinition with ID $BuildDefinitionID do not exist"
        }
    }
    
    foreach ($BuildDef in $BuildDefs) {
        $BuildDef.PSObject.TypeNames.Insert(0, 'PSADO.ADOBuildDef')
    }
    $BuildDefs
}
