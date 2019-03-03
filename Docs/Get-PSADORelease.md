---
external help file: PSAzureDevOps-help.xml
Module Name: PSAzureDevops
online version:
schema: 2.0.0
---

# Get-PSADORelease

## SYNOPSIS
Get information about Releases within a project in Azure DevOps

## SYNTAX

```
Get-PSADORelease [-Organization] <String> [-Project] <String> [-ReleaseName <String>]
 [-ReleaseDefinition <String>] [-User <String>] [-Token <String>] [<CommonParameters>]
```

## DESCRIPTION
List Azure Devops Releases that belong to a project.
You can list them all, or select builds based on Buildnumbers or the source repository

## EXAMPLES

### EXAMPLE 1
```
Get-PSADORelease -Organization Company -Project Project01
```

Shows all Releases for the project Project01 in the Organization Company

Get-PSADORelease -Organization Company -Project Project01 -ReleaseDefinition Rep01-CD

Returns all releases that have been pushed for the definition Rep01-CD

## PARAMETERS

### -Organization
The name of the Companyaccount in Azure Devops.
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

### -ReleaseName
The number of the Release that is needed

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

### -ReleaseDefinition
The Definition that the release is based on.

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
