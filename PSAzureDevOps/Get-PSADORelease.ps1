
function Get-PSADORelease {
    param(
        [Parameter(Mandatory = $true)]
        [string]$CompanyName,
        [Parameter(Mandatory = $true)]
        [string]$ReleaseName,
        [Parameter()]
        [string]$ReleaseName,
        [Parameter()]
        [string]$SourceRelease,
        [Parameter()]
        [string]$Token,
        [Parameter()]
        [string]$User
    )
    Clear-Variable uri -ErrorAction SilentlyContinue
    #  Clear-Variable collectionVariable -ErrorAction SilentlyContinue
    $base64AuthInfo = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(("{0}:{1}" -f $User, $Token)))
    Write-Verbose "Baseauth: $base64AuthInfo"
    #$ReleaseName = $ReleaseName.Replace(" ","%20")

    [uri]$uri = "https://vsrm.dev.azure.com/$CompanyName/$ReleaseName/_apis/release/releases?api-version=5.0"
    #$uri = "https://vsrm.dev.azure.com/ogd/interne%20ict/_apis/release/releases?api-version=5.0"
    Write-Verbose "Uri: $uri"
    $Result = Invoke-RestMethod -Uri $uri -Method Get -ContentType "application/json" -Headers @{Authorization = ("Basic {0}" -f $base64AuthInfo)}


    $ReleaseValues = $Result.value
    Write-Verbose "Projects: "

    $Releases = New-Object System.Collections.ArrayList
    foreach ($Release in $ReleaseValues) {
        $Properties = [ordered] @{
            Name           = $Release.Name
            ID             = $Release.id
            SourceRelease  = $Release.releasedefinition.name
            Status         = $Release.Status
            CreatedOn      = $Release.CreatedOn
            ModifiedOn     = $Release.ModifiedOn
            ModifiedBy     = $Release.ModifiedBy.uniqueName
            CreatedBy      = $Release.createdBy.uniqueName
            Variables      = $Release.variables
            Variablegroups = $Release.variableGroups
            Descripton     = $Release.description
            keepForever    = $Release.keepForever
            Reason         = $Release.Reason
            ProjectName    = $Release.projectreference.name
        }
        $objRelease = New-Object PSOBject -Property $Properties
        $Releases.Add($objRelease) | Out-Null

    }
    Write-Verbose "releasename: $ReleaseName"
    Write-Verbose "SourceRepo: $SourceRepo"

    if ($ReleaseName) {
        Write-Verbose "hit ReleaseName-loop"
        $Releases | where {$_.name -eq $ReleaseName}
        return
    }
    elseif ($SourceRelease) {
        Write-Verbose "hit SourceRepo-loop"
        $Releases | where {$_.SourceRelease -eq $SourceRelease}
        return
    }
    else {
        Write-Verbose "hit else-loop"
        $Releases
        return
    }
}

