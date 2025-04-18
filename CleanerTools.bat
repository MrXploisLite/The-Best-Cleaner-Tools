@echo off
title Advanced Cleaner Tools v2.0 - System Maintenance Utility
color 0A
setlocal enabledelayedexpansion
mode con: cols=80 lines=40

:: Set version info
set "VERSION=2.0"
set "BUILD_DATE=2025-04-18"

:: Define colors for messages
set "INFO_COLOR=[92m"    :: Green
set "WARN_COLOR=[93m"    :: Yellow
set "ERROR_COLOR=[91m"   :: Red
set "SUCCESS_COLOR=[96m" :: Cyan
set "RESET_COLOR=[0m"    :: Reset

:: Create log directory if it doesn't exist
if not exist "%USERPROFILE%\CleanerTools\Logs" mkdir "%USERPROFILE%\CleanerTools\Logs"
set "LOG_FILE=%USERPROFILE%\CleanerTools\Logs\CleanerTools_%date:~-4,4%%date:~-7,2%%date:~-10,2%_%time:~0,2%%time:~3,2%%time:~6,2%.log"
set "LOG_FILE=%LOG_FILE: =0%"

:: Initialize log file
echo Advanced Cleaner Tools v%VERSION% - Log started at %date% %time% > "%LOG_FILE%"
echo ------------------------------------------------------------ >> "%LOG_FILE%"

:: Check for admin privileges
echo Checking for administrator privileges...
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo %ERROR_COLOR%Administrator privileges required!%RESET_COLOR%
    echo %ERROR_COLOR%Please run this script as administrator.%RESET_COLOR%
    echo Administrator privileges check failed. >> "%LOG_FILE%"
    pause
    exit /b 1
)
echo Administrator privileges confirmed. >> "%LOG_FILE%"

:MENU
cls
echo %INFO_COLOR%
echo  ╔═══════════════════════════════════════════════════════════════════════╗
echo  ║                                                                       ║
echo  ║   █████╗ ██████╗ ██╗   ██╗ █████╗ ███╗   ██╗ ██████╗███████╗██████╗  ║
echo  ║  ██╔══██╗██╔══██╗██║   ██║██╔══██╗████╗  ██║██╔════╝██╔════╝██╔══██╗ ║
echo  ║  ███████║██║  ██║██║   ██║███████║██╔██╗ ██║██║     █████╗  ██║  ██║ ║
echo  ║  ██╔══██║██║  ██║╚██╗ ██╔╝██╔══██║██║╚██╗██║██║     ██╔══╝  ██║  ██║ ║
echo  ║  ██║  ██║██████╔╝ ╚████╔╝ ██║  ██║██║ ╚████║╚██████╗███████╗██████╔╝ ║
echo  ║  ╚═╝  ╚═╝╚═════╝   ╚═══╝  ╚═╝  ╚═╝╚═╝  ╚═══╝ ╚═════╝╚══════╝╚═════╝  ║
echo  ║                                                                       ║
echo  ║                    CLEANER TOOLS UTILITY v%VERSION%                      ║
echo  ║                                                                       ║
echo  ╚═══════════════════════════════════════════════════════════════════════╝%RESET_COLOR%
echo.

echo %SUCCESS_COLOR%  ╔═══════════════════════╗   ╔═══════════════════════════════╗%RESET_COLOR%
echo %SUCCESS_COLOR%  ║    CLEANING TOOLS     ║   ║      SYSTEM MAINTENANCE       ║%RESET_COLOR%
echo %SUCCESS_COLOR%  ╠═══════════════════════╣   ╠═══════════════════════════════╣%RESET_COLOR%
echo %SUCCESS_COLOR%  ║%RESET_COLOR% [1] Temporary Files    %SUCCESS_COLOR%║   ║%RESET_COLOR% [8] System Health Check        %SUCCESS_COLOR%║%RESET_COLOR%
echo %SUCCESS_COLOR%  ║%RESET_COLOR% [2] Browser Caches      %SUCCESS_COLOR%║   ║%RESET_COLOR% [9] Disk Space Analyzer        %SUCCESS_COLOR%║%RESET_COLOR%
echo %SUCCESS_COLOR%  ║%RESET_COLOR% [3] Windows Log Files   %SUCCESS_COLOR%║   ║%RESET_COLOR% [10] Startup Manager           %SUCCESS_COLOR%║%RESET_COLOR%
echo %SUCCESS_COLOR%  ║%RESET_COLOR% [4] Disk Cleanup        %SUCCESS_COLOR%║   ║%RESET_COLOR% [11] Memory Optimizer          %SUCCESS_COLOR%║%RESET_COLOR%
echo %SUCCESS_COLOR%  ║%RESET_COLOR% [5] Recycle Bin         %SUCCESS_COLOR%║   ║%RESET_COLOR% [12] Create System Restore     %SUCCESS_COLOR%║%RESET_COLOR%
echo %SUCCESS_COLOR%  ║%RESET_COLOR% [6] Advanced Cleaning   %SUCCESS_COLOR%║   ║%RESET_COLOR% [13] Schedule Cleaning Tasks   %SUCCESS_COLOR%║%RESET_COLOR%
echo %SUCCESS_COLOR%  ║%RESET_COLOR% [7] All Cleaning Tasks  %SUCCESS_COLOR%║   ║%RESET_COLOR% [14] View Cleaning Logs        %SUCCESS_COLOR%║%RESET_COLOR%
echo %SUCCESS_COLOR%  ╚═══════════════════════╝   ╚═══════════════════════════════╝%RESET_COLOR%
echo.
echo %WARN_COLOR%  [0] Exit Program%RESET_COLOR%
echo.

