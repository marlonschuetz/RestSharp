# $packageId = Read-Host  "Informe o pacote. Ex: MagicNumberCodeFix ou MagicNumberAnalyser"
$packageId = "MagicNumberCodeFix"
$version = Read-Host "Informe a versao do pacote. Ex: 1.0.0"
$source = "https://api.nuget.org/v3/index.json"

$scriptPath = $PSScriptRoot
$solutionRoot = Resolve-Path "$scriptPath\.."

Write-Host "==================================================" -ForegroundColor DarkGray
Write-Host "Instalacao do pacote NuGet em todos os projetos" -ForegroundColor Cyan
Write-Host "==================================================" -ForegroundColor DarkGray
Write-Host "Script localizado em: $scriptPath" -ForegroundColor Gray
Write-Host "Raiz da solution:    $solutionRoot" -ForegroundColor Gray
Write-Host "Pacote:             $packageId" -ForegroundColor Gray
Write-Host "Versao:             $version" -ForegroundColor Gray
Write-Host "Source:             $source" -ForegroundColor Gray
Write-Host "==================================================" -ForegroundColor DarkGray

$solutionFiles = Get-ChildItem -Path $solutionRoot -Filter *.sln -File

if ($solutionFiles.Count -eq 0) {
    Write-Host "Nenhum arquivo .sln encontrado na raiz: $solutionRoot" -ForegroundColor Yellow
}
else {
    Write-Host "Solution encontrada:" -ForegroundColor Green
    $solutionFiles | ForEach-Object {
        Write-Host " - $($_.Name)" -ForegroundColor Gray
    }
}

Write-Host ""
Write-Host "Buscando projetos .csproj..." -ForegroundColor Cyan

$projects = Get-ChildItem -Path $solutionRoot -Recurse -Filter *.csproj -File |
    Where-Object {
        $_.FullName -notlike "*\bin\*" -and
        $_.FullName -notlike "*\obj\*" -and
        $_.FullName -notlike "*\tcc\*"
    }

if ($projects.Count -eq 0) {
    Write-Host "Nenhum projeto .csproj encontrado." -ForegroundColor Red
    exit 1
}

Write-Host "Projetos encontrados: $($projects.Count)" -ForegroundColor Green

$successCount = 0
$errorCount = 0

foreach ($project in $projects) {
    Write-Host ""
    Write-Host "--------------------------------------------------" -ForegroundColor DarkGray
    Write-Host "Projeto: $($project.Name)" -ForegroundColor Cyan
    Write-Host "Caminho: $($project.FullName)" -ForegroundColor Gray
    Write-Host "Instalando pacote..." -ForegroundColor Cyan

    dotnet add $project.FullName package $packageId `
        --version $version `
        --source $source

    if ($LASTEXITCODE -eq 0) {
        Write-Host "Sucesso: pacote instalado em $($project.Name)" -ForegroundColor Green
        $successCount++
    }
    else {
        Write-Host "Erro: falha ao instalar pacote em $($project.Name)" -ForegroundColor Red
        $errorCount++
    }
}

Write-Host ""
Write-Host "==================================================" -ForegroundColor DarkGray
Write-Host "Resumo da instalacao" -ForegroundColor Cyan
Write-Host "==================================================" -ForegroundColor DarkGray
Write-Host "Projetos encontrados: $($projects.Count)" -ForegroundColor Gray
Write-Host "Instalados com sucesso: $successCount" -ForegroundColor Green
Write-Host "Com erro: $errorCount" -ForegroundColor $(if ($errorCount -gt 0) { "Red" } else { "Green" })

if ($errorCount -gt 0) {
    exit 1
}

Write-Host "Finalizado com sucesso." -ForegroundColor Green