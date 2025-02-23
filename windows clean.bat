@echo off
title Windows Folder Cleanup
echo Cleaning up unnecessary files from C:\Windows safely...
echo.

:: Stop services to clean locked files
net stop wuauserv >nul 2>&1
net stop bits >nul 2>&1
net stop cryptsvc >nul 2>&1

:: Delete Temp folder contents
echo Cleaning Windows Temp folder...
del /s /f /q C:\Windows\Temp\*.* >nul 2>&1
rd /s /q C:\Windows\Temp >nul 2>&1
mkdir C:\Windows\Temp

:: Clean SoftwareDistribution (Windows Update Cache)
echo Cleaning Windows Update Cache...
del /s /f /q C:\Windows\SoftwareDistribution\Download\*.* >nul 2>&1
rd /s /q C:\Windows\SoftwareDistribution\Download >nul 2>&1
mkdir C:\Windows\SoftwareDistribution\Download

:: Remove old update backups
echo Removing old Windows update backups...
dism /online /cleanup-image /startcomponentcleanup /resetbase

:: Delete Windows Prefetch files (safe)
echo Cleaning Prefetch files...
del /s /f /q C:\Windows\Prefetch\*.* >nul 2>&1

:: Clean Log files
echo Removing log files...
del /s /f /q C:\Windows\Logs\*.* >nul 2>&1

:: Clean up Windows Error Reporting files
echo Removing Windows Error Reporting files...
del /s /f /q C:\ProgramData\Microsoft\Windows\WER\*.* >nul 2>&1

:: Restart services
net start wuauserv >nul 2>&1
net start bits >nul 2>&1
net start cryptsvc >nul 2>&1

:: Finished
echo.
echo Cleanup complete! Restarting Explorer...
taskkill /f /im explorer.exe >nul 2>&1
start explorer.exe
echo Done!

pause
exit