echo %INFO_COLOR%  Current System: %COMPUTERNAME% ^| User: %USERNAME% ^| Date: %DATE%%RESET_COLOR%
echo %INFO_COLOR%  Last Cleaned: Checking...%RESET_COLOR%
echo.

set /p choice=Enter your choice (0-14):

if "%choice%"=="0" goto EXIT
if "%choice%"=="1" goto CLEAN_TEMP
if "%choice%"=="2" goto CLEAN_BROWSERS
if "%choice%"=="3" goto CLEAN_LOGS
if "%choice%"=="4" goto DISK_CLEANUP
if "%choice%"=="5" goto EMPTY_RECYCLE
if "%choice%"=="6" goto ADVANCED_CLEANING
if "%choice%"=="7" goto CLEAN_ALL
if "%choice%"=="8" goto SYSTEM_HEALTH
if "%choice%"=="9" goto DISK_ANALYZER
if "%choice%"=="10" goto STARTUP_MANAGER
if "%choice%"=="11" goto MEMORY_OPTIMIZER
if "%choice%"=="12" goto SYSTEM_RESTORE
if "%choice%"=="13" goto SCHEDULE_TASKS
if "%choice%"=="14" goto VIEW_LOGS
echo %WARN_COLOR%Invalid choice. Please try again.%RESET_COLOR%
timeout /t 2 >nul
goto MENU

:CLEAN_TEMP
cls
echo %INFO_COLOR%╔════════════════════════════════════════════════════════════════╗%RESET_COLOR%
echo %INFO_COLOR%║                  CLEANING TEMPORARY FILES                     ║%RESET_COLOR%
echo %INFO_COLOR%╚════════════════════════════════════════════════════════════════╝%RESET_COLOR%
echo.

:: Log the operation
echo Temporary files cleaning started at %date% %time% >> "%LOG_FILE%"

:: Calculate initial disk space
for /f "tokens=3" %%a in ('dir c:\ ^| findstr /C:"bytes free"') do set "SPACE_BEFORE=%%a"
echo Initial free disk space: %SPACE_BEFORE% bytes >> "%LOG_FILE%"

:: Create progress bar function
call :SHOW_PROGRESS 0 "Starting temporary files cleanup..."

echo %INFO_COLOR%Cleaning Windows Temp folder...%RESET_COLOR%
call :SHOW_PROGRESS 10 "Cleaning Windows Temp folder..."
del /q /f /s "%TEMP%\*.*" 2>nul
echo Windows Temp folder cleaned >> "%LOG_FILE%"

echo %INFO_COLOR%Cleaning Windows Temporary folder...%RESET_COLOR%
call :SHOW_PROGRESS 20 "Cleaning Windows Temporary folder..."
del /q /f /s "%SystemRoot%\Temp\*.*" 2>nul
echo Windows Temporary folder cleaned >> "%LOG_FILE%"

echo %INFO_COLOR%Cleaning Prefetch folder...%RESET_COLOR%
call :SHOW_PROGRESS 30 "Cleaning Prefetch folder..."
del /q /f /s "%SystemRoot%\Prefetch\*.*" 2>nul
echo Prefetch folder cleaned >> "%LOG_FILE%"

echo %INFO_COLOR%Cleaning Windows Update Download folder...%RESET_COLOR%
call :SHOW_PROGRESS 40 "Cleaning Windows Update Download folder..."
del /q /f /s "%SystemRoot%\SoftwareDistribution\Download\*.*" 2>nul
echo Windows Update Download folder cleaned >> "%LOG_FILE%"

echo %INFO_COLOR%Cleaning Thumbnail Cache...%RESET_COLOR%
call :SHOW_PROGRESS 50 "Cleaning Thumbnail Cache..."
del /q /f /s "%LocalAppData%\Microsoft\Windows\Explorer\thumbcache_*.db" 2>nul
echo Thumbnail Cache cleaned >> "%LOG_FILE%"

echo %INFO_COLOR%Cleaning Windows Defender Cache...%RESET_COLOR%
call :SHOW_PROGRESS 60 "Cleaning Windows Defender Cache..."
del /q /f /s "%ProgramData%\Microsoft\Windows Defender\Scans\History\*" 2>nul
echo Windows Defender Cache cleaned >> "%LOG_FILE%"

echo %INFO_COLOR%Cleaning Font Cache...%RESET_COLOR%
call :SHOW_PROGRESS 70 "Cleaning Font Cache..."
del /q /f /s "%WinDir%\ServiceProfiles\LocalService\AppData\Local\FontCache\*" 2>nul
echo Font Cache cleaned >> "%LOG_FILE%"

echo %INFO_COLOR%Cleaning Windows Store Cache...%RESET_COLOR%
call :SHOW_PROGRESS 80 "Cleaning Windows Store Cache..."
wsreset.exe >nul 2>&1
echo Windows Store Cache cleaned >> "%LOG_FILE%"

echo %INFO_COLOR%Cleaning DNS Cache...%RESET_COLOR%
call :SHOW_PROGRESS 90 "Cleaning DNS Cache..."
ipconfig /flushdns >nul 2>&1
echo DNS Cache cleaned >> "%LOG_FILE%"

call :SHOW_PROGRESS 100 "Temporary files cleaning completed!"

:: Calculate space saved
for /f "tokens=3" %%a in ('dir c:\ ^| findstr /C:"bytes free"') do set "SPACE_AFTER=%%a"
set /a SPACE_SAVED=%SPACE_AFTER%-%SPACE_BEFORE%
echo Final free disk space: %SPACE_AFTER% bytes >> "%LOG_FILE%"
echo Space saved: %SPACE_SAVED% bytes >> "%LOG_FILE%"

