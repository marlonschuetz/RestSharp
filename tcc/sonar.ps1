#$sonarToken = Read-Host "Informe a Sonar token"
$sonarToken = "sqp_0a43e7fda75a0609b0143aee18508cbbdfec26b2"

dotnet sonarscanner begin `
    /k:"TCC-RestSharp-MagicNumberIssue" `
    /d:sonar.host.url="http://localhost:9000" `
    /d:sonar.token="$sonarToken"

dotnet build ..\RestSharp.slnx --force

dotnet sonarscanner end `
    /d:sonar.token="$sonarToken"