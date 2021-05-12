param(
    [Parameter()]
    [ValidateSet("build", "run", "buildandrun")]
    $do = 'build'
)


if ($do -eq 'build') {
    docker build . -t stopthatastronaut/pwshdummycontainer

    # tag it with the current date to the minute
    $tag = (Get-Date).ToString("yyyyMMddhhmm")

    docker tag stopthatastronaut/pwshdummycontainer stopthatastronaut/pwshdummycontainer:$tag
}
elseif ($do -eq 'run') {
    docker run `
        --env NoNetworkThanks=False `
        stopthatastronaut/pwshdummycontainer
}
elseif ($do -eq 'buildandrun') {
    docker build . -t stopthatastronaut/pwshdummycontainer

    # tag it with the current date to the minute
    $tag = (Get-Date).ToString("yyyyMMddhhmm")

    docker tag stopthatastronaut/pwshdummycontainer stopthatastronaut/pwshdummycontainer:$tag

    docker run `
        --env NoNetworkThanks=False `
        stopthatastronaut/pwshdummycontainer
}