echo.
echo %SUCCESS_COLOR%Temporary files cleaning completed!%RESET_COLOR%
echo %SUCCESS_COLOR%Space saved: %SPACE_SAVED% bytes%RESET_COLOR%
echo.
pause
goto MENU

:CLEAN_BROWSERS
cls
echo %INFO_COLOR%╔════════════════════════════════════════════════════════════════╗%RESET_COLOR%
echo %INFO_COLOR%║                  CLEANING BROWSER CACHES                     ║%RESET_COLOR%
echo %INFO_COLOR%╚════════════════════════════════════════════════════════════════╝%RESET_COLOR%
echo.

:: Log the operation
echo Browser cache cleaning started at %date% %time% >> "%LOG_FILE%"

:: Calculate initial disk space
for /f "tokens=3" %%a in ('dir c:\ ^| findstr /C:"bytes free"') do set "SPACE_BEFORE=%%a"
echo Initial free disk space: %SPACE_BEFORE% bytes >> "%LOG_FILE%"

call :SHOW_PROGRESS 0 "Starting browser cache cleanup..."

echo %INFO_COLOR%Cleaning Google Chrome cache...%RESET_COLOR%
call :SHOW_PROGRESS 10 "Cleaning Chrome cache..."
if exist "%LOCALAPPDATA%\Google\Chrome\User Data\Default\Cache" (
    del /q /f /s "%LOCALAPPDATA%\Google\Chrome\User Data\Default\Cache\*.*" 2>nul
    del /q /f /s "%LOCALAPPDATA%\Google\Chrome\User Data\Default\Code Cache\*.*" 2>nul
    del /q /f /s "%LOCALAPPDATA%\Google\Chrome\User Data\Default\Storage\*.*" 2>nul
    echo %SUCCESS_COLOR%Chrome cache cleaned!%RESET_COLOR%
    echo Chrome cache cleaned >> "%LOG_FILE%"
) else (
    echo %WARN_COLOR%Chrome cache not found.%RESET_COLOR%
    echo Chrome cache not found >> "%LOG_FILE%"
)

echo %INFO_COLOR%Cleaning Microsoft Edge cache...%RESET_COLOR%
call :SHOW_PROGRESS 20 "Cleaning Edge cache..."
if exist "%LOCALAPPDATA%\Microsoft\Edge\User Data\Default\Cache" (
    del /q /f /s "%LOCALAPPDATA%\Microsoft\Edge\User Data\Default\Cache\*.*" 2>nul
    del /q /f /s "%LOCALAPPDATA%\Microsoft\Edge\User Data\Default\Code Cache\*.*" 2>nul
    del /q /f /s "%LOCALAPPDATA%\Microsoft\Edge\User Data\Default\Storage\*.*" 2>nul
    echo %SUCCESS_COLOR%Edge cache cleaned!%RESET_COLOR%
    echo Edge cache cleaned >> "%LOG_FILE%"
) else (
    echo %WARN_COLOR%Edge cache not found.%RESET_COLOR%
    echo Edge cache not found >> "%LOG_FILE%"
)

echo %INFO_COLOR%Cleaning Mozilla Firefox cache...%RESET_COLOR%
call :SHOW_PROGRESS 30 "Cleaning Firefox cache..."
if exist "%LOCALAPPDATA%\Mozilla\Firefox\Profiles" (
    del /q /f /s "%LOCALAPPDATA%\Mozilla\Firefox\Profiles\*\cache2\*.*" 2>nul
    del /q /f /s "%LOCALAPPDATA%\Mozilla\Firefox\Profiles\*\startupCache\*.*" 2>nul
    del /q /f /s "%LOCALAPPDATA%\Mozilla\Firefox\Profiles\*\thumbnails\*.*" 2>nul
    echo %SUCCESS_COLOR%Firefox cache cleaned!%RESET_COLOR%
    echo Firefox cache cleaned >> "%LOG_FILE%"
) else (
    echo %WARN_COLOR%Firefox cache not found.%RESET_COLOR%
    echo Firefox cache not found >> "%LOG_FILE%"
)

echo %INFO_COLOR%Cleaning Opera cache...%RESET_COLOR%
call :SHOW_PROGRESS 40 "Cleaning Opera cache..."
if exist "%APPDATA%\Opera Software\Opera Stable\Cache" (
    del /q /f /s "%APPDATA%\Opera Software\Opera Stable\Cache\*.*" 2>nul
    del /q /f /s "%APPDATA%\Opera Software\Opera Stable\Code Cache\*.*" 2>nul
    echo %SUCCESS_COLOR%Opera cache cleaned!%RESET_COLOR%
    echo Opera cache cleaned >> "%LOG_FILE%"
) else (
    echo %WARN_COLOR%Opera cache not found.%RESET_COLOR%
    echo Opera cache not found >> "%LOG_FILE%"
)

echo %INFO_COLOR%Cleaning Brave Browser cache...%RESET_COLOR%
call :SHOW_PROGRESS 50 "Cleaning Brave cache..."
if exist "%LOCALAPPDATA%\BraveSoftware\Brave-Browser\User Data\Default\Cache" (
    del /q /f /s "%LOCALAPPDATA%\BraveSoftware\Brave-Browser\User Data\Default\Cache\*.*" 2>nul
    del /q /f /s "%LOCALAPPDATA%\BraveSoftware\Brave-Browser\User Data\Default\Code Cache\*.*" 2>nul
    echo %SUCCESS_COLOR%Brave cache cleaned!%RESET_COLOR%
    echo Brave cache cleaned >> "%LOG_FILE%"
) else (
    echo %WARN_COLOR%Brave cache not found.%RESET_COLOR%
    echo Brave cache not found >> "%LOG_FILE%"
)

