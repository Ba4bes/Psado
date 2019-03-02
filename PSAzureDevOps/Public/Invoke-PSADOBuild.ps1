function Invoke-PSADOBuild {
    <#
    .SYNOPSIS
    Invoke an Azure DevOps build to run

    .DESCRIPTION
    List Azure Devops Build for a project.

    .PARAMETER Organization
    Parameter description

    .PARAMETER Project
    Parameter description

    .PARAMETER BuildNumber
    Parameter description

    .PARAMETER Repository
    Parameter description

    .PARAMETER Token
    Parameter description

    .PARAMETER User
    Parameter description

    .EXAMPLE
    An example

    .NOTES
    General notes
    #>

    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [string]$Organization,
        [Parameter(Mandatory = $true)]
        [string]$Project,
        [Parameter()]
        [string]$BuildDefinitionName,
        [Parameter()]
        [string]$Token,
        [Parameter()]
        [string]$User
    )
    begin {
        $base64AuthInfo = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(("{0}:{1}" -f $User, $Token)))
        Clear-Variable uri -ErrorAction SilentlyContinue
    }

    Process {
        $BuildId = (Get-PSADOBuildDefinition -Organization $Organization -Project $Project -BuildName $BuildDefinitionName -User $User -Token $Token).Id
        if ([string]::IsNullOrEmpty($BuildId)) {
            Throw "BuildDefinition with name $BuildDefinitionName was not found"
        }
        $body = @{
            "definition" = @{
                "id" = "$BuildId"
            }
        }


        [uri]$uri = "https://dev.azure.com/$Organization/$Project/_apis/build/builds?api-version=5.0"
        try {
            $Result = Invoke-RestMethod -Uri $uri -Method POST -ContentType "application/json" -Body (convertto-json $body) -Headers @{Authorization = ("Basic {0}" -f $base64AuthInfo)}
        }
        catch {
            Throw "Authentication failed. Please check Organization, username, token and permissions' to be"
        }
        Write-output "Build has been queued"
        $Status = Get-PSADOBuild -Organization $company -Project $Project -BuildNumber $Result.queue.id -User $User -Token $token
        $Status

    }
    end {
    }
}

