if (get-module PSAzureDevOps) { Remove-Module PSAzureDevOps }
Import-Module 'C:\scripts\git\Gitlab - Private\PSAzureDevOps\PSAzureDevops'


#mock variables
$Global:CompanyName = "TestCompany"
$Global:Name1 = "Project1"
$Global:Guid1 = 'de772eae-0f6c-49ba-93d1-b936757b84ef'
$Global:Description1 = "Description1"
$Global:testurl1 = "https://dev.azure.com/$CompanyName/_apis/projects/de772eae-0f6c-49ba-93d1-b936757b84ef"
$Global:Name2 = "Project2"
$Global:Guid2 = 'e5886721-4d09-4a92-8af9-1be895f0156b'
$Global:Description2 = $null
$Global:testurl2 = "https://dev.azure.com/$CompanyName/_apis/projects/e5886721-4d09-4a92-8af9-1be895f0156b"
$Global:ProjectName = "Project1"
$Global:NotExistingProject = "NotExistingProject"

Describe "Testing Get-PSADOProject" {
    Context "Input Organization" {
            it 'Should run when only mandatory parameters are provided' {
                Mock Get-PSADOApi -MockWith {
                    @(
                                [pscustomobject]@{
                                    Name        = $Name1
                                    id          = $Guid1
                                    Description = $Description1
                                    url         = $TestURL1

                                }
                                [pscustomobject]@{
                                    Name        = $Name2
                                    id          = $Name2
                                    Description = $Description2
                                    url         = $TestURL2
                                }
                            )
                    } -ModuleName PSAzureDevOps
                $Resultmp = Get-PSAdoProject -Organization $CompanyName
                $Resultmp[0].Name | Should be $Name1
                $Resultmp[1].Name | Should be $Name2
                $Resultmp[0].id | Should be $Guid1
                $resultmp[2].Description | Should -BeNullOrEmpty
                $Resultmp.Count | Should -BeExactly 2
            }
            it 'Should throw with incorrect mandatory parameters' {
                Mock Get-PSADOApi {
                    Throw "Your request was unauthorized, status 401 was returned"
                } -ModuleName PSAzureDevOps

                { Get-PSAdoProject -Organization "a" } | Should throw "Your request was unauthorized, status 401 was returned"
            }
    }
    Context "Input Project"{
        $script:mockCounter = 0
        Mock Get-PSADOApi -MockWith {
            $script:mockCounter ++
            if ($script:MockCounter -le 1) {
                @(
                    [pscustomobject]@{
                        Name        = $Name1
                        id          = $Guid1
                        Description = $Description1
                        url         = $TestURL1

                    }
                    [pscustomobject]@{
                        Name        = $Name2
                        id          = $Name2
                        Description = $Description2
                        url         = $TestURL2
                    }
                )
            }
            else {
                [pscustomobject]@{
                    Name        = $Name1
                    id          = $Guid1
                    Description = $Description1
                    url         = $TestURL1

                }
            }
        } -ModuleName PSAzureDevOps
        it 'Should run with a ProjectName' {
            $script:mockCounter = 0
            $Resultbn = Get-PSAdoProject -Organization $CompanyName -Project "$Name1"
            $Resultbn | Should -not -BeNullOrEmpty
            $resultbn.Name | should be $Name1
        }
        it 'Should throw with incorrect ProjectName' {
            $script:mockCounter = 0
            $Result = { Get-PSAdoProject -Organization  $CompanyName -Project "$NotExistingProject" }
            $Result | Should throw "Project $NotExistingProject does not exist"

        }

    }
    Context "Authentication"{
        it 'Should throw when wrong token or username are provided' {
            Mock Get-PSADOApi {
                Throw "Authentication failed. Please check Organization, username, token and permissions"
            } -ModuleName PSAzureDevOps
            $Result = { Get-PSAdoProject -Organization $CompanyName -Project $ProjectName -token "bla"}
            $Result | should throw "Authentication failed. Please check Organization, username, token and permissions"
        }
    }
}