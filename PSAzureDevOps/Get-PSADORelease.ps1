#Broken :(
function Get-PSADORelease {
    param(
        [Parameter(Mandatory = $true)]
        [string]$CompanyName,
        [Parameter(Mandatory = $true)]
        [string]$ProjectName,
        [Parameter()]
        [string]$ReleaseName,
        [Parameter()]
        [string]$SourceRelease,
        [Parameter()]
        [string]$token,
        [Parameter()]
        [string]$User
    )
    Clear-Variable uri -ErrorAction SilentlyContinue
    #  Clear-Variable collectionVariable -ErrorAction SilentlyContinue
    $base64AuthInfo = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(("{0}:{1}" -f $user, $token)))
    Write-Verbose "Baseauth: $base64AuthInfo"
    #$ProjectName = $ProjectName.Replace(" ","%20")

    [uri]$uri = "https://vsrm.dev.azure.com/$CompanyName/$ProjectName/_apis/release/releases?api-version=5.0"
    #$uri = "https://vsrm.dev.azure.com/ogd/interne%20ict/_apis/release/releases?api-version=5.0"
    Write-verbose "Uri: $uri"
    $result = Invoke-RestMethod -Uri $uri -Method Get -ContentType "application/json" -Headers @{Authorization = ("Basic {0}" -f $base64AuthInfo)}
    Write-Verbose "Result:"

    Write-Verbose "Resultvalue ="

    $Projects = $result.value
    Write-verbose "Projects: "

    $collectionVariable = New-Object System.Collections.ArrayList
    foreach ($project in $projects) {
        $NamedReleases = [ordered] @{
            Name           = $Project.Name
            ID             = $Project.id
            SourceRelease     = $Project.releasedefinition.name
            Status         = $Project.Status
            CreatedOn      = $Project.CreatedOn
            ModifiedOn     = $Project.ModifiedOn
            ModifiedBy     = $Project.ModifiedBy.uniqueName
            CreatedBy      = $Project.createdBy.uniqueName
            Variables      = $project.variables
            Variablegroups = $project.variableGroups
            Descripton     = $project.description
            keepForever    = $project.keepForever
            Reason         = $project.Reason
            ProjectName    = $Project.projectreference.name
        }
        $objRelease = New-Object PSOBject -Property $NamedReleases
        $collectionVariable.Add($objRelease) | out-null

    }
    write-verbose "releasename: $ReleaseName"
    Write-verbose "SourceRepo: $SourceRepo"

    if ($ReleaseName) {
        Write-verbose "hit ReleaseName-loop"
        $collectionVariable | where {$_.name -eq $ReleaseName}
        return
    }
    elseif ($SourceRelease) {
        Write-verbose "hit SourceRepo-loop"
        $collectionVariable | where {$_.SourceRelease -eq $SourceRelease}
        return
    }
    else {
        Write-verbose "hit else-loop"
        $collectionVariable
        return
    }
}

