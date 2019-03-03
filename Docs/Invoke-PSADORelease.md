---
external help file: PSAzureDevOps-help.xml
Module Name: PSAzureDevops
online version:
schema: 2.0.0
---

# Invoke-PSADORelease

## SYNOPSIS
Trigger an Azure DevOps Release

## SYNTAX

```
Invoke-PSADORelease [-Organization] <String> [-Project] <String> -ReleaseDefinitionName <String>
 [-User <String>] [-Token <String>] [<CommonParameters>]
```

## DESCRIPTION
Trigger a Release to run by defining the ReleasedefinitionName.
After this command has run the release of the pipeline will be queued

## EXAMPLES

### EXAMPLE 1
```
Invoke-PSADORelease -Organization "Company" -Project "Project01" -ReleaseDefinitionName "Rep-CD"
```

Will trigger the Releasedefinition Rep-CI to create a new Release

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
The name of the Project the release is in.
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
{{Fill ReleaseDefinitionName Description}}

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
