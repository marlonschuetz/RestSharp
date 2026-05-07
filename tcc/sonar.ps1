# $sonarToken = Read-Host "Informe a Sonar token"
$sonarToken = "sqp_8e9da468f85d42d5295a535a2a80658c4e5f4c4d"

dotnet sonarscanner begin `
    /k:"TCC-RestSharp-S109" `
    /d:sonar.host.url="http://localhost:9000" `
    /d:sonar.token="$sonarToken"

dotnet build ..\RestSharp.slnx --force

dotnet sonarscanner end `
    /d:sonar.token="$sonarToken"