---
external help file: PSAzureDevOps-help.xml
Module Name: PSAzureDevOps
online version:
schema: 2.0.0
---

# Invoke-PSADOBuild

## SYNOPSIS
Trigger an Azure DevOps build

## SYNTAX

```
Invoke-PSADOBuild [-Project] <String> -BuildDefinitionName <String> [-Organization <String>] [-User <String>]
 [-Token <String>] [<CommonParameters>]
```

## DESCRIPTION
Trigger a build to run by defining the builddefinitionName.
After this command has run the build of the pipeline will be queued

## EXAMPLES

### EXAMPLE 1
```
Invoke-PSADOBuild -Organization "Company" -Project "Project01" -BuildDefinitionName "Rep-CI"
```

Will trigger the builddefinition Rep-CI to create a new build

## PARAMETERS

### -Project
The name of the Project the build is in.
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
The name of the build definition that needs to get a new build queued

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
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
