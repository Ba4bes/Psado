function Invoke-PSADOBuild {
    <#
    .SYNOPSIS
    Trigger an Azure DevOps build

    .DESCRIPTION
    Trigger a build to run by defining the builddefinitionName.
    After this command has run the build of the pipeline will be queued

    .PARAMETER Project
    The name of the Project the build is in. So https://dev.azure.com/{Organization}/{Project}

    .PARAMETER BuildDefinitionName
    The name of the build definition that needs to get a new build queued

    .PARAMETER Organization
    The name of the Companyaccount in Azure DevOps. So https://dev.azure.com/{Organization}

    .PARAMETER User
    A username, with format user@Company.com

    .PARAMETER Token
    the PAT for the connection.
    https://docs.microsoft.com/en-us/azure/devops/organizations/accounts/use-personal-access-tokens-to-authenticate?view=azure-devops

    .EXAMPLE
    Invoke-PSADOBuild -Organization "Company" -Project "Project01" -BuildDefinitionName "Rep-CI"

    Will trigger the builddefinition Rep-CI to create a new build

    .NOTES
    Author: Barbara Forbes
    Module: Psado
    https://4bes.nl
    @Ba4bes
    #>

    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true, Position = 0)]
        [ValidateNotNullorEmpty()]
        [string]$Project,

        [Parameter(Mandatory = $true)]
        [ValidateNotNullorEmpty()]
        [string]$BuildDefinitionName,

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

    $BuildId = (Get-PSADOBuildDefinition -Organization $Organization -Project $Project -BuildDefinitionName $BuildDefinitionName -User $User -Token $Token).Id

    if ([string]::IsNullOrEmpty($BuildId)) {
        throw "BuildDefinition with name $BuildDefinitionName was not found"
    }

    $body = @{
        "definition" = @{
            "id" = "$BuildId"
        }
    }

    [uri]$uri = "https://dev.azure.com/$Organization/$Project/_apis/build/builds?api-version=5.0"
    $Result = New-PSADOApi -Uri $uri -Header $Header -Body $body
    Write-output "Build has been queued"
    $Status = Get-PSADOBuild -Organization $Organization -Project $Project -BuildNumber $Result.queue.id -User $User -Token $token
    $Status
}

