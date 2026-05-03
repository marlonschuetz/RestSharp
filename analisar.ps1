$sonarToken = "sua-chave-aqui"

dotnet sonarscanner begin `
    /k:"TCC-RestSharp" `
    /d:sonar.host.url="http://localhost:9000" `
    /d:sonar.token="$sonarToken"

dotnet build

dotnet sonarscanner end `
    /d:sonar.token="$sonarToken"