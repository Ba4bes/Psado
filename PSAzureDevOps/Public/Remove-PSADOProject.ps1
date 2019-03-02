function Remove-PSADOProject {
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'High')]
    param(
        [Parameter(Mandatory = $true)]
        [string]$Organization,
        [Parameter(Mandatory = $true)]
        [string]$Project,
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

    }
    Process {
        $ProjectID = (Get-PSADOProject -Organization $Organization -Project $Project -User $User -token $token).id
        [uri]$uri = "https://dev.azure.com/$Organization/_apis/projects/$($projectID)?api-version=5.0"
        if ($PSCmdlet.ShouldProcess(
                ("Project {0} wil be deleted" -f $Project),
                ("This action will DELETE project {0}, do you want to continue?" -f $Project),
                "Project deletion"
            )
        ) {
            $Result = Invoke-RestMethod -Uri $uri -Method Delete -ContentType "application/json" -Headers @{Authorization = ("Basic {0}" -f $base64AuthInfo)}
            $errorpage = $result | Select-String  "Azure DevOps Services | Sign In"
            if (($null -ne $errorpage) -or ($null -eq $result)) {
                throw "Authentication failed. Please check Organization, username, token and permissions"
            }
            $i = 0
            Write-output "Project removal requested, please wait for success"
            do {
                Write-output "."
                $Status = Invoke-RestMethod -Uri $Result.url -Method GET -ContentType "application/json" -Headers @{Authorization = ("Basic {0}" -f $base64AuthInfo)}
                start-sleep 5
                $i++
            }while ($Status.Status -ne "succeeded" -and $i -le 15)
        }
    }
    End {
        if ($i -ge 15) {
            Write-Output "Something went wrong, Project has not been created"
        }
        else {
            Write-Output $Status
        }
    }
}