echo %INFO_COLOR%Cleaning Vivaldi cache...%RESET_COLOR%
call :SHOW_PROGRESS 60 "Cleaning Vivaldi cache..."
if exist "%LOCALAPPDATA%\Vivaldi\User Data\Default\Cache" (
    del /q /f /s "%LOCALAPPDATA%\Vivaldi\User Data\Default\Cache\*.*" 2>nul
    del /q /f /s "%LOCALAPPDATA%\Vivaldi\User Data\Default\Code Cache\*.*" 2>nul
    echo %SUCCESS_COLOR%Vivaldi cache cleaned!%RESET_COLOR%
    echo Vivaldi cache cleaned >> "%LOG_FILE%"
) else (
    echo %WARN_COLOR%Vivaldi cache not found.%RESET_COLOR%
    echo Vivaldi cache not found >> "%LOG_FILE%"
)

echo %INFO_COLOR%Cleaning Internet Explorer cache...%RESET_COLOR%
call :SHOW_PROGRESS 70 "Cleaning Internet Explorer cache..."
RunDll32.exe InetCpl.cpl,ClearMyTracksByProcess 8 2>nul
echo %SUCCESS_COLOR%Internet Explorer cache cleaned!%RESET_COLOR%
echo Internet Explorer cache cleaned >> "%LOG_FILE%"

echo %INFO_COLOR%Cleaning browser cookies...%RESET_COLOR%
call :SHOW_PROGRESS 80 "Cleaning browser cookies..."
RunDll32.exe InetCpl.cpl,ClearMyTracksByProcess 2 2>nul
echo %SUCCESS_COLOR%Browser cookies cleaned!%RESET_COLOR%
echo Browser cookies cleaned >> "%LOG_FILE%"

echo %INFO_COLOR%Cleaning browser history...%RESET_COLOR%
call :SHOW_PROGRESS 90 "Cleaning browser history..."
RunDll32.exe InetCpl.cpl,ClearMyTracksByProcess 1 2>nul
echo %SUCCESS_COLOR%Browser history cleaned!%RESET_COLOR%
echo Browser history cleaned >> "%LOG_FILE%"

call :SHOW_PROGRESS 100 "Browser caches cleaning completed!"

:: Calculate space saved
for /f "tokens=3" %%a in ('dir c:\ ^| findstr /C:"bytes free"') do set "SPACE_AFTER=%%a"
set /a SPACE_SAVED=%SPACE_AFTER%-%SPACE_BEFORE%
echo Final free disk space: %SPACE_AFTER% bytes >> "%LOG_FILE%"
echo Space saved: %SPACE_SAVED% bytes >> "%LOG_FILE%"

echo.
echo %SUCCESS_COLOR%Browser caches cleaning completed!%RESET_COLOR%
echo %SUCCESS_COLOR%Space saved: %SPACE_SAVED% bytes%RESET_COLOR%
echo.
pause
goto MENU

:CLEAN_LOGS
cls
echo ===================================
echo      CLEANING WINDOWS LOG FILES
echo ===================================
echo.

echo Cleaning Windows Event Logs...
for /f "tokens=*" %%G in ('wevtutil el') do (
    echo Clearing "%%G" log...
    wevtutil cl "%%G" 2>nul
)

echo.
echo Cleaning Windows CBS logs...
del /q /f /s "%SystemRoot%\Logs\CBS\*.*" 2>nul

echo.
echo Windows log files cleaning completed!
echo.
pause
goto MENU

:DISK_CLEANUP
cls
echo ===================================
echo         RUNNING DISK CLEANUP
echo ===================================
echo.

echo Starting Windows Disk Cleanup utility...
cleanmgr /sagerun:1

echo.
echo Disk Cleanup completed!
echo.
pause
goto MENU

:EMPTY_RECYCLE
cls
echo ===================================
echo         EMPTYING RECYCLE BIN
echo ===================================
echo.

echo Are you sure you want to empty the Recycle Bin? (Y/N)
set /p confirm=
if /i "%confirm%"=="Y" (
    echo Emptying Recycle Bin...
    rd /s /q C:\$Recycle.Bin 2>nul
    echo Recycle Bin emptied!
) else (
    echo Operation cancelled.
)

echo.
pause
goto MENU

:CLEAN_ALL
cls
echo ===================================
echo      RUNNING ALL CLEANING TASKS
echo ===================================
echo.

echo This will run all cleaning operations.
echo Are you sure you want to continue? (Y/N)
set /p confirm=
if /i not "%confirm%"=="Y" goto MENU

call :CLEAN_TEMP_SILENT
call :CLEAN_BROWSERS_SILENT
call :CLEAN_LOGS_SILENT
call :DISK_CLEANUP_SILENT
call :EMPTY_RECYCLE_SILENT

echo.
echo All cleaning operations completed!
echo.
pause
goto MENU

:CLEAN_TEMP_SILENT
echo Cleaning temporary files...
del /q /f /s "%TEMP%\*.*" 2>nul
del /q /f /s "%SystemRoot%\Temp\*.*" 2>nul
del /q /f /s "%SystemRoot%\Prefetch\*.*" 2>nul
del /q /f /s "%SystemRoot%\SoftwareDistribution\Download\*.*" 2>nul
return

:CLEAN_BROWSERS_SILENT
echo Cleaning browser caches...
del /q /f /s "%LOCALAPPDATA%\Google\Chrome\User Data\Default\Cache\*.*" 2>nul
del /q /f /s "%LOCALAPPDATA%\Microsoft\Edge\User Data\Default\Cache\*.*" 2>nul
del /q /f /s "%LOCALAPPDATA%\Mozilla\Firefox\Profiles\*\cache2\*.*" 2>nul
return

