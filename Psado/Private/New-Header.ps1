Function New-Header {
    <#
    .SYNOPSIS
    Creates a header for the connection with the Azure DevOps REST API

    .DESCRIPTION
    Creates a header for the connection with the Azure DevOps REST API,
    using the provided Username and Token

    .PARAMETER User
    A username, with format user@Company.com

    .PARAMETER Token
    The PAT for the connection.
    https://docs.microsoft.com/en-us/azure/devops/organizations/accounts/use-personal-access-tokens-to-authenticate?view=azure-devops

    .EXAMPLE
    New-Header -User User@Company.com -Token 203fn320fh3ainfaowinf23023f9n39naf89wnf9

    .NOTES
    Private function
    Author: Barbara Forbes
    Module: Psado
    https://4bes.nl
    @Ba4bes
    #>

    param(
        [Parameter()]
        [String]$User,
        [Parameter()]
        [String]$Token
    )

    $base64AuthInfo = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(("{0}:{1}" -f $User, $Token)))

    $Header = @{
        Authorization = ("Basic {0}" -f $base64AuthInfo)
    }
    Return $Header
}
