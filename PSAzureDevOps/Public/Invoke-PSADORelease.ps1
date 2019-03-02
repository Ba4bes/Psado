function Invoke-PSADORelease {
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
        [string]$ReleaseDefinitionName,
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
        [int]$ReleaseId = (Get-PSADOReleaseDefinition -Organization $Organization -Project $Project -ReleaseName $ReleaseDefinitionName -User $User -Token $Token).Id
        if ([string]::IsNullOrEmpty($ReleaseId)){
            Throw "BuildDefinition with name $ReleaseDefinitionName was not found"
        }
        $body = @{
            "definitionId" = $ReleaseId

        }


        [uri]$uri = "https://vsrm.dev.azure.com/$Organization/$Project/_apis/release/releases?api-version=5.1-preview.8"
        try {
        $Result = Invoke-RestMethod -Uri $uri -Method POST -ContentType "application/json" -Body (convertto-json $body) -Headers @{Authorization = ("Basic {0}" -f $base64AuthInfo)}
        }
        catch {
            Throw "Authentication failed. Please check Organization, username, token and permissions' to be"
        }
        $Releases = $Result.value

        if ($ReleaseNumber) {
            $uri = ($Releases | Where-Object {$_.buildNumber -eq "$ReleaseNumber"}).url
            if ([string]::IsNullOrEmpty($uri)){
            Throw "Build $ReleaseNumber does not exist"
            }
            else {
            $Releases = Invoke-RestMethod -Uri $uri -Method Get -ContentType "application/json" -Headers @{Authorization = ("Basic {0}" -f $base64AuthInfo)}

            }

        }
        elseif ($Repository) {
            $Releases = $Releases | Where-Object {$_.repository.name -eq $Repository}
            if ($null -eq $Releases){
              Throw "Builds for repository $Repository do not exist"
            }

        }
        else {
            # $Releases

        }
    }
    end {
        foreach ($Release in $Releases){
            $Release.PSObject.TypeNames.Insert(0,'PSADO.ADOBuild')
        }
        $Releases

    }
}