:CLEAN_LOGS_SILENT
echo Cleaning Windows logs...
for /f "tokens=*" %%G in ('wevtutil el') do (
    wevtutil cl "%%G" 2>nul
)
del /q /f /s "%SystemRoot%\Logs\CBS\*.*" 2>nul
return

:DISK_CLEANUP_SILENT
echo Running Disk Cleanup...
start /wait cleanmgr /sagerun:1
return

:EMPTY_RECYCLE_SILENT
echo Emptying Recycle Bin...
rd /s /q C:\$Recycle.Bin 2>nul
return

:ADVANCED_CLEANING
cls
echo %INFO_COLOR%╔════════════════════════════════════════════════════════════════╗%RESET_COLOR%
echo %INFO_COLOR%║                  ADVANCED CLEANING OPTIONS                    ║%RESET_COLOR%
echo %INFO_COLOR%╚════════════════════════════════════════════════════════════════╝%RESET_COLOR%
echo.

:: Log the operation
echo Advanced cleaning started at %date% %time% >> "%LOG_FILE%"

echo %INFO_COLOR%Select an advanced cleaning option:%RESET_COLOR%
echo %SUCCESS_COLOR%  [1] Clean Windows Update Cache%RESET_COLOR%
echo %SUCCESS_COLOR%  [2] Clean Windows Installer Cache%RESET_COLOR%
echo %SUCCESS_COLOR%  [3] Clean Windows Error Reporting%RESET_COLOR%
echo %SUCCESS_COLOR%  [4] Clean Font Cache%RESET_COLOR%
echo %SUCCESS_COLOR%  [5] Clean Windows Defender Cache%RESET_COLOR%
echo %SUCCESS_COLOR%  [6] Clean OneDrive Cache%RESET_COLOR%
echo %SUCCESS_COLOR%  [7] Clean Microsoft Teams Cache%RESET_COLOR%
echo %SUCCESS_COLOR%  [8] Return to Main Menu%RESET_COLOR%
echo.

set /p adv_choice=Enter your choice (1-8):

if "%adv_choice%"=="1" (
    echo %INFO_COLOR%Cleaning Windows Update Cache...%RESET_COLOR%
    net stop wuauserv >nul 2>&1
    del /q /f /s "%SystemRoot%\SoftwareDistribution\*.*" 2>nul
    net start wuauserv >nul 2>&1
    echo Windows Update Cache cleaned >> "%LOG_FILE%"
    echo %SUCCESS_COLOR%Windows Update Cache cleaned!%RESET_COLOR%
)

if "%adv_choice%"=="2" (
    echo %INFO_COLOR%Cleaning Windows Installer Cache...%RESET_COLOR%
    del /q /f /s "%SystemRoot%\Installer\$PatchCache$\*.*" 2>nul
    echo Windows Installer Cache cleaned >> "%LOG_FILE%"
    echo %SUCCESS_COLOR%Windows Installer Cache cleaned!%RESET_COLOR%
)

if "%adv_choice%"=="3" (
    echo %INFO_COLOR%Cleaning Windows Error Reporting...%RESET_COLOR%
    del /q /f /s "%LOCALAPPDATA%\Microsoft\Windows\WER\*.*" 2>nul
    echo Windows Error Reporting cleaned >> "%LOG_FILE%"
    echo %SUCCESS_COLOR%Windows Error Reporting cleaned!%RESET_COLOR%
)

if "%adv_choice%"=="4" (
    echo %INFO_COLOR%Cleaning Font Cache...%RESET_COLOR%
    net stop FontCache >nul 2>&1
    del /q /f /s "%WinDir%\ServiceProfiles\LocalService\AppData\Local\FontCache\*.*" 2>nul
    net start FontCache >nul 2>&1
    echo Font Cache cleaned >> "%LOG_FILE%"
    echo %SUCCESS_COLOR%Font Cache cleaned!%RESET_COLOR%
)

if "%adv_choice%"=="5" (
    echo %INFO_COLOR%Cleaning Windows Defender Cache...%RESET_COLOR%
    del /q /f /s "%ProgramData%\Microsoft\Windows Defender\Scans\History\*.*" 2>nul
    echo Windows Defender Cache cleaned >> "%LOG_FILE%"
    echo %SUCCESS_COLOR%Windows Defender Cache cleaned!%RESET_COLOR%
)

if "%adv_choice%"=="6" (
    echo %INFO_COLOR%Cleaning OneDrive Cache...%RESET_COLOR%
    if exist "%LOCALAPPDATA%\Microsoft\OneDrive\setup\logs" (
        del /q /f /s "%LOCALAPPDATA%\Microsoft\OneDrive\setup\logs\*.*" 2>nul
        echo OneDrive Cache cleaned >> "%LOG_FILE%"
        echo %SUCCESS_COLOR%OneDrive Cache cleaned!%RESET_COLOR%
    ) else (
        echo %WARN_COLOR%OneDrive Cache not found.%RESET_COLOR%
        echo OneDrive Cache not found >> "%LOG_FILE%"
    )
)

if "%adv_choice%"=="7" (
    echo %INFO_COLOR%Cleaning Microsoft Teams Cache...%RESET_COLOR%
    if exist "%APPDATA%\Microsoft\Teams\Cache" (
        del /q /f /s "%APPDATA%\Microsoft\Teams\Cache\*.*" 2>nul
        del /q /f /s "%APPDATA%\Microsoft\Teams\blob_storage\*.*" 2>nul
        del /q /f /s "%APPDATA%\Microsoft\Teams\databases\*.*" 2>nul
        del /q /f /s "%APPDATA%\Microsoft\Teams\GPUCache\*.*" 2>nul
        del /q /f /s "%APPDATA%\Microsoft\Teams\IndexedDB\*.*" 2>nul
        del /q /f /s "%APPDATA%\Microsoft\Teams\Local Storage\*.*" 2>nul
        del /q /f /s "%APPDATA%\Microsoft\Teams\tmp\*.*" 2>nul
        echo Microsoft Teams Cache cleaned >> "%LOG_FILE%"
        echo %SUCCESS_COLOR%Microsoft Teams Cache cleaned!%RESET_COLOR%
    ) else (
        echo %WARN_COLOR%Microsoft Teams Cache not found.%RESET_COLOR%
        echo Microsoft Teams Cache not found >> "%LOG_FILE%"
    )
)

