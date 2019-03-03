if (get-module PSAzureDevOps) { Remove-Module PSAzureDevOps }
Import-Module 'C:\scripts\git\Gitlab - Private\PSAzureDevOps\PSAzureDevops'


#mock variables
$Global:CompanyName = "TestCompany"
$Global:ProjectName = "Project1"
$Global:BuildNumber1 = '1'
$Global:Result1 = "Success"
$Global:Definition1 = "Rep01"
$Global:BuildNumber2 = '2'
$Global:Result2 = "Failed"
$Global:Definition2 = "Rep02"
$Global:WrongProject = "Wrong"
$Global:User = "user"
$Global:Token = "Token"


Describe "Testing Get-PSADOBuild" {
    Context "Input Organization and Project" {
            it 'Should run when only mandatory parameters are provided' {
                Mock Get-PSADOProject -MockWith {
                    [pscustomobject]@{
                        Name        = $ProjectName
                        id          = $Guid1
                        Description = $Description1
                        url         = $TestURL1

                    }

                } -ModuleName PSAzureDevOps
                Mock Get-PSADOApi -MockWith {
                    @(
                                [pscustomobject]@{
                                    BuildNumber        = $BuildNumber1
                                    Result          = $Result1
                                    Definition = @{
                                        Name = $Definition1
                                        }
                                }
                                [pscustomobject]@{
                                    BuildNumber        = $BuildNumber2
                                    Result          = $Result2
                                    Definition = @{
                                        Name = $Definition2
                                        }
                                }
                            )
                    } -ModuleName PSAzureDevOps
                $Resultmp = Get-PSAdoBuild -Organization $CompanyName -Project $ProjectName
                $Resultmp[0].BuildNumber | Should be $BuildNumber1
                $Resultmp[1].BuildNumber | Should be $Buildnumber2
                $Resultmp[0].result| Should be $Result1
                $Resultmp.Count | Should -BeExactly 2
            }
            it 'Should throw with incorrect mandatory parameters' {
                Mock Get-PSADOApi {
                    Throw "Can't find project with name $WrongProject"
                } -ModuleName PSAzureDevOps

                { Get-PSADOBuild -Organization "a" -Project $WrongProject } | Should throw "Your request was unauthorized, status 401 was returned"
            }
    }
    Context "Input BuildNumber"{
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
    Context "Input Repository"{
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