---
external help file: Psado-help.xml
Module Name: Psado
online version:
schema: 2.0.0
---

# Connect-PSADO

## SYNOPSIS
Create a connection to PSADO, using a PAT

## SYNTAX

```
Connect-PSADO [-Organization] <String> [-User] <String> [-Token] <String> [<CommonParameters>]
```

## DESCRIPTION
This function sets up a connection to Azure DevOps to test the credentials.
If they are correct, the token and username are stored in the current session.

## EXAMPLES

### EXAMPLE 1
```
Connect-PSADO -Organization "Company" -UserName User@Company.com -token 203fn320fh3ainfaowinf23023f9n39naf89wnf9
```

Stores User- and Token-variable in the session so they only have to be provided once.

## PARAMETERS

### -Organization
The name of the Companyaccount in Azure DevOps.
so https://dev.azure.com/{Organization}

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

### -User
A username, with format user@Company.com

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

### -Token
the PAT for the connection.
https://docs.microsoft.com/en-us/azure/devops/organizations/accounts/use-personal-access-tokens-to-authenticate?view=azure-devops

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 3
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
