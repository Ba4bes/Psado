function New-PSADOProject {
    <#
    .SYNOPSIS
    Creates a new Project in Azure DevOps

    .DESCRIPTION
    This function creates a new project. You need to provide a projectName and organizationname
    other parameters will get default values.
    Function will keep track of status till project is created.

    .PARAMETER Project
    The name of the New project that needs to be created.

    .PARAMETER Description
    A description for the project, will be visible in Azure DevOps. Can be left empty

    .PARAMETER SourceControlType
    Select the SourceControltype, GIT or Tfvc. GIT is default.

    .PARAMETER TemplateType
    Select if Templatetype should be Agile, Scrum or CMMI.

    .PARAMETER Organization
    The name of the Companyaccount in Azure DevOps. So https://dev.azure.com/{Organization}

    .PARAMETER User
    A username, with format user@Company.com

    .PARAMETER Token
    the PAT for the connection.
    https://docs.microsoft.com/en-us/azure/devops/organizations/accounts/use-personal-access-tokens-to-authenticate?view=azure-devops

    .EXAMPLE
    New-PSADOProject -Organization Company -Project test -Description "this is a project"

    Creates a project called test in the organization Company, with description "this is a project"

    .NOTES
    Author: Barbara Forbes
    Module: PSAzureDevOps
    https://4bes.nl
    @Ba4bes
    #>

    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
    param(
        [Parameter(Mandatory = $true, Position = 0)]
        [ValidateNotNullorEmpty()]
        [string]$Project,

        [Parameter()]
        [string]$Description = $null,

        [Parameter()]
        [validateset("Git", "Tfvc")]
        [string]$SourceControlType = "Git",

        [Parameter()]
        [ValidateSet("Agile", "Scrum", "CMMI")]
        [string]$TemplateType = "Agile",

        [Parameter()]
        [ValidateNotNullorEmpty()]
        [string]$Organization,

        [Parameter()]
        [ValidateNotNullorEmpty()]
        [string]$User,

        [Parameter()]
        [ValidateNotNullorEmpty()]
        [string]$Token
    )

    $Header = New-Header -User $User -Token $Token

    [uri]$uri = "https://dev.azure.com/$Organization/_apis/projects?api-version=5.0"

    #The templatetypes go by ID. Switch for readability
    switch ($TemplateType) {
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

    if (
        $PSCmdlet.ShouldProcess(
            ("Creating new project {0}" -f $Project),
            ("Would you like to Create the project {0}?" -f $Project),
            "Creating new project"
        )
    ) {
        $Result = New-PSADOApi -Uri $uri -Header $Header -Body $body
    }

    $i = 0
    Write-Output "Project requested, please wait for success"

    if (
        $PSCmdlet.ShouldProcess(
            ("Checking for status for {0}" -f $Project)
        )
    ) {
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
