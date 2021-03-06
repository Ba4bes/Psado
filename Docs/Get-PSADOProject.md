---
external help file: Psado-help.xml
Module Name: Psado
online version:
schema: 2.0.0
---

# Get-PSADOProject

## SYNOPSIS
Get a list of projects or a single project in Azure DevOps

## SYNTAX

```
Get-PSADOProject [[-Project] <String>] [[-Organization] <String>] [[-User] <String>] [[-Token] <String>]
 [<CommonParameters>]
```

## DESCRIPTION
List Azure DevOps Projects
If a Projectname is provided, details about that project will be returned

## EXAMPLES

### EXAMPLE 1
```
Get-PSADOProject -Organization Company
```

Lists all the projects within the organization

Get-PSADOProject -Organization Company -Project Project01

Returns the properties of the Project named Project01

## PARAMETERS

### -Project
The name of the Project to search for.
So https://dev.azure.com/{Organization}/{Project}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
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
Position: 2
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
Position: 3
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
Position: 4
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
Module: Psado
https://4bes.nl
@Ba4bes

## RELATED LINKS
