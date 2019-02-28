function Get-PSADOProject {
    [CmdletBinding()]
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
        if (-NOT $token) {
            Get-Credential -Message "Please provide username and PAT for Azure Devops"
        }
        $base64AuthInfo = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(("{0}:{1}" -f $user, $token)))
        [uri]$uri = "https://dev.azure.com/$CompanyName/_apis/projects?api-version=5.0"
    }
    Process {

        $Result = Invoke-RestMethod -Uri $uri -Method Get -ContentType "application/json" -Headers @{Authorization = ("Basic {0}" -f $base64AuthInfo)}
        $errorpage = $result | Select-String  "Azure DevOps Services | Sign In"
        if (($null -ne $errorpage) -or ($null -eq $result)) {
            throw "Authentication failed. Please check CompanyName, username, token and permissions"
        }

        $Projects = $Result.value
        if (-NOT[string]::IsNullOrEmpty($ProjectName)) {
            $uri = ($Projects | Where-Object {$_.name -eq "$projectname"}).url
            if ([string]::IsNullOrEmpty($uri)) {
                Throw "Project $ProjectName does not exist"
            }
            else {
                $Projects = Invoke-RestMethod -Uri $uri -Method Get -ContentType "application/json" -Headers @{Authorization = ("Basic {0}" -f $base64AuthInfo)}
                # $Project.PSObject.TypeNames.Insert(0,'PSADO.ADOProject')
                # $Project
            }
        }
    }
    End {
        foreach ($Project in $Projects) {
            $Project.PSObject.TypeNames.Insert(0, 'PSADO.ADOProject')
        }
        $Projects

    }
}
