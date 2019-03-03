#Get public and private function definition files.
$Private  = @( Get-ChildItem -Path $PSScriptRoot\Private\*.ps1 -ErrorAction SilentlyContinue )
$Public  = @( Get-ChildItem -Path $PSScriptRoot\Public\*.ps1 -ErrorAction SilentlyContinue )

$Scripts = $Private + $Public
#Dot source the files
Foreach($import in $Scripts){
    Try
    {
        . $import.fullname
    }
    Catch
    {
        Write-Error -Message "Failed to import function $($import.fullname): $_"
    }
}

# if (Test-Path "$PSScriptRoot\Private") {
#     $FunctionList = Get-ChildItem -Path "$PSScriptRoot\Private";

#     foreach ($File in $FunctionList) {
#         . $File.FullName;
#         Write-Verbose -Message ('Importing private function file: {0}' -f $File.FullName);
#     }
# }

# Write-Verbose 'Import Public Functions'

# if (Test-Path "$PSScriptRoot\Public") {
#     $FunctionList = Get-ChildItem -Path "$PSScriptRoot\Public";

#     foreach ($File in $FunctionList) {
#         . $File.FullName;
#         Write-Verbose -Message ('Importing public function file: {0}' -f $File.FullName);
#     }
# }
