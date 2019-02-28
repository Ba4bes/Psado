
function Get-PSADORelease {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [string]$CompanyName,
        [Parameter(Mandatory = $true)]
        [string]$ProjectName,
        [Parameter()]
        [string]$ReleaseName,
        [Parameter()]
        [string]$Pipeline,
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
        [uri]$uri = "https://vsrm.dev.azure.com/$CompanyName/$ProjectName/_apis/release/releases?api-version=5.0"

        $Result = Invoke-RestMethod -Uri $uri -Method Get -ContentType "application/json" -Headers @{Authorization = ("Basic {0}" -f $base64AuthInfo)}


        $Releases = $Result.value

        if ($ReleaseName) {
            Write-Verbose "hit ReleaseName-loop"
            $Releases = $Releases | Where-Object {$_.name -eq $ReleaseName}
            https://vsrm.dev.azure.com/ {organization}/ {project}/_apis/release/releases/ {releaseId}?api-version=5.0

        }
        elseif ($Pipeline) {
            $Releases = $Releases | Where-Object {$_.releasedefinition.name -eq $Pipeline}

        }
        else {
            # $Releases

        }
    }
    end {
        foreach ($Release in $Releases){
            $Release.PSObject.TypeNames.Insert(0,'PSADO.ADORelease')
        }
        $Releases
    }
}

