function New-PSADOProject {

    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
    param(
        [Parameter(Mandatory = $true)]
        [string]$Organization,
        [Parameter(Mandatory = $true)]
        [string]$Project,
        [Parameter()]
        [string]$Description = $null,
        [Parameter()]
        [validateset("Git", "Tfvc")][string]$SourceControlType = "Git",
        [Parameter()]
        [ValidateSet("Agile", "Scrum", "CMMI")][string]$TemplateType,
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
        [uri]$uri = "https://dev.azure.com/$Organization/_apis/projects?api-version=5.0"

        Switch ($TemplateType) {
            "Agile" {$TemplateID = "adcc42ab-9882-485e-a3ed-7678f01f66bc"}
            "Scrum" {$TemplateID = "6b724908-ef14-45cf-84f8-768b5384da45"}
            "CMMI" {$TemplateID = "27450541-8e31-4150-9947-dc59f998fc01"}
        }

        $body = @{
            "name"         = $Project
            "description"  = $Description
            "capabilities" = @{
                "versioncontrol"  = @{
                    "sourceControlType" = $SourceControlType
                }
                "processTemplate" = @{
                    "templateTypeId" = $TemplateID
                }
            }
        }
    }
    Process {
        if ($PSCmdlet.ShouldProcess(
                ("Creating new project {0}" -f $Project),
                ("Would you like to Create the project {0}?" -f $Project),
                "Creating new project"
            )
        ) {
            $Result = Invoke-RestMethod -Uri $uri -Method POST -Body (convertto-json $body) -ContentType "application/json" -Headers @{Authorization = ("Basic {0}" -f $base64AuthInfo)}

        $errorpage = $result | Select-String  "Azure DevOps Services | Sign In"
        if (($null -ne $errorpage) -or ($null -eq $result)) {
            throw "Authentication failed. Please check Organization, username, token and permissions"
        }
    }
        $i = 0
        Write-output "Project requested, please wait for success"
        if ($PSCmdlet.ShouldProcess(
                ("Checking for status for {0}" -f $Project)
            )
        ) {
            do {
                Write-output "."
                $Status = Invoke-RestMethod -Uri $Result.url -Method GET -ContentType "application/json" -Headers @{Authorization = ("Basic {0}" -f $base64AuthInfo)}
                start-sleep 5
                $i++
            }while ($Status.Status -ne "succeeded" -and $i -le 15)
            if ($i -ge 15) {
                Write-Output "Something went wrong, Project has not been created"
            }
            else {
                Write-Output $Status
            }
        }
    }

    End {

    }
}
