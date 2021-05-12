Function Write-LogEntry {
    param(
        [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
        $message
    )
    begin {}
    process {
        $now = Get-Date -format u
        Write-Output "$now $message"
    }
    end {}
}

Function Invoke-LogGenerator {
    $uri = "https://api.punkapi.com/v2/beers/random"

    Write-LogEntry "Starting Invoke-LogGenerator"

    if ($env:NoNetworkThanks -eq "True") {
        Write-LogEntry "'NoNetworkThanks' was requested, therefore I'm not going to call an API and bring you a tasty beer"
        EXIT
    }

    $beer = Invoke-RestMethod $uri

    if ($null -ne $beer) {

        @(
            "Found a beer!",
            "Its name is: $($beer.name)",
            "The tagline is: $($beer.tagline)",
            "It is described as: $($beer.description)",
            "It was contributed by: $($beer.contributed_by)",
            "It can be found again using the url: https://api.punkapi.com/v2/beers/$($beer.id)"
        ) | Write-LogEntry

    }
    else {
        Write-LogEntry "I didn't find a beer. I have no idea what happened"
    }

}

Invoke-LogGenerator