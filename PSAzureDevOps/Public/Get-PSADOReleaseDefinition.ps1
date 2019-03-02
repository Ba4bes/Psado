function Get-PSADOReleaseDefinition {
    <#
    .SYNOPSIS
    Get information about Builds for a project in Azure DevOps

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
        [string]$ReleaseName,
        [Parameter()]
        [string]$ReleaseId,
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
        [uri]$uri = "https://vsrm.dev.azure.com/$Organization/$Project/_apis/release/definitions?api-version=5.1-preview.3"
        try {
        $Result = Invoke-RestMethod -Uri $uri -Method Get -ContentType "application/json" -Headers @{Authorization = ("Basic {0}" -f $base64AuthInfo)}
        }
        catch {
            Throw "Authentication failed. Please check Organization, username, token and permissions' to be"
        }
        $ReleaseDefs = $Result.value

        if ($ReleaseName) {
            $ReleaseDefs = $ReleaseDefs | Where-Object {$_.Name -eq $ReleaseName}
            if ($null -eq $ReleaseDefs){
            Throw "BuildDefinition with name $ReleaseName does not exist"
        }

        }
        elseif ($ReleaseId) {
            $ReleaseDefs = $ReleaseDefs | Where-Object {$_.id -eq $ReleaseId}
            if ($null -eq $ReleaseDefs){
              Throw "BuildDefinition with ID $ReleaseId do not exist"
            }

        }
        else {
            #

        }
    }
    end {
        foreach ($ReleaseDef in $ReleaseDefs){
            $ReleaseDef.PSObject.TypeNames.Insert(0,'PSADO.ADOBuildDef')
        }
        $ReleaseDefs

    }
}

