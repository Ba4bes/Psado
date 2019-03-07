---
external help file: Psado-help.xml
Module Name: Psado
online version:
schema: 2.0.0
---

# Get-PSADOBuildDefinition

## SYNOPSIS
Get a list of Build Definitions and their properties

## SYNTAX

```
Get-PSADOBuildDefinition [-Project] <String> [-BuildDefinitionName <String>] [-BuildDefinitionID <String>]
 [-Organization <String>] [-User <String>] [-Token <String>] [<CommonParameters>]
```

## DESCRIPTION
List Azure DevOps Builds Definitions that belong to a project.
You can list them all, or select builds based on Builnumber or BuildDefinitionID

## EXAMPLES

### EXAMPLE 1
```
Get-PSADOBuildDefinition Company Project01
```

Shows all build definitions for the project Project01 in the Organization Company

Get-PSADOBuild -Organization Company -Project Project01 -BuildDefinitionName Build01

Returns the build definition Build01

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

### -BuildDefinitionName
The Name of the BuildDefinition

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

### -BuildDefinitionID
The ID for the Build Definition

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
Module: Psado
https://4bes.nl
@Ba4bes

## RELATED LINKS
