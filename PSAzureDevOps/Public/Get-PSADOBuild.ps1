function Get-PSADOBuild {
    <#
    .SYNOPSIS
    Get information about Builds within a project in Azure DevOps
    
    .DESCRIPTION
    List Azure DevOps Builds that belong to a project.
    You can list them all, or select builds based on Buildnumbers or the source repository
    
    .PARAMETER Organization
    The name of the Companyaccount in Azure DevOps. So https://dev.azure.com/{Organization}
    
    .PARAMETER Project
    The name of the Project to search within. So https://dev.azure.com/{Organization}/{Project}
    
    .PARAMETER BuildNumber
    The number of the build that is needed
    
    .PARAMETER Repository
    The Name of the source repository that is configured to use the build
    
    .PARAMETER User
    A username, with format user@Company.com
    
    .PARAMETER Token
    the PAT for the connection.
    https://docs.microsoft.com/en-us/azure/devops/organizations/accounts/use-personal-access-tokens-to-authenticate?view=azure-devops
    
    .EXAMPLE
    Get-PSADOBuild -Organization Company -Project Project01

    Shows all builds for the project Project01 in the Organization Company
    
    .EXAMPLE
    Get-PSADOBuild -Organization Company -Project Project01 -Repository Repo01

    Returns all builds that have been queued for repository Repo01

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
        [string]$BuildNumber,
        
        [Parameter()]
        [string]$Repository,
        
        [Parameter()]
        [ValidateNotNullorEmpty()]
        [string]$User,
        
        [Parameter()]
        [ValidateNotNullorEmpty()]
        [string]$Token
    )

    $Header = New-Header -User $User -Token $Token
    
    try {
        $null = Get-PSADOProject -Organization $Organization -Project $Project -User $User -Token $token
    }
    Catch {
         throw "Can't find project with name $Project"
    }
    
    [uri]$uri = "https://dev.azure.com/$Organization/$Project/_apis/build/builds?api-version=5.0"

    $Builds = Get-PSADOApi -Uri $Uri -Header $Header

    if (-not [string]::IsNullOrEmpty($BuildNumber)) {
        [uri]$BuildUri = ($Builds | Where-Object {$_.buildNumber -eq "$BuildNumber"}).url
        if ([string]::IsNullOrEmpty($BuildUri)) {
            throw "Build $BuildNumber does not exist"
        }
        else {
            $Builds = Get-PSADOApi -Uri $BuildUri -Header $Header
        }
    }

    if (-not [string]::IsNullOrEmpty($Repository)) {
        $AllBuilds = New-Object System.Collections.Generic.List[System.Object]
        foreach ($Build in $Builds) {
            if ($Build.repository.type -eq "Github" -and $Build.repository.id -eq "$Repository") {
                $AllBuilds.Add($Build)
            }
            if ($Build.repository.type -eq "TfsGit" -and $Build.repository.name -eq "$Repository") {
                $AllBuilds.Add($Build)
            }
        }
        
        if ($null -eq $AllBuilds) {
             throw "Builds for repository $Repository do not exist"
        }
        $Builds = $AllBuilds
    }

    foreach ($Build in $Builds) {
        $Build.PSObject.TypeNames.Insert(0, 'PSADO.ADOBuild')
    }
    $Builds
}

