function Get-PSADOProject {
    param(
        [Parameter(Mandatory = $true)]
        [string]$CompanyName,
        [Parameter()]
        [string]$ProjectName = $null,
        [Parameter()]
        [string]$token,
        [Parameter()]
        [string]$User
    )
    begin {
    Clear-Variable uri -ErrorAction SilentlyContinue
    $base64AuthInfo = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(("{0}:{1}" -f $user, $token)))
    $uri = "https://dev.azure.com/$CompanyName/_apis/projects?api-version=5.0"
    }
    Process {
    $result = Invoke-RestMethod -Uri $uri -Method Get -ContentType "application/json" -Headers @{Authorization = ("Basic {0}" -f $base64AuthInfo)}
    $Projects = $result.value



    if ([string]::IsNullOrEmpty($ProjectName)) {
        return $Projects
    }
    else {
        $uri = ($Projects | Where-Object {$_.name -eq "$projectname"}).url
        if ([string]::IsNullOrEmpty($uri)){
            Return "Project $ProjectName does nog exist"
        }
        else {
        $Project = Invoke-RestMethod -Uri $uri -Method Get -ContentType "application/json" -Headers @{Authorization = ("Basic {0}" -f $base64AuthInfo)}
        Return $project
        }
    }

    }
    End {}
}
