if (get-module PSAzureDevOps){ Remove-Module PSAzureDevOps }
Import-Module 'C:\scripts\git\Gitlab - Private\PSAzureDevOps\PSAzureDevops'

Describe 'Check comment-based help'{
    Context 'All functions should contain Get-Help'{
      $Commands = (Get-Module PSAzureDevOps).ExportedCommands
       # $Scripts = Get-ChildItem $PSRoot -Include *.ps1, *.psm1, *.psd1 -Recurse
        $TestCases = $Commands.Values  | Foreach-Object {
            @{
                Function = $_.Name
            }
        }
        It "<Function> should contain Comment-Help" -TestCases $TestCases {
            param(
                $Function
            )
            $Help = Get-Help $Function

            $Help.Synopsis | Should -Not -BeNullOrEmpty
            $Help.description | Should -Not -BeNullOrEmpty
            $Help.examples | Should -Not -BeNullOrEmpty

        }
        It "Script <Function> should contain Examples" -TestCases $TestCases {
            param(
                $Function
            )
            $Examples = Get-Help $Function -Examples
            $Examples | Should -Not -BeNullOrEmpty
        }
    }
}