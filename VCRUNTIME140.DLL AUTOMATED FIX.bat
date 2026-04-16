@echo off
setlocal DisableDelayedExpansion

:: ============================================================
::  VCRUNTIME140.DLL AUTOMATED FIX
::  Supports: Windows 10 / Windows 11 (x86 and x64)
::  Created by: 404 Brain Found (YouTube)
::  https://www.youtube.com/@404brainfound
:: ============================================================

:: 1. Check for Admin Rights
net session >nul 2>&1
if %errorLevel% == 0 goto :StartFix

:: 2. Inform the user and request elevation
echo.
echo ########################################################
echo #  This fix requires Administrative Permissions.        #
echo #  Please click 'Yes' on the upcoming Windows prompt.   #
echo ########################################################
echo.

:: Show a lightweight message box via mshta (no WPF overhead)
mshta "javascript:var sh=new ActiveXObject('WScript.Shell');sh.Popup('This script needs to run as Administrator to install the system libraries.\n\nPlease confirm the next Windows prompt.',0,'Admin Permission Required',64);close();" >nul 2>&1

:: Create a temporary VBScript to relaunch elevated
set "batchPath=%~dpnx0"
set "vbsPath=%temp%\getadmin_%random%.vbs"

>"%vbsPath%" (
    echo Set UAC = CreateObject^("Shell.Application"^)
    echo UAC.ShellExecute "cmd.exe", "/c """"" ^& "%batchPath%" ^& """""", "", "runas", 1
)

:: Run the VBScript, clean up, and exit the non-admin instance
cscript //nologo "%vbsPath%"
del /f /q "%vbsPath%" >nul 2>&1
exit /b 1

:: ============================================================
:StartFix
:: ============================================================
cls
title VCRUNTIME140.DLL Automated Fix - by 404 Brain Found
echo.
echo ======================================================
echo    VCRUNTIME140.DLL AUTOMATED FIX [ADMIN MODE]
echo ======================================================
echo        Created by: 404 Brain Found (YouTube)
echo ======================================================
echo.

:: 3. Detect system architecture
set "arch=x64"
set "archLabel=64-bit"
if "%PROCESSOR_ARCHITECTURE%"=="x86" (
    if not defined PROCESSOR_ARCHITEW6432 (
        set "arch=x86"
        set "archLabel=32-bit"
    )
)
echo   Detected architecture: %archLabel%
echo.

:: 4. Define download URLs (Visual Studio 2015-2022 Redistributable)
set "url_x64=https://aka.ms/vs/17/release/vc_redist.x64.exe"
set "url_x86=https://aka.ms/vs/17/release/vc_redist.x86.exe"

:: 5. Download the appropriate installer(s)
echo [Step 1/4] Downloading Visual C++ Redistributable (%archLabel%)...

:: Always install x86 (most apps need it), and x64 if on 64-bit OS
powershell -NoProfile -Command ^
    "try { $ProgressPreference='SilentlyContinue'; Invoke-WebRequest -Uri '%url_x86%' -OutFile '%temp%\vc_redist_x86.exe' -UseBasicParsing -ErrorAction Stop; Write-Host '           x86 download OK' } catch { Write-Host '           x86 download FAILED: ' $_.Exception.Message; exit 1 }"
if %errorLevel% neq 0 goto :DownloadFailed

if "%arch%"=="x64" (
    powershell -NoProfile -Command ^
        "try { $ProgressPreference='SilentlyContinue'; Invoke-WebRequest -Uri '%url_x64%' -OutFile '%temp%\vc_redist_x64.exe' -UseBasicParsing -ErrorAction Stop; Write-Host '           x64 download OK' } catch { Write-Host '           x64 download FAILED: ' $_.Exception.Message; exit 1 }"
    if !errorLevel! neq 0 goto :DownloadFailed
)

:: 6. Install silently
echo.
echo [Step 2/4] Installing x86 redistributable...
start /wait "" "%temp%\vc_redist_x86.exe" /install /quiet /norestart
if %errorLevel% neq 0 if %errorLevel% neq 1638 if %errorLevel% neq 3010 (
    echo           WARNING: x86 installer returned error code %errorLevel%
) else (
    echo           x86 install OK
)

if "%arch%"=="x64" (
    echo [Step 3/4] Installing x64 redistributable...
    start /wait "" "%temp%\vc_redist_x64.exe" /install /quiet /norestart
    if %errorLevel% neq 0 if %errorLevel% neq 1638 if %errorLevel% neq 3010 (
        echo           WARNING: x64 installer returned error code %errorLevel%
    ) else (
        echo           x64 install OK
    )
)

:: 7. Verify the DLL now exists
echo.
echo [Step 4/4] Verifying installation...
set "dllFound=0"
if exist "%SystemRoot%\System32\vcruntime140.dll" set "dllFound=1"
if exist "%SystemRoot%\SysWOW64\vcruntime140.dll" set "dllFound=1"

:: 8. Cleanup
del /f /q "%temp%\vc_redist_x86.exe" >nul 2>&1
del /f /q "%temp%\vc_redist_x64.exe" >nul 2>&1

:: 9. Report result
echo.
if "%dllFound%"=="1" (
    echo ======================================================
    echo    SUCCESS! vcruntime140.dll is now installed.
    echo    Please restart your computer if the issue persists.
    echo ======================================================
) else (
    echo ======================================================
    echo    WARNING: vcruntime140.dll was not found after
    echo    installation. A reboot may be required, or you
    echo    may need to install manually from:
    echo    https://aka.ms/vs/17/release/vc_redist.x64.exe
    echo ======================================================
)
echo.
echo ------------------------------------------------------
echo   Tool by: 404 Brain Found
echo   YouTube: https://www.youtube.com/@404brainfound
echo   If this helped, please like and subscribe!
echo ------------------------------------------------------
echo.
pause
exit /b 0

:: ============================================================
:DownloadFailed
:: ============================================================
echo.
echo ======================================================
echo    DOWNLOAD FAILED. Please check your internet
echo    connection and try again. If the problem persists,
echo    download manually from:
echo    https://learn.microsoft.com/en-us/cpp/windows/latest-supported-vc-redist
echo ======================================================
echo.
echo ------------------------------------------------------
echo   Tool by: 404 Brain Found
echo   YouTube: https://www.youtube.com/@404brainfound
echo ------------------------------------------------------
echo.
pause
exit /b 1
