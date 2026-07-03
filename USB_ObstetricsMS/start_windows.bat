@echo off
title Obstetrics Management System
color 0B

setlocal enabledelayedexpansion

cls
echo =====================================================
echo      Obstetrics Management System
echo      Maternity Ward ^| Labor ^& Delivery ^| Postnatal Care
echo =====================================================
echo.
echo  Looking for Python...

:: Try common Python commands
set PY_CMD=
for %%c in (python python3 py) do (
    where %%c >nul 2>&1 && set PY_CMD=%%c && goto check_ver
)

:: Search common install paths
for %%v in (313 312 311 310 39) do (
    if exist "%LOCALAPPDATA%\Programs\Python\Python%%v\python.exe" set "PY_CMD=%LOCALAPPDATA%\Programs\Python\Python%%v\python.exe" && goto check_ver
    if exist "%USERPROFILE%\AppData\Local\Programs\Python\Python%%v\python.exe" set "PY_CMD=%USERPROFILE%\AppData\Local\Programs\Python\Python%%v\python.exe" && goto check_ver
    if exist "C:\Python%%v\python.exe" set "PY_CMD=C:\Python%%v\python.exe" && goto check_ver
    if exist "C:\Programs\Python%%v\python.exe" set "PY_CMD=C:\Programs\Python%%v\python.exe" && goto check_ver
)

goto no_python

:check_ver
echo  [OK] Found: !PY_CMD!
"!PY_CMD!" -c "import sys; exit(0 if sys.version_info>=(3,8) else 1)" >nul 2>&1
if !errorlevel! neq 0 (
    echo.
    echo  [ERROR] Python 3.8 or newer required.
    "!PY_CMD!" --version
    echo  Download: https://www.python.org/downloads/
    pause
    exit /b 1
)

:: Change to script directory
cd /d "%~dp0"

:: Create data folder if missing
if not exist "data\" mkdir data

echo.
echo  Starting server...
echo.

"!PY_CMD!" run.py
set EXIT_CODE=!errorlevel!
if !EXIT_CODE! neq 0 (
    echo.
    echo  [ERROR] Server stopped with code !EXIT_CODE!
    pause
)
goto :eof

:no_python
echo.
echo  [ERROR] Python not found!
echo.
echo  Install Python 3.8+ from:
echo    https://www.python.org/downloads/
echo.
echo  During installation, check "Add Python to PATH"
echo.
echo  Or install from Microsoft Store (search "Python")
echo.
pause
exit /b 1

endlocal
