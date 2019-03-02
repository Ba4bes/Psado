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

describe 'Testing Get-PSAdoProject' {
    context 'testing correct input' {
        $script:mockCounter = 0
        Mock Invoke-RestMethod -MockWith {
            @{
                Count = 1
                value = @(
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
        } -ModuleName PSAzureDevOps
        it 'Should run with only mandatory parameters' {
            $Resultmp = Get-PSAdoProject -CompanyName "Company"
            $Resultmp[0].Name | Should be $Name1
            $Resultmp[1].Name | Should be $Name2
            $Resultmp[0].id | Should be $Guid1
            $resultmp[2].Description | should -BeNullOrEmpty
        }
        it 'Should run with ProjectName' {
            $script:mockCounter = 0
            Mock Invoke-RestMethod -MockWith {
                $script:mockCounter ++
                if ($script:MockCounter -le 1) {
                    @{
                        Count = 1
                        value = @(
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

            $Resultbn = Get-PSAdoProject -CompanyName "Company" -ProjectName "$Name1"
            $Resultbn | Should -not -BeNullOrEmpty
            $resultbn.Name | should be $Name1
        }
    }

    context 'testing incorrect input' {
        it 'Should throw with incorrect mandatory parameters' {
            Mock Invoke-RestMethod {
                Throw
            } -ModuleName PSAzureDevOps

            { Get-PSAdoProject -CompanyName "@$" } | Should throw
        }
        it 'Should throw with incorrect ProjectName' {
            $script:mockCounter = 0
            Mock Invoke-RestMethod -MockWith {
                $script:mockCounter ++
                if ($script:MockCounter -le 1) {
                    @{
                        Count = 1
                        value = @(
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

            { Get-PSAdoProject -CompanyName  $CompanyName -ProjectName "bla" } | Should throw "Project bla does not exist"}
        it 'Should throw when wrong token or username are provided' {
            Mock Invoke-RestMethod {
                "Azure DevOps Services | Sign In"
            } -ModuleName PSAzureDevOps
            { Get-PSAdoProject -CompanyName $CompanyName -ProjectName $ProjectName -token "bla" } | should throw "Authentication failed. Please check CompanyName, username, token and permissions"

        }
    }
    Context 'testing subfunctions' {
        it 'Should ask for credentials if no token is known'{
            $token = $null
            mock Get-Credential { return crednetials}
        }
        it 'Should convert token to Base64string'{

        }
        it 'Should create an uri with the companyname'{

        }
        it 'should check for an error page'{

        }
        it 'should throw if no errorpage or result are present'{

        }
        it 'Should collect values in projects-variable'{

        }
        it 'Should run when no projectName is provided'{

        }
        it 'should run when a projectName is provided'{

        }
        it 'Should throw when a projectname doesnt exist'{

        }
        it 'Should add a type to the output for formatting'{

        }
    }
}



describe "d" {
    it "i" {
        $script:mockCounter = 0;
        function Get-Something {}
        Mock Get-Something {
            if ($script:mockCounter -eq 0) { "a" } else {   "b"  }
            $script:mockCounter++
        }

        Write-Host (Get-Something)
        Write-Host (Get-Something)
    }
}