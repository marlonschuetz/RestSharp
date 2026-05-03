$diagnosticId = "S109"
$severity = "warn"

$scriptPath = $PSScriptRoot
$solutionRoot = Resolve-Path "$scriptPath\.."
$projectPath = Resolve-Path "$solutionRoot\src\RestSharp\RestSharp.csproj"

Write-Host "==================================================" -ForegroundColor DarkGray
Write-Host "Execucao do dotnet format analyzers" -ForegroundColor Cyan
Write-Host "==================================================" -ForegroundColor DarkGray
Write-Host "Script localizado em: $scriptPath" -ForegroundColor Gray
Write-Host "Raiz da solution:    $solutionRoot" -ForegroundColor Gray
Write-Host "Projeto:            $projectPath" -ForegroundColor Gray
Write-Host "Diagnostic:         $diagnosticId" -ForegroundColor Gray
Write-Host "Severity:           $severity" -ForegroundColor Gray
Write-Host "==================================================" -ForegroundColor DarkGray
Write-Host ""

if (-not (Test-Path $projectPath)) {
    Write-Host "Projeto nao encontrado em: $projectPath" -ForegroundColor Red
    exit 1
}

Write-Host "Iniciando formatacao/analisadores..." -ForegroundColor Cyan

dotnet format analyzers $projectPath `
    --diagnostics $diagnosticId `
    --severity $severity

if ($LASTEXITCODE -ne 0) {
    Write-Host ""
    Write-Host "==================================================" -ForegroundColor DarkGray
    Write-Host "Falha ao executar dotnet format analyzers." -ForegroundColor Red
    Write-Host "Codigo de saida: $LASTEXITCODE" -ForegroundColor Red
    Write-Host "==================================================" -ForegroundColor DarkGray
    exit $LASTEXITCODE
}

Write-Host ""
Write-Host "==================================================" -ForegroundColor DarkGray
Write-Host "dotnet format analyzers finalizado com sucesso." -ForegroundColor Green
Write-Host "Diagnostic processado: $diagnosticId" -ForegroundColor Gray
Write-Host "Projeto processado: $projectPath" -ForegroundColor Gray
Write-Host "==================================================" -ForegroundColor DarkGray