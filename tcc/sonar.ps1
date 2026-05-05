#$sonarToken = Read-Host "Informe a Sonar token"
$sonarToken = "sqp_31ea512f70a836e5e2cdafa8908ee870156ef5d3"

dotnet sonarscanner begin `
    /k:"TCC-RestSharp" `
    /d:sonar.host.url="http://localhost:9000" `
    /d:sonar.token="$sonarToken"

dotnet build ..\RestSharp.slnx --force

dotnet sonarscanner end `
    /d:sonar.token="$sonarToken"