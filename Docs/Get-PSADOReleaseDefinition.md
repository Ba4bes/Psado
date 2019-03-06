---
external help file: PSAzureDevOps-help.xml
Module Name: PSAzureDevops
online version:
schema: 2.0.0
---

# Get-PSADOReleaseDefinition

## SYNOPSIS
Get a list of Release Definitions and their properties

## SYNTAX

```
Get-PSADOReleaseDefinition [-Organization] <String> [-Project] <String> [-ReleaseDefinitionName <String>]
 [-ReleaseDefinitionID <String>] [-User <String>] [-Token <String>] [<CommonParameters>]
```

## DESCRIPTION
List Azure DevOps Release Definitions that belong to a project.
You can list them all, or select Releases based on Releasenumber or ReleaseDefinitionID

## EXAMPLES

### EXAMPLE 1
```
Get-PSADOReleaseDefinition Company Project01
```

Shows all Release definitions for the project Project01 in the Organization Company

Get-PSADORelease -Organization Company -Project Project01 -ReleaseDefinitionName Release01

Returns the Release definition Release01

## PARAMETERS

### -Organization
The name of the Companyaccount in Azure DevOps.
So https://dev.azure.com/{Organization}

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

### -Project
The name of the Project to search within.
So https://dev.azure.com/{Organization}/{Project}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ReleaseDefinitionName
The Name of the ReleaseDefinition

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

### -ReleaseDefinitionID
The ID for the Release Definition

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
