---
external help file: PSAzureDevOps-help.xml
Module Name: PSAzureDevOps
online version:
schema: 2.0.0
---

# Get-PSADOBuild

## SYNOPSIS
Get information about Builds within a project in Azure DevOps

## SYNTAX

```
Get-PSADOBuild [-Project] <String> [-BuildNumber <String>] [-Repository <String>] [-Organization <String>]
 [-User <String>] [-Token <String>] [<CommonParameters>]
```

## DESCRIPTION
List Azure DevOps Builds that belong to a project.
You can list them all, or select builds based on Buildnumbers or the source repository

## EXAMPLES

### EXAMPLE 1
```
Get-PSADOBuild -Organization Company -Project Project01
```

Shows all builds for the project Project01 in the Organization Company

Get-PSADOBuild -Organization Company -Project Project01 -Repository Repo01

Returns all builds that have been queued for repository Repo01

## PARAMETERS

### -Project
The name of the Project to search within.
So https://dev.azure.com/{Organization}/{Project}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -BuildNumber
The number of the build that is needed

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Repository
The Name of the source repository that is configured to use the build

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Organization
The name of the Companyaccount in Azure DevOps.
So https://dev.azure.com/{Organization}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -User
A username, with format user@Company.com

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Token
the PAT for the connection.
https://docs.microsoft.com/en-us/azure/devops/organizations/accounts/use-personal-access-tokens-to-authenticate?view=azure-devops

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
Author: Barbara Forbes
Module: PSAzureDevOps
https://4bes.nl
@Ba4bes

## RELATED LINKS
