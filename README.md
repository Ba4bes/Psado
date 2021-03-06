# Psado

[![Build Status](https://dev.azure.com/Ba4bes/Psado/_apis/build/status/Ba4bes.Psado?branchName=master)](https://dev.azure.com/Ba4bes/Psado/_build/latest?definitionId=4&branchName=master)

Psado stands for PowerShell Azure DevOps. It is a wrapper around the [Azure DevOps REST API](https://docs.microsoft.com/en-us/rest/api/azure/devops/?view=azure-devops-rest-5.0) so they can be called with Powershell cmdlets.
It focusses on the CICD-Pipeline for now, more might be coming up

With the module just getting started, you are now able to:

- Get information about projects, builds, Releases etc
- Create and remove a project
- Trigger a build and a release

There is also a function provided which will store the Token and Username in the session.

## Common setup

### prerequisites

- You need to have created an Azure DevOps Account
- You need to have a PAT. See this link for Creating one: [link](https://docs.microsoft.com/en-us/azure/devops/organizations/accounts/use-personal-access-tokens-to-authenticate?view=azure-devops). This is used as the token.

### Installation

Install Psado from the [PowerShell Gallery](https://powershellgallery.com):

```powershell
Install-Module -Name Psado -Scope CurrentUser
Import-Module Psado
```

### Create Connection

Run the cmdlet Connect-PSADO to set up a connection. Your Username and Token will be stored in the session so you don't have to enter them again.

```powershell
Connect-PSADO -Organization MyCompany -User "admin@MyCompany.com" -Token "203fn320fh3ainfaowinf23023f9n39naf89wnf9"
```

After that you can use all the other cmdlets without providing credentials

## Examples

### Create a New Project

```cmd
C:\New-PSADOProject -Organization MyCompany -Project "Test" -Description "This is a test"

Project requested, please wait for success
.
.

id                                   status    url                                                                                _links
--                                   ------    ---                                                                                ------
61268dfa-3663-402a-9072-c3b2554c61ad succeeded https://dev.azure.com/MyCompany/_apis/operations/61268dfa-3663-402a-9072-c3b2554c61ad @{self=}
```

### Get the properties for this project

```cmd
C:\> get-PSADOProject -Project "Test"

id             : 5831fde7-4222-4183-8568-2db005cbed1a
name           : Test
description    : This is a test
url            : https://dev.azure.com/MyCompany/_apis/projects/5831fde7-4222-4183-8568-2db005cbed1a
state          : wellFormed
revision       : 67
_links         : @{self=; collection=; web=}
visibility     : private
defaultTeam    : @{id=506e9664-d5c4-4d87-a84c-69bceb3be167; name=Test Team;
                 url=https://dev.azure.com/MyCompany/_apis/projects/5831fde7-4222-4183-8568-2db005cbed1a/teams/506e9664-d5c4-4d87-a84c-69bceb3be167}
lastUpdateTime : 01/01/0001 00:00:00
```

### Get a Releasedefinition

```cmd
C:\> Get-PSADOReleaseDefinition -Project Project01

id          Name
--          ----
1           Project01-CD
```

### Trigger a Release

```cmd
C:\> Invoke-PSADORelease -Organization myCompany -Project Project01 -ReleaseDefinitionName Project01-CD
Release has been queued

Name            Status     Pipeline
----            ------     --------
Release-6       active     Project01-CD
```

See Docs-folder for more documentation. (Generated with PlatyPS )

## Change Log

View Change log [here](CHANGELOG.md)

## To Contribute

Any ideas or contributions are welcome!
Please add an issue with your suggestions.

## Known Issues

View known issues [here](https://github.com/Ba4bes/Psado/issues)
