@echo off
setlocal
:: DSR Labs — Standalone Hardware Check (Windows)
:: Este archivo integra la lógica de PowerShell de forma robusta.

echo --- DSR Labs: Iniciando Verificador de Hardware ---

powershell -NoProfile -ExecutionPolicy Bypass -Command ^
    "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; " ^
    "Write-Host '--- DSR Labs: Verificando Virtualización en Windows ---' -ForegroundColor Cyan; " ^
    "$sysInfo = Get-ComputerInfo -Property 'HyperV*'; " ^
    "if ($sysInfo.HyperVRequirementVirtualizationFirmwareEnabled -eq $true) { Write-Host '[OK] Virtualización habilitada en BIOS/UEFI.' -ForegroundColor Green } else { Write-Host '[ERROR] Virtualización deshabilitada. Revisa tu BIOS (VT-x o AMD-V).' -ForegroundColor Red }; " ^
    "Write-Host \"`n--- Verificando GPUs Disponibles ---\" -ForegroundColor Cyan; " ^
    "Get-CimInstance Win32_VideoController | Select-Object Name, AdapterRAM, DriverVersion | ForEach-Object { " ^
    "  $ramGB = [math]::Round($_.AdapterRAM / 1GB, 2); " ^
    "  Write-Host \"Dispositivo: $($_.Name)\"; " ^
    "  Write-Host \"VRAM: $ramGB GB\"; " ^
    "  Write-Host \"Driver: $($_.DriverVersion)\"; " ^
    "  if ($_.Name -like '*NVIDIA*') { Write-Host '[OK] GPU NVIDIA detectada. Lista para CUDA/Ollama.' -ForegroundColor Green } " ^
    "  elseif ($_.Name -like '*AMD*') { Write-Host '[INFO] GPU AMD detectada. Usa ROCm/DirectML.' -ForegroundColor Yellow } " ^
    "}; " ^
    "Write-Host \"`n--- Verificando Soporte IOMMU (para Passthrough) ---\" -ForegroundColor Cyan; " ^
    "$iommu = Get-PnpDevice | Where-Object { $_.FriendlyName -like '*IOMMU*' -or $_.FriendlyName -like '*DMA*' }; " ^
    "if ($iommu) { Write-Host '[OK] Soporte IOMMU/DMA detectado.' -ForegroundColor Green } " ^
    "else { Write-Host '[WARNING] No se detectó IOMMU explícito. Esto es normal en notebooks.' -ForegroundColor Yellow }; " ^
    "Write-Host \"`nConstruimos sobre fierro real. DSR Labs.\" -ForegroundColor Gray;"

echo.
pause
