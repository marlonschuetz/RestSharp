$diagnosticId = "S109"
$severity = "warn"

$scriptPath = $PSScriptRoot
$solutionRoot = Resolve-Path "$scriptPath\.."

Write-Host "==================================================" -ForegroundColor DarkGray
Write-Host "Execucao do dotnet format analyzers na solution" -ForegroundColor Cyan
Write-Host "==================================================" -ForegroundColor DarkGray
Write-Host "Script localizado em: $scriptPath" -ForegroundColor Gray
Write-Host "Raiz da solution:    $solutionRoot" -ForegroundColor Gray
Write-Host "Diagnostic:         $diagnosticId" -ForegroundColor Gray
Write-Host "Severity:           $severity" -ForegroundColor Gray
Write-Host "==================================================" -ForegroundColor DarkGray
Write-Host ""

$solutionFiles = Get-ChildItem -Path $solutionRoot -Filter *.sln -File

if ($solutionFiles.Count -eq 0) {
    Write-Host "Nenhum arquivo .sln encontrado na raiz: $solutionRoot" -ForegroundColor Red
    exit 1
}

if ($solutionFiles.Count -gt 1) {
    Write-Host "Mais de uma solution encontrada na raiz." -ForegroundColor Yellow
    Write-Host "Usando a primeira encontrada:" -ForegroundColor Yellow
}

$solutionPath = $solutionFiles[0].FullName

Write-Host "Solution selecionada: $solutionPath" -ForegroundColor Green
Write-Host ""
Write-Host "Iniciando formatacao/analisadores..." -ForegroundColor Cyan

dotnet format analyzers $solutionPath `
    --diagnostics $diagnosticId `
    --severity $severity

if ($LASTEXITCODE -ne 0) {
    Write-Host ""
    Write-Host "==================================================" -ForegroundColor DarkGray
    Write-Host "Falha ao executar dotnet format analyzers." -ForegroundColor Red
    Write-Host "Codigo de saida: $LASTEXITCODE" -ForegroundColor Red
    Write-Host "Solution processada: $solutionPath" -ForegroundColor Gray
    Write-Host "==================================================" -ForegroundColor DarkGray
    exit $LASTEXITCODE
}

Write-Host ""
Write-Host "==================================================" -ForegroundColor DarkGray
Write-Host "dotnet format analyzers finalizado com sucesso." -ForegroundColor Green
Write-Host "Diagnostic processado: $diagnosticId" -ForegroundColor Gray
Write-Host "Solution processada: $solutionPath" -ForegroundColor Gray
Write-Host "==================================================" -ForegroundColor DarkGray