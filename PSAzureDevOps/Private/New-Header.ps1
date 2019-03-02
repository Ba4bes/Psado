Function New-Header {
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

