Function New-PSADOApi {
        <#
    .SYNOPSIS
    function to connect with the Azure Devops RestApi with the POST-method

    .DESCRIPTION
    This function uses invoke-restmethod to connect to the Azure Devops RestApi.
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
    Module: PSAzureDevOps
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
    $Result = Invoke-RestMethod -Uri $uri -Method POST -Body (convertto-json $body) -ContentType "application/json" -Headers $Header
    }
    Catch {
        $ErrorCode = $_.Exception.Response.StatusCode.value__
        if ($ErrorCode -eq "401"){
            Throw "Your request was unauthorized, status 401 was returned"
        }
        if ($ErrorCode -eq "400"){
            Throw "Your request returned StatusCodede: 400, Bad Request"
        }
        else {
            Throw "Request returned error: $($_.Exception.Response)"
        }
        # Write-host "Exeption" $_.Exception
        # $errormessage.Exception.Response.StatusCode.value__
        # $UnAuth = $Errormessage | Select-String  "401 (Unauthorized)"
    }
    # $errorpage = $testlogin | Select-String  "Azure DevOps Services | Sign In"
    # if (($null -ne $errorpage) -or ($null -eq $testLogin)) {
    #     Write-error "Authentication failed. Please check Organization, username, token and permissions"
    # }

    $autherror = $result | Select-String  "Azure DevOps Services | Sign In"
    $resourceError = $result | Select-String  "The resource cannot be found"
    if (-NOT[string]::IsNullOrEmpty($autherror)){
        Throw "Authentication failed. Please check Organization, username, token and permissions"
    }
    if (-NOT[string]::IsNullOrEmpty($resourceError)) {
        Throw "Resource was not found, please check OrganizationName"
    }
    if ([string]::IsNullOrEmpty($Result)) {
        Throw "Api did not respond"
    }

    if ($null -ne $Result.value) {
        Return ($Result.Value)
    }
    else {
        Return $Result
    }
}
