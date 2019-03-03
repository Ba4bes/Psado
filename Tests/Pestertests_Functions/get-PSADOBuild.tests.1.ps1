if (get-module PSAzureDevOps){ Remove-Module PSAzureDevOps }
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


describe 'Testing Get-PSAdoBuild' {
    context 'testing correct input' {
        it 'Should run with only mandatory parameters' {
            $Result = Get-PSADOBuild -CompanyName "OGD" -ProjectName "Interne ICT"
            $Result | Should -not -BeNullOrEmpty
        }
        it 'Should run with buildnumber' {
            $Resultbn = Get-PSADOBuild -CompanyName "OGD" -ProjectName "Interne ICT" -buildnumber 1381
            $Resultbn | Should -not -BeNullOrEmpty
        }
        it 'Should run with Repository' {
            $Resultrep = Get-PSADOBuild -CompanyName "OGD" -ProjectName "Interne ICT" -Repository "SCR_Template"
            $Resultrep | Should -not -BeNullOrEmpty
        }
    }
    context 'testing incorrect input' {
        it 'Should throw with incorrect mandatory parameters' {
            { Get-PSADOBuild -CompanyName "OGD" -ProjectName "2340&$" } | Should throw
            { Get-PSADOBuild -CompanyName "$*%&" -ProjectName "project" } | Should throw
        }
        it 'Should throw with incorrect buildnumber' {
            {  Get-PSADOBuild -CompanyName OGD -ProjectName "Interne ICT" -BuildNumber 1234 } | Should throw "Build 1234 does not exist"
        }
        it 'Should trow with incorrect repository' {
            {Get-PSADOBuild -CompanyName OGD -ProjectName "Interne ICT" -Repository "bla"} | should throw "Builds for repository bla do not exist"
        }
        it 'Should throw when wrong token or username are provided' {
            {Get-PSADOBuild -CompanyName OGD -ProjectName "Interne ICT" -token "bla"} | should throw "Authentication failed. Please check CompanyName, username, token and permissions"

        }
    }
    Context 'testing output'{
        # WIP
    }
}