if "%adv_choice%"=="8" goto MENU

echo.
pause
goto ADVANCED_CLEANING

:SYSTEM_HEALTH
cls
echo %INFO_COLOR%╔════════════════════════════════════════════════════════════════╗%RESET_COLOR%
echo %INFO_COLOR%║                  SYSTEM HEALTH CHECK                         ║%RESET_COLOR%
echo %INFO_COLOR%╚════════════════════════════════════════════════════════════════╝%RESET_COLOR%
echo.

:: Log the operation
echo System health check started at %date% %time% >> "%LOG_FILE%"

echo %INFO_COLOR%Running System File Checker...%RESET_COLOR%
echo This may take several minutes. Please wait...
sfc /scannow
echo System File Checker completed >> "%LOG_FILE%"

echo.
echo %INFO_COLOR%Checking disk for errors...%RESET_COLOR%
echo This will schedule a disk check on next system restart.
chkdsk C: /f /r
echo Disk check scheduled >> "%LOG_FILE%"

echo.
echo %INFO_COLOR%Checking Windows system files...%RESET_COLOR%
DISM /Online /Cleanup-Image /CheckHealth
echo DISM health check completed >> "%LOG_FILE%"

echo.
echo %INFO_COLOR%Checking for Windows updates...%RESET_COLOR%
wuauclt /detectnow
echo Windows update check initiated >> "%LOG_FILE%"

echo.
echo %SUCCESS_COLOR%System health check completed!%RESET_COLOR%
echo %SUCCESS_COLOR%Please restart your computer to complete any scheduled repairs.%RESET_COLOR%
echo.
pause
goto MENU

:DISK_ANALYZER
cls
echo %INFO_COLOR%╔════════════════════════════════════════════════════════════════╗%RESET_COLOR%
echo %INFO_COLOR%║                  DISK SPACE ANALYZER                         ║%RESET_COLOR%
echo %INFO_COLOR%╚════════════════════════════════════════════════════════════════╝%RESET_COLOR%
echo.

:: Log the operation
echo Disk space analysis started at %date% %time% >> "%LOG_FILE%"

echo %INFO_COLOR%Analyzing disk space usage...%RESET_COLOR%
echo.

echo %INFO_COLOR%Drive Information:%RESET_COLOR%
wmic logicaldisk get deviceid, volumename, description, freespace, size

echo.
echo %INFO_COLOR%Largest folders in C:\Users\%USERNAME% (Top 10):%RESET_COLOR%
echo This may take a few minutes...

for /f "tokens=*" %%a in ('dir C:\Users\%USERNAME% /s /b /a:d') do (
    set "folder=%%a"
    if exist "!folder!" (
        for /f "tokens=3" %%b in ('dir "!folder!" /a /-c 2^>nul ^| findstr /C:"File(s)"') do (
            echo %%b bytes - !folder!
        )
    )
)

echo.
echo %INFO_COLOR%Largest files in C:\Users\%USERNAME% (Top 10):%RESET_COLOR%
echo This may take a few minutes...

for /f "tokens=*" %%a in ('dir C:\Users\%USERNAME% /s /b /a:-d') do (
    set "file=%%a"
    if exist "!file!" (
        for /f "tokens=3" %%b in ('dir "!file!" /a /-c 2^>nul ^| findstr /C:"1 File(s)"') do (
            echo %%b bytes - !file!
        )
    )
)

echo.
echo %SUCCESS_COLOR%Disk space analysis completed!%RESET_COLOR%
echo %SUCCESS_COLOR%Consider removing large unnecessary files to free up space.%RESET_COLOR%
echo.
pause
goto MENU

:STARTUP_MANAGER
cls
echo %INFO_COLOR%╔════════════════════════════════════════════════════════════════╗%RESET_COLOR%
echo %INFO_COLOR%║                  STARTUP PROGRAMS MANAGER                    ║%RESET_COLOR%
echo %INFO_COLOR%╚════════════════════════════════════════════════════════════════╝%RESET_COLOR%
echo.

:: Log the operation
echo Startup manager launched at %date% %time% >> "%LOG_FILE%"

echo %INFO_COLOR%Current startup programs:%RESET_COLOR%
echo.
wmic startup list full

echo.
echo %INFO_COLOR%To manage startup programs, we'll open the Task Manager.%RESET_COLOR%
echo %INFO_COLOR%Please go to the Startup tab to enable/disable programs.%RESET_COLOR%
echo.

echo %INFO_COLOR%Would you like to open Task Manager? (Y/N)%RESET_COLOR%
set /p open_tm=
if /i "%open_tm%"=="Y" (
    start taskmgr.exe
    echo Task Manager opened >> "%LOG_FILE%"
)

echo.
echo %SUCCESS_COLOR%Startup manager completed!%RESET_COLOR%
echo.
pause
goto MENU

:MEMORY_OPTIMIZER
cls
echo %INFO_COLOR%╔════════════════════════════════════════════════════════════════╗%RESET_COLOR%
echo %INFO_COLOR%║                  MEMORY OPTIMIZATION                        ║%RESET_COLOR%
echo %INFO_COLOR%╚════════════════════════════════════════════════════════════════╝%RESET_COLOR%
echo.

