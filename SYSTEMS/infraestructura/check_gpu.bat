@echo off
REM DSR Labs — Hardware Check Launcher (Windows)
REM Este archivo lanza el script de PowerShell con los permisos necesarios.

echo Iniciando verificador de hardware DSR Labs...
powershell -ExecutionPolicy Bypass -File "%~dp0check_gpu_windows.ps1"
pause
