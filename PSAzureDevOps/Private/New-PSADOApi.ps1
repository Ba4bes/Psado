Function New-PSADOApi {
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
