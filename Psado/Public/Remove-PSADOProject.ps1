function Remove-PSADOProject {
    <#
    .SYNOPSIS
    Removes a Project from Azure DevOps

    .DESCRIPTION
    This function removes a project. You need to provide a projectName and organizationname
    The function will check if the project exist and remove it.

    .PARAMETER Project
    The name of the New project that needs to be removed.

    .PARAMETER Organization
    The name of the Companyaccount in Azure DevOps. So https://dev.azure.com/{Organization}

    .PARAMETER User
    A username, with format user@Company.com

    .PARAMETER Token
    the PAT for the connection.
    https://docs.microsoft.com/en-us/azure/devops/organizations/accounts/use-personal-access-tokens-to-authenticate?view=azure-devops

    .EXAMPLE
    Remove-PSADOProject -Organization Company -Project test

    Removes the project called test from the organization Company

    .NOTES
    Author: Barbara Forbes
    Module: Psado
    https://4bes.nl
    @Ba4bes
    #>

    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'High')]
    param(
        [Parameter(Mandatory = $true, Position = 0)]
        [string]$Project,

        [Parameter()]
        [ValidateNotNullorEmpty()]
        [string]$Organization,

        [Parameter()]
        [string]$Token,

        [Parameter()]
        [string]$User
    )

    $Header = New-Header -User $User -Token $Token

    $ProjectID = (Get-PSADOProject -Organization $Organization -Project $Project -User $User -token $token).id

    [uri]$uri = "https://dev.azure.com/$Organization/_apis/projects/$($projectID)?api-version=5.0"

    if (
        $PSCmdlet.ShouldProcess(
            ("Project {0} wil be deleted" -f $Project),
            ("This action will DELETE project {0}, do you want to continue?" -f $Project),
            "Project deletion"
        )
    ) {
        $Result = Remove-PSADOApi -Uri $uri -Header $Header
        $i = 0
        Write-Output "Project removal requested, please wait for success"

        do {
            Write-Output "."
            $Status = Get-PSADOApi -Uri $Result.url -Header $Header
            Start-Sleep 5
            $i++
        } while ($Status.Status -ne "succeeded" -and $i -le 15)

        if ($i -ge 15) {
            Write-Output "Something went wrong, Project has not been created"
        }
        else {
            Write-Output $Status
        }
    }
}
