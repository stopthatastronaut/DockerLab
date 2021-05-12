
Describe "PSScriptAnalyzer" {
    Context "Should conform to PsScriptAnalyzer" {
        $Rules = Get-ScriptAnalyzerRule # | ? { $_.RuleName -eq 'PSUseDeclaredVarsMoreThanAssignments '}

        Get-ChildItem -Include @("*.ps1", "*.psm1") -recurse | ForEach-Object {
            Write-Host "`tDescribing ", $_.FullName
            $Rules | % {
                It "Should pass the rule $($_.RuleName)" {
                    $sa = Invoke-ScriptAnalyzer -Path $here\$sut # -IncludeRule $_.RuleName # -Verbose
                    $sa | Measure-Object | select-object -expand Count | Should -Be 0
                }
            }
        }
    }
}

Describe "DockerLab" {
    It "does something useful" {
        $true | Should -Be $true
    }
}
