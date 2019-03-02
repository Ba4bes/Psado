
function Get-PSADORelease {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true, Position = 0)]
        [ValidateNotNullorEmpty()]
        [string]$Organization,
        [Parameter(Mandatory = $true, Position = 1)]
        [ValidateNotNullorEmpty()]
        [string]$Project,
        [Parameter()]
        [string]$ReleaseName,
        [Parameter()]
        [string]$Pipeline,
        [ValidateNotNullorEmpty()]
        [string]$User,
        [Parameter()]
        [ValidateNotNullorEmpty()]
        [string]$Token
    )

        $base64AuthInfo = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(("{0}:{1}" -f $User, $Token)))
        Clear-Variable uri -ErrorAction SilentlyContinue

        [uri]$uri = "https://vsrm.dev.azure.com/$Organization/$Project/_apis/release/releases?api-version=5.0"

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

        foreach ($Release in $Releases){
            $Release.PSObject.TypeNames.Insert(0,'PSADO.ADORelease')
        }
        $Releases

}

