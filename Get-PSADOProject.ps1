function Get-PSADOProject {
     param(
     [Parameter(Mandatory = $true)]
     [string]$CompanyName,
    [Parameter()]
    [string]$ProjectName = $null,
    [Parameter()]
    [string]$token = $token,
    [Parameter()]
    [string]$User = $user
     )

    # $user = "barbara.forbes@ogd.nl"
    # $companyname = "OGD"
    # $ProjectName = "Interne ICT"

    $base64AuthInfo = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(("{0}:{1}" -f $user, $token)))

        $uri = "https://dev.azure.com/$CompanyName/_apis/projects?api-version=5.0"

    $result = Invoke-RestMethod -Uri $uri -Method Get -ContentType "application/json" -Headers @{Authorization = ("Basic {0}" -f $base64AuthInfo)}
    $Projects = $result.value
    if ([string]::IsNullOrEmpty($ProjectName)){
        return $Projects
    }
    else {
        $uri = ($projects | Where-Object {$_.name -like "*$projectname*"}).url
        $Project = Invoke-RestMethod -Uri $uri -Method Get -ContentType "application/json" -Headers @{Authorization = ("Basic {0}" -f $base64AuthInfo)}
        Return $project
    }
}
