@echo off
setlocal

set "PROJECT_DIR=%~dp0"
set "PORT=8808"
set "URL=http://127.0.0.1:%PORT%/"

cd /d "%PROJECT_DIR%"

echo ========================================
echo Auto Voicing - Windows One-Click Startup
echo ========================================
echo Project: %PROJECT_DIR%
echo URL:     %URL%
echo.

powershell.exe -NoProfile -ExecutionPolicy Bypass -Command "$conn = Get-NetTCPConnection -LocalPort %PORT% -State Listen -ErrorAction SilentlyContinue; if ($conn) { Write-Host 'ERROR: Port %PORT% is already in use.'; Write-Host ''; $conn | Select-Object LocalAddress, LocalPort, State, OwningProcess | Format-Table -AutoSize; exit 1 }; exit 0"
if errorlevel 1 (
    echo.
    echo Please close the program using port %PORT%, then run this file again.
    pause
    exit /b 1
)

if not exist ".venv\Scripts\python.exe" (
    echo Python virtual environment was not found.
    echo Creating .venv and installing dependencies. This may take a while.
    echo.

    py -3.11 -m venv .venv
    if errorlevel 1 (
        echo.
        echo ERROR: Failed to create .venv with Python 3.11.
        echo Please install Python 3.10, 3.11, or 3.12 and try again.
        pause
        exit /b 1
    )

    ".venv\Scripts\python.exe" -m pip install --upgrade pip
    if errorlevel 1 (
        echo.
        echo ERROR: Failed to upgrade pip.
        pause
        exit /b 1
    )

    ".venv\Scripts\python.exe" -m pip install -e .
    if errorlevel 1 (
        echo.
        echo ERROR: Failed to install project dependencies.
        pause
        exit /b 1
    )
)

echo Starting Gradio. First startup can take 2-3 minutes.
echo A browser window will open automatically when the page is ready.
echo Keep this window open while using Auto Voicing.
echo.

start "Auto Voicing Browser Opener" /min powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%PROJECT_DIR%scripts\open_browser_when_ready.ps1" -Url "%URL%" -TimeoutSeconds 300

".venv\Scripts\python.exe" -u app.py --port %PORT% --device auto
set "EXIT_CODE=%ERRORLEVEL%"

echo.
echo Auto Voicing stopped with exit code %EXIT_CODE%.
pause
exit /b %EXIT_CODE%