:: Log the operation
echo Memory optimization started at %date% %time% >> "%LOG_FILE%"

echo %INFO_COLOR%Current memory usage:%RESET_COLOR%
for /f "skip=1" %%p in ('wmic os get FreePhysicalMemory') do (
    set "freemem=%%p"
    goto :freememfound
)
:freememfound
for /f "skip=1" %%p in ('wmic os get TotalVisibleMemorySize') do (
    set "totalmem=%%p"
    goto :totalmemfound
)
:totalmemfound

set /a usedmem=%totalmem%-%freemem%
set /a usedmempercent=(%usedmem%*100)/%totalmem%
set /a freemempercent=100-%usedmempercent%

echo Total Memory: %totalmem% KB
echo Used Memory: %usedmem% KB (%usedmempercent%%%)
echo Free Memory: %freemem% KB (%freemempercent%%%)

echo.
echo %INFO_COLOR%Optimizing memory...%RESET_COLOR%

echo %INFO_COLOR%Clearing system working set...%RESET_COLOR%
powershell -command "[System.Diagnostics.Process]::GetProcesses() | ForEach-Object { $_.MinWorkingSet = [System.IntPtr]::Zero }"

echo %INFO_COLOR%Clearing file system cache...%RESET_COLOR%
echo.
echo %WARN_COLOR%This operation requires administrator privileges.%RESET_COLOR%
echo %WARN_COLOR%It will temporarily freeze your system for a few seconds.%RESET_COLOR%
echo %WARN_COLOR%Do you want to continue? (Y/N)%RESET_COLOR%
set /p clear_cache=
if /i "%clear_cache%"=="Y" (
    echo Clearing file system cache...
    echo.
    powershell -command "Write-Host 'Clearing system cache...'; [System.Reflection.Assembly]::LoadWithPartialName('System.Runtime.InteropServices'); $gch = [System.Runtime.InteropServices.GCHandle]::Alloc((New-Object byte[]([Math]::Max([Environment]::SystemPageSize, 4096))), 'Pinned'); try { [System.Runtime.InteropServices.Marshal]::FreeHGlobal($gch.AddrOfPinnedObject()) } finally { $gch.Free() }"
    echo File system cache cleared >> "%LOG_FILE%"
)

echo.
echo %INFO_COLOR%Current memory usage after optimization:%RESET_COLOR%
for /f "skip=1" %%p in ('wmic os get FreePhysicalMemory') do (
    set "freemem2=%%p"
    goto :freemem2found
)
:freemem2found

set /a usedmem2=%totalmem%-%freemem2%
set /a usedmempercent2=(%usedmem2%*100)/%totalmem%
set /a freemempercent2=100-%usedmempercent2%
set /a memoryfreed=%freemem2%-%freemem%

echo Total Memory: %totalmem% KB
echo Used Memory: %usedmem2% KB (%usedmempercent2%%%)
echo Free Memory: %freemem2% KB (%freemempercent2%%%)
echo Memory Freed: %memoryfreed% KB

echo Memory optimization completed >> "%LOG_FILE%"
echo Memory freed: %memoryfreed% KB >> "%LOG_FILE%"

echo.
echo %SUCCESS_COLOR%Memory optimization completed!%RESET_COLOR%
echo.
pause
goto MENU

:SYSTEM_RESTORE
cls
echo %INFO_COLOR%╔════════════════════════════════════════════════════════════════╗%RESET_COLOR%
echo %INFO_COLOR%║                  SYSTEM RESTORE POINT                       ║%RESET_COLOR%
echo %INFO_COLOR%╚════════════════════════════════════════════════════════════════╝%RESET_COLOR%
echo.

:: Log the operation
echo System restore point creation started at %date% %time% >> "%LOG_FILE%"

echo %INFO_COLOR%Creating a system restore point...%RESET_COLOR%
echo.

powershell -command "Checkpoint-Computer -Description 'CleanerTools Restore Point' -RestorePointType 'APPLICATION_INSTALL'"

if %errorlevel% equ 0 (
    echo %SUCCESS_COLOR%System restore point created successfully!%RESET_COLOR%
    echo System restore point created successfully >> "%LOG_FILE%"
) else (
    echo %ERROR_COLOR%Failed to create system restore point.%RESET_COLOR%
    echo %ERROR_COLOR%Please make sure System Protection is enabled on your system.%RESET_COLOR%
    echo Failed to create system restore point >> "%LOG_FILE%"
)

echo.
echo %INFO_COLOR%Would you like to open System Protection settings? (Y/N)%RESET_COLOR%
set /p open_sp=
if /i "%open_sp%"=="Y" (
    start SystemPropertiesProtection.exe
    echo System Protection settings opened >> "%LOG_FILE%"
)

echo.
pause
goto MENU

:SCHEDULE_TASKS
cls
echo %INFO_COLOR%╔════════════════════════════════════════════════════════════════╗%RESET_COLOR%
echo %INFO_COLOR%║                  SCHEDULE CLEANING TASKS                     ║%RESET_COLOR%
echo %INFO_COLOR%╚════════════════════════════════════════════════════════════════╝%RESET_COLOR%
echo.

:: Log the operation
echo Schedule cleaning tasks started at %date% %time% >> "%LOG_FILE%"

echo %INFO_COLOR%Schedule automatic cleaning tasks:%RESET_COLOR%
echo.
echo %SUCCESS_COLOR%  [1] Daily cleaning (Temp files)%RESET_COLOR%
echo %SUCCESS_COLOR%  [2] Weekly cleaning (Temp files + Browser cache)%RESET_COLOR%
echo %SUCCESS_COLOR%  [3] Monthly cleaning (All cleaning tasks)%RESET_COLOR%
echo %SUCCESS_COLOR%  [4] Remove scheduled tasks%RESET_COLOR%
echo %SUCCESS_COLOR%  [5] Return to Main Menu%RESET_COLOR%
echo.

