# Necessarily Incomplete thus far

Function Remove-Container {
    [CmdletBinding()]
    param(
        [Switch]$Stopped,
        [String]$Filter = "*",
        [String]$imageId
    )

    <# docker container rm $(docker container ls –aq) #>
    <# docker container prune #>

    $splat = [pscustomobject]@{ Filter = $Filter }
    if ($Stopped) { $splat | Add-Member -Name Stopped -Value $true -MemberType NoteProperty }

    Write-Verbose $splat

    $containers = Get-Container @splat

    Write-Verbose ("Remove-Container Found " + ($containers | measure | select -expand Count) + " containers")

    $containers | % {
        Write-Verbose "removing docker container $($_.names) ($($_.ID))"
        docker rm $_.id
    }
}


Function Get-Container {
    [CmdletBinding()]
    param(
        [Switch]$Stopped,
        [String]$Filter = "*"
    )
    $cimages = Get-Image # a dependency for injection so we don't smash the api

    $statefilter = if ($Stopped) {
        "exited"
    }
    else {
        "*"
    }

    return docker ps -a --format '{{json .}}' |
    ConvertFrom-Json | % {
        $_ | Add-Member -name "imagename" -Value (Get-ImageName $_.image $cimages) -MemberType NoteProperty -PassThru
    } |
    Where-Object { $_.imagename -like $Filter } |
    Where-Object { $_.state -like $statefilter }

}

Function Get-ImageName {
    [CmdletBinding()]
    param($id, $imagelist)
    Write-Verbose ("resolving image $id from a list of " + ($imagelist | measure-object |  select-object -expand count) + " images")
    $imagename = $imagelist |
    Where-Object { $_.id -eq $id } |
    Select-Object -first 1 | # in case we have multiple tagged images with the same ID
    Select-Object -expand Repository
    Write-Verbose "Resolved image name $imagename"
    return $imagename
}

Function Remove-Image {
    [CmdletBinding()]
    param($prefix, $imageId)
}

Function Get-Image {
    return docker image ls --format '{{json .}}' | ConvertFrom-Json
}

Function Stop-Image {
    # what's this doing here?

}