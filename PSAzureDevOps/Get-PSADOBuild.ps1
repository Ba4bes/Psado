function Get-PSADOBuild {
    <#
    .SYNOPSIS
    Get information about Builds for a project in Azure DevOps

    .DESCRIPTION
    List Azure Devops Build for a project.

    .PARAMETER CompanyName
    Parameter description

    .PARAMETER ProjectName
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
        [string]$CompanyName,
        [Parameter(Mandatory = $true)]
        [string]$ProjectName,
        [Parameter()]
        [string]$BuildNumber,
        [Parameter()]
        [string]$Repository,
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
        [uri]$uri = "https://dev.azure.com/$companyName/$ProjectName/_apis/build/builds?api-version=5.0"
        try {
        $Result = Invoke-RestMethod -Uri $uri -Method Get -ContentType "application/json" -Headers @{Authorization = ("Basic {0}" -f $base64AuthInfo)}
        }
        catch {
            Throw "Authentication failed. Please check CompanyName, username, token and permissions' to be"
        }
        $Builds = $Result.value

        if ($BuildNumber) {
            $uri = ($Builds | Where-Object {$_.buildNumber -eq "$BuildNumber"}).url
            if ([string]::IsNullOrEmpty($uri)){
            Throw "Build $BuildNumber does not exist"
            }
            else {
            $Builds = Invoke-RestMethod -Uri $uri -Method Get -ContentType "application/json" -Headers @{Authorization = ("Basic {0}" -f $base64AuthInfo)}

            }

        }
        elseif ($Repository) {
            $Builds = $Builds | Where-Object {$_.repository.name -eq $Repository}
            if ($null -eq $Builds){
              Throw "Builds for repository $Repository do not exist"
            }

        }
        else {
            # $Releases

        }
    }
    end {
        foreach ($Build in $Builds){
            $Build.PSObject.TypeNames.Insert(0,'PSADO.ADOBuild')
        }
        $Builds

    }
}

