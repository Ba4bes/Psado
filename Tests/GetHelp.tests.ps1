$projectRoot = Resolve-Path "$PSScriptRoot\.."
$moduleRoot = Split-Path (Resolve-Path "$projectRoot\*\*.psm1")
$moduleName = Split-Path $moduleRoot -Leaf

Describe 'Check comment-based help' {
    Context 'All functions should contain Comment-based Help' {
        $Commands = (Get-Module PSAzureDevOps).ExportedCommands
        
        $TestCases = $Commands.Values | Foreach-Object {
            @{
                Function = $_.Name
            }
        }

        It "<Function> should contain Comment-based Help" -TestCases $TestCases {
            param(
                $Function
            )

            $Help = Get-Help $Function

            $Help.Synopsis | Should -Not -BeNullOrEmpty
            $Help.Description | Should -Not -BeNullOrEmpty
            $Help.Examples | Should -Not -BeNullOrEmpty
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
