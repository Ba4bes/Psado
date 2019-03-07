function Get-PSADOProject {
    <#
    .SYNOPSIS
    Get a list of projects or a single project in Azure DevOps

    .DESCRIPTION
    List Azure DevOps Projects
    If a Projectname is provided, details about that project will be returned

    .PARAMETER Project
    The name of the Project to search for. So https://dev.azure.com/{Organization}/{Project}

    .PARAMETER Organization
    The name of the Companyaccount in Azure DevOps. So https://dev.azure.com/{Organization}

    .PARAMETER User
    A username, with format user@Company.com

    .PARAMETER Token
    The PAT for the connection.
    https://docs.microsoft.com/en-us/azure/devops/organizations/accounts/use-personal-access-tokens-to-authenticate?view=azure-devops

    .EXAMPLE
    Get-PSADOProject -Organization Company

    Lists all the projects within the organization

    .EXAMPLE
    Get-PSADOProject -Organization Company -Project Project01

    Returns the properties of the Project named Project01

    .NOTES
    Author: Barbara Forbes
    Module: Psado
    https://4bes.nl
    @Ba4bes
    #>

    [CmdletBinding()]
    param(
        [Parameter()]
        [string]$Project,

        [Parameter()]
        [ValidateNotNullorEmpty()]
        [string]$Organization,

        [Parameter()]
        [ValidateNotNullorEmpty()]
        [string]$User,

        [Parameter()]
        [ValidateNotNullorEmpty()]
        [string]$Token
    )

    $Header = New-Header -User $User -Token $Token

    [uri]$uri = "https://dev.azure.com/$Organization/_apis/projects?api-version=5.0"

    $Projects = Get-PSADOApi -Uri $Uri -Header $Header

    if (-not [string]::IsNullOrEmpty($Project)) {
        $ProjectUri = ($Projects | Where-Object {$_.name -eq "$Project"}).url
        if ([string]::IsNullOrEmpty($Projecturi)) {
            throw "Project $Project does not exist"
        }
        else {
            $Projects = Get-PSADOApi -Uri $ProjectUri -Header $Header
        }
    }

    foreach ($Project in $Projects) {
        $Project.PSObject.TypeNames.Insert(0, 'PSADO.ADOProject')
    }
    $Projects
}
