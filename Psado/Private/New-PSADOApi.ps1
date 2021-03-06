Function New-PSADOApi {
    <#
    .SYNOPSIS
    Function to connect with the Azure DevOps REST API with the POST-method

    .DESCRIPTION
    This function uses invoke-restmethod to connect to the Azure DevOps REST API.
    It runs some errorhandling on the Results that are returned

    .PARAMETER Uri
    The Uri to connect to.

    .PARAMETER Header
    The Header that was created with New-Header

    .PARAMETER Body
    The body that needs to be used in invoke-restmethod

    .EXAMPLE
    New-PSADOApi -Uri "https://dev.azure.com/$Organization/_apis/projects?api-version=5.0" -Header $Header -Body $Body

    .NOTES
    Private function
    Author: Barbara Forbes
    Module: Psado
    https://4bes.nl
    @Ba4bes
    #>
    Param(
        [Parameter()]
        [uri]$Uri,
        [Parameter()]
        [hashtable]$Header,
        [Parameter()]
        [hashtable]$Body
    )

    Try {
        $Result = Invoke-RestMethod -Uri $uri -Method POST -Body (ConvertTo-Json $body) -ContentType "application/json" -Headers $Header
    }
    Catch {
        $ErrorCode = $_.Exception.Response.StatusCode.value__
        if ($ErrorCode -eq "401") {
             throw "Your request was unauthorized, status 401 was returned"
        }
        if ($ErrorCode -eq "400") {
             throw "Your request returned StatusCodede: 400, Bad Request"
        }
        else {
             throw "Request returned error: $($_.Exception.Response)"
        }
    }

    $autherror = $result | Select-String  "Azure DevOps Services | Sign In"
    $resourceError = $result | Select-String  "The resource cannot be found"
    if (-not [string]::IsNullOrEmpty($autherror)) {
         throw "Authentication failed. Please check Organization, username, token and permissions"
    }
    if (-not [string]::IsNullOrEmpty($resourceError)) {
         throw "Resource was not found, please check OrganizationName"
    }
    if ([string]::IsNullOrEmpty($Result)) {
         throw "Api did not respond"
    }

    if ($null -ne $Result.value) {
        Return ($Result.Value)
    }
    else {
        Return $Result
    }
}
