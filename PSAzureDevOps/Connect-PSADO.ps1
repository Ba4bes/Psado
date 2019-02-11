function Connect-PSADO {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [string]$CompanyName,
        [Parameter()]
        [string]$User,
        [Parameter()]
        [string]$token

    )
        #Encode the credentials so you can perform basic authentication.
        $base64AuthInfo = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(("{0}:{1}" -f $user, $token)))
        $testheader = @{
            Authorization = ("Basic {0}" -f $base64AuthInfo)
        }



        $testUri = "https://dev.azure.com/$CompanyName/_apis/projects?api-version=2.0"
        try {
            $testLogin = Invoke-RestMethod -Uri $testUri -Method Get -Headers $testHeader
        }
        catch {
            Write-Error $_
            exit
        }
        $errorpage = $testlogin | Select-String  "Azure DevOps Services | Sign In"
        if (($null -ne $errorpage) -or ($null -eq $testLogin)){
            Write-error "Authentication failed. Please check CompanyName, username, token and permissions"
        }

        if ($PSDefaultParameterValues.ContainsKey("*-PSADO*:Token")) {
            $PSDefaultParameterValues.Item("*-PSADO*:Token") = $Token
        }
        else {
            $PSDefaultParameterValues.Add("*-PSADO*:Token", $Token)
        }
        if ($PSDefaultParameterValues.ContainsKey("*-PSADO*:User")) {
            $PSDefaultParameterValues.Item("*-PSADO*:User") = $User
        }
        else {
            $PSDefaultParameterValues.Add("*-PSADO*:User", $User)
        }

        Write-output "Connection with Azure Devops for $CompanyName has been made"

}
