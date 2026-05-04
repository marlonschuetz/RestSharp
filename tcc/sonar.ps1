$sonarToken = Read-Host "Informe a Sonar token"

dotnet sonarscanner begin `
    /k:"TCC-RestSharp" `
    /d:sonar.host.url="http://localhost:9000" `
    /d:sonar.token="$sonarToken"

dotnet build ..\RestSharp.slnx --force

dotnet sonarscanner end `
    /d:sonar.token="$sonarToken"