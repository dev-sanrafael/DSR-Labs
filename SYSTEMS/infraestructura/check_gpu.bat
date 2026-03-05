@echo off
:: DSR Labs — Standalone Hardware Check (Windows)
:: Este archivo integra la lógica de PowerShell en un solo ejecutable .bat facilitando la ejecución sin errores de permisos.

set "psCommand=powershell -NoProfile -ExecutionPolicy Bypass -Command "$Console = [Console]; $Console::OutputEncoding = [System.Text.Encoding]::UTF8; "

:: Definimos el script de PowerShell como un bloque de comandos
set "psScript="
set "psScript=%psScript% Write-Host '--- DSR Labs: Verificando Virtualización en Windows ---' -ForegroundColor Cyan;"
set "psScript=%psScript% $sysInfo = Get-ComputerInfo -Property 'HyperV*';"
set "psScript=%psScript% if ($sysInfo.HyperVRequirementVirtualizationFirmwareEnabled -eq $true) { Write-Host '[OK] Virtualización habilitada en BIOS/UEFI.' -ForegroundColor Green } else { Write-Host '[ERROR] Virtualización deshabilitada. Revisa tu BIOS (VT-x o AMD-V).' -ForegroundColor Red };"
set "psScript=%psScript% Write-Host '`n--- Verificando GPUs Disponibles ---' -ForegroundColor Cyan;"
set "psScript=%psScript% Get-CimInstance Win32_VideoController | Select-Object Name, AdapterRAM, DriverVersion | ForEach-Object { $ramGB = [math]::Round($_.AdapterRAM / 1GB, 2); Write-Host 'Dispositivo: $($_.Name)'; Write-Host 'VRAM: $ramGB GB'; Write-Host 'Driver: $($_.DriverVersion)'; if ($_.Name -like '*NVIDIA*') { Write-Host '[OK] GPU NVIDIA detectada. Lista para CUDA/Ollama.' -ForegroundColor Green } elseif ($_.Name -like '*AMD*') { Write-Host '[INFO] GPU AMD detectada. Usa ROCm/DirectML.' -ForegroundColor Yellow } };"
set "psScript=%psScript% Write-Host '`n--- Verificando Soporte IOMMU (para Passthrough) ---' -ForegroundColor Cyan;"
set "psScript=%psScript% $iommu = Get-PnpDevice | Where-Object { $_.FriendlyName -like '*IOMMU*' -or $_.FriendlyName -like '*DMA*' };"
set "psScript=%psScript% if ($iommu) { Write-Host '[OK] Soporte IOMMU/DMA detectado.' -ForegroundColor Green } else { Write-Host '[WARNING] No se detectó IOMMU explícito. Esto es normal en muchas PCs de escritorio a menos que se use Proxmox/WSL2 avanzado.' -ForegroundColor Yellow };"
set "psScript=%psScript% Write-Host '`nConstruimos sobre fierro real. DSR Labs.' -ForegroundColor Gray;"

:: Ejecutamos el comando
%psCommand% "%psScript%"

pause
