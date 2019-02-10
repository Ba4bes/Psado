GET https://dev.azure.com/{organization}/{project}/_apis/build/builds?api-version=5.0


$user = "barbara.forbes@ogd.nl"

$base64AuthInfo = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(("{0}:{1}" -f $user,$token)))
$uri = "https://dev.azure.com/OGD/Interne%20ICT/_apis/build/builds?api-version=5.0"
$result = Invoke-RestMethod -Uri $uri -Method Get -ContentType "application/json" -Headers @{Authorization=("Basic {0}" -f $base64AuthInfo)}

return $result.value

