﻿$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -replace '\.Tests\.', '.'
. "$here\$sut"

Describe "Get-Container" {
    It "Gets a list of containers in powershell object format" {
        Get-Container | Should Not Be $null
        (Get-Container).TypeName
    } -Skip

    It "Adds an 'imagename' column" {
        Get-Container | Select-Object -expand imagename | Should not be $null
    } -Skip

    It "Only gets exited containers when asked for '-stopped'" {

    } -Skip
}

Describe "Get-Image" {
    It "Can get a list of images" {

    } -Skip

    Mock docker {
        param()

    }

    It "Can filter images by name" {

    } -skip
}

Describe "Get-ImageName" {
    $g = (new-guid | select -expand Guid) -split "-" | select -last 1

    Mock Get-Image {
        return @(
            @{Repository = "stripe-report-runner"; ID = $g }
            @{Repository = "stripe-notyour-image"; ID = "c4c142da0bff" }
            @{Repository = "stripe-notyour-image"; ID = "c4c1bbda0bff" }
            @{Repository = "stripe-report-runner"; ID = "1234456789ee" }
            @{Repository = "stripe-notyour-image"; ID = "c4c142da0bff" }
        )
    }

    It "Can resolve an image name from an ID" { # temp test
        $imagelist = Get-Image
        Get-ImageName -id $g $imagelist | Should -Be "stripe-report-runner"
    } -skip
}

Describe "Remove-Container" {

}

Describe "Remove-Image" {

}
