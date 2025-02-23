@echo off
title Windows Storage Cleanup
echo Cleaning up unnecessary files to free up space...
echo.

:: Delete Windows temporary files
echo Deleting Windows Temp files...
del /s /f /q C:\Windows\Temp\*.* >nul 2>&1
rd /s /q C:\Windows\Temp >nul 2>&1
mkdir C:\Windows\Temp

:: Delete user temporary files
echo Deleting User Temp files...
del /s /f /q %temp%\*.* >nul 2>&1
rd /s /q %temp% >nul 2>&1
mkdir %temp%

:: Delete prefetch files (safe)
echo Deleting Prefetch files...
del /s /f /q C:\Windows\Prefetch\*.* >nul 2>&1

:: Clear Windows Update Cache
echo Deleting Windows Update Cache...
net stop wuauserv >nul 2>&1
del /s /f /q C:\Windows\SoftwareDistribution\Download\*.* >nul 2>&1
rd /s /q C:\Windows\SoftwareDistribution\Download >nul 2>&1
mkdir C:\Windows\SoftwareDistribution\Download
net start wuauserv >nul 2>&1

:: Disable Hibernation (removes hiberfil.sys)
echo Disabling Hibernation...
powercfg -h off

:: Clean System Restore Points (optional)
echo Cleaning up System Restore points...
wmic shadowcopy delete >nul 2>&1

:: Empty Recycle Bin
echo Emptying Recycle Bin...
rd /s /q C:\$Recycle.Bin >nul 2>&1

:: Finished
echo.
echo Cleanup complete! Restarting Explorer...
taskkill /f /im explorer.exe >nul 2>&1
start explorer.exe
echo Done!

pause
exit