set /p sched_choice=Enter your choice (1-5):

if "%sched_choice%"=="1" (
    echo %INFO_COLOR%Setting up daily cleaning task...%RESET_COLOR%
    schtasks /create /tn "CleanerTools Daily Cleaning" /tr "\"%~f0\" /daily" /sc daily /st 09:00 /ru SYSTEM
    if %errorlevel% equ 0 (
        echo %SUCCESS_COLOR%Daily cleaning task scheduled successfully!%RESET_COLOR%
        echo Daily cleaning task scheduled >> "%LOG_FILE%"
    ) else (
        echo %ERROR_COLOR%Failed to schedule daily cleaning task.%RESET_COLOR%
        echo Failed to schedule daily cleaning task >> "%LOG_FILE%"
    )
)

if "%sched_choice%"=="2" (
    echo %INFO_COLOR%Setting up weekly cleaning task...%RESET_COLOR%
    schtasks /create /tn "CleanerTools Weekly Cleaning" /tr "\"%~f0\" /weekly" /sc weekly /d SAT /st 10:00 /ru SYSTEM
    if %errorlevel% equ 0 (
        echo %SUCCESS_COLOR%Weekly cleaning task scheduled successfully!%RESET_COLOR%
        echo Weekly cleaning task scheduled >> "%LOG_FILE%"
    ) else (
        echo %ERROR_COLOR%Failed to schedule weekly cleaning task.%RESET_COLOR%
        echo Failed to schedule weekly cleaning task >> "%LOG_FILE%"
    )
)

if "%sched_choice%"=="3" (
    echo %INFO_COLOR%Setting up monthly cleaning task...%RESET_COLOR%
    schtasks /create /tn "CleanerTools Monthly Cleaning" /tr "\"%~f0\" /monthly" /sc monthly /d 1 /st 12:00 /ru SYSTEM
    if %errorlevel% equ 0 (
        echo %SUCCESS_COLOR%Monthly cleaning task scheduled successfully!%RESET_COLOR%
        echo Monthly cleaning task scheduled >> "%LOG_FILE%"
    ) else (
        echo %ERROR_COLOR%Failed to schedule monthly cleaning task.%RESET_COLOR%
        echo Failed to schedule monthly cleaning task >> "%LOG_FILE%"
    )
)

if "%sched_choice%"=="4" (
    echo %INFO_COLOR%Removing scheduled cleaning tasks...%RESET_COLOR%
    schtasks /delete /tn "CleanerTools Daily Cleaning" /f 2>nul
    schtasks /delete /tn "CleanerTools Weekly Cleaning" /f 2>nul
    schtasks /delete /tn "CleanerTools Monthly Cleaning" /f 2>nul
    echo %SUCCESS_COLOR%Scheduled cleaning tasks removed!%RESET_COLOR%
    echo Scheduled cleaning tasks removed >> "%LOG_FILE%"
)

if "%sched_choice%"=="5" goto MENU

echo.
pause
goto SCHEDULE_TASKS

:VIEW_LOGS
cls
echo %INFO_COLOR%╔════════════════════════════════════════════════════════════════╗%RESET_COLOR%
echo %INFO_COLOR%║                  CLEANING LOGS VIEWER                       ║%RESET_COLOR%
echo %INFO_COLOR%╚════════════════════════════════════════════════════════════════╝%RESET_COLOR%
echo.

echo %INFO_COLOR%Available log files:%RESET_COLOR%
echo.

set count=0
for %%f in ("%USERPROFILE%\CleanerTools\Logs\*.log") do (
    set /a count+=1
    echo %SUCCESS_COLOR%  [!count!] %%~nxf%RESET_COLOR%
)

if %count% equ 0 (
    echo %WARN_COLOR%No log files found.%RESET_COLOR%
    echo.
    pause
    goto MENU
)

echo.
echo %SUCCESS_COLOR%  [0] Return to Main Menu%RESET_COLOR%
echo.

set /p log_choice=Enter log number to view (0-%count%):

if "%log_choice%"=="0" goto MENU

set current=0
for %%f in ("%USERPROFILE%\CleanerTools\Logs\*.log") do (
    set /a current+=1
    if !current! equ %log_choice% (
        cls
        echo %INFO_COLOR%╔════════════════════════════════════════════════════════════════╗%RESET_COLOR%
        echo %INFO_COLOR%║                  LOG FILE: %%~nxf                           %RESET_COLOR%
        echo %INFO_COLOR%╚════════════════════════════════════════════════════════════════╝%RESET_COLOR%
        echo.
        type "%%f"
        echo.
        pause
        goto VIEW_LOGS
    )
)

echo %WARN_COLOR%Invalid log number.%RESET_COLOR%
echo.
pause
goto VIEW_LOGS

:SHOW_PROGRESS
setlocal
set progress=%~1
set message=%~2

set /a filled=%progress%/5
set /a empty=20-%filled%

set progressbar=
for /l %%i in (1,1,%filled%) do set progressbar=!progressbar!█
for /l %%i in (1,1,%empty%) do set progressbar=!progressbar!░

echo %INFO_COLOR%[!progressbar!] %progress%%%  %message%%RESET_COLOR%
endlocal
goto :eof

:EXIT
cls
echo ===================================
echo      THANK YOU FOR USING THE
echo        CLEANER TOOLS UTILITY
echo ===================================
echo.
echo Your system is now cleaner!
echo.
pause
exit /b 0
