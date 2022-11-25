:: Copyright (C) 2022 SULFURAX
:: 
:: This program is free software: you can redistribute it and/or modify
:: it under the terms of the GNU Affero General Public License as published
:: by the Free Software Foundation, either version 3 of the License, or
:: (at your option) any later version.
:: 
:: This program is distributed in the hope that it will be useful,
:: but WITHOUT ANY WARRANTY; without even the implied warranty of
:: MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
:: GNU Affero General Public License for more details.
:: 
:: You should have received a copy of the GNU Affero General Public License
:: along with this program.  If not, see <https://www.gnu.org/licenses/>.

@echo off
color 03
Mode 128,25
title Script MCOptimizer 2.0
setlocal EnableDelayedExpansion

:: Disable LUA
Reg.exe add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "EnableLUA" /t REG_DWORD /d "0" /f

:: Run Admin
Reg.exe add HKLM /F >nul 2>&1
if %errorlevel% neq 0 start "" /wait /I /min powershell -NoProfile -Command start -verb runas "'%~s0'" && exit /b

:: Show details BSOD
Reg add "HKLM\System\CurrentControlSet\Control\CrashControl" /v "DisplayParameters" /t REG_DWORD /d "1" /f >nul 2>&1

:: Blank/Color Character
for /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & echo on & for %%b in (1) do rem"') do (set "DEL=%%a" & set "COL=%%b")

:: Add ANSI escape sequences
Reg add HKCU\CONSOLE /v VirtualTerminalLevel /t REG_DWORD /d 1 /f >nul 2>&1

:: Check Updates
goto CheckUpdates

:CheckUpdates
set local=2.0
set localtwo=%local%
if exist "%temp%\Updater.bat" DEL /S /Q /F "%temp%\Updater.bat" >nul 2>&1
curl -g -L -# -o "%temp%\Updater.bat" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/MCOptimizer_Version" >nul 2>&1
call "%temp%\Updater.bat"
IF "%local%" gtr "%localtwo%" (
	cls
	Mode 65,16
	echo.
	echo                        You need to Update
    echo                          - MCOptimizer -
	echo  ______________________________________________________________
	echo.
	echo                       Current version: %localtwo%
	echo.
	echo                         New version: %local%
	echo.
	echo  ______________________________________________________________
	echo.
	echo      [ Y ] To Update MCOptimizer
	echo.
	echo      [ N ] Skip Update
	echo.
	%SystemRoot%\System32\choice.exe /c:YN /n /m "%DEL%                                >:"
	set choice=!errorlevel!
	if !choice! equ 1 (
		curl -L -o %0 "https://github.com/SULFURA/MCOptimizer/releases/latest/download/MCOptimizer.cmd" >nul 2>&1
		call %0
		exit /b
	)
	Mode 130,45
)

cls
SET msgboxTitle=INFORMATION
SET msgboxBody=You have to run the script when Minecraft is closed.
SET tmpmsgbox=%temp%\~tmpmsgbox.vbs
IF EXIST "%tmpmsgbox%" DEL /F /Q "%tmpmsgbox%"
ECHO msgbox "%msgboxBody%",0,"%msgboxTitle%">"%tmpmsgbox%"
WSCRIPT "%tmpmsgbox%"

:: Menu
goto Menu

:Menu
cls
echo.
echo.
call :ColorText 08  "                                                            Version 2.0 
echo.
echo.
echo.                                                     .88b  d88.  .o88b.  .d88b.     
echo.                                                     88'YbdP`88 d8P  Y8 .8P  Y8. 
echo.                                                     88  88  88 8P      88    88      
echo.                                                     88  88  88 8b      88    88 
echo.                                                     88  88  88 Y8b  d8 `8b  d8'  
echo.                                                     YP  YP  YP  `Y88P'  `Y88P'  
echo.
echo. 
call :ColorText 08 "                         ________________________________________________________________________________"
echo.
echo.
echo.
call :ColorText 8 "                          [ "
call :ColorText B " 1 "
call :ColorText 8 " ] " 
call :ColorText F " MCOptimizer for GPU"
call :ColorText 8 "                           [ "
call :ColorText B " 2 "
call :ColorText 8 " ] " 
call :ColorText F " MCOptimizer for iGPU"
echo.
echo.
echo.
call :ColorText 8 "                                                          [ X for Leave ]"
echo.
echo.
call :ColorText 08 "                         ________________________________________________________________________________"
echo.
echo.
set /p choice="%DEL%Select > "
if /i "%choice%"=="1" goto 1
if /i "%choice%"=="2" goto 2
if /i "%choice%"=="X" exit /b
goto Menu

:: Menu 1

:1
cls
echo.
echo.
call :ColorText 08  "                                                            Version 2.0 
echo.
echo.
echo.                                                     .88b  d88.  .o88b.  .d88b.     
echo.                                                     88'YbdP`88 d8P  Y8 .8P  Y8. 
echo.                                                     88  88  88 8P      88    88      
echo.                                                     88  88  88 8b      88    88 
echo.                                                     88  88  88 Y8b  d8 `8b  d8'  
echo.                                                     YP  YP  YP  `Y88P'  `Y88P'  
echo.
echo. 
call :ColorText 08 "                         ________________________________________________________________________________"
echo.
echo.
echo.
call :ColorText 8 "                          [ "
call :ColorText B " 1 "
call :ColorText 8 " ] " 
call :ColorText F " 1.7.10"
call :ColorText 8 "                                                      [ "
call :ColorText B " 2 "
call :ColorText 8 " ] " 
call :ColorText F " 1.8.9"
echo.
echo.
echo.
call :ColorText 8 "                                                          [ X for Leave ]"
echo.
echo.
call :ColorText 08 "                         ________________________________________________________________________________"
echo.
echo.
set /p choose="Select > "

if /i "%choose%"=="1" (goto 1.7.10_GPU)
if /i "%choose%"=="2" (goto 1.8.9_GPU)
if /i "%choose%"=="X" (goto Exit)
goto 1

:1.7.10_GPU
cls
echo.
echo.
call :ColorText 08  "                                                            Version 2.0 
echo.
echo.
echo.                                                     .88b  d88.  .o88b.  .d88b.     
echo.                                                     88'YbdP`88 d8P  Y8 .8P  Y8. 
echo.                                                     88  88  88 8P      88    88      
echo.                                                     88  88  88 8b      88    88 
echo.                                                     88  88  88 Y8b  d8 `8b  d8'  
echo.                                                     YP  YP  YP  `Y88P'  `Y88P'  
echo.
echo. 
call :ColorText 08 "                         ________________________________________________________________________________"
echo.
echo.
echo.
call :ColorText 8 "                          [ "
call :ColorText B " 1 "
call :ColorText 8 " ] " 
call :ColorText F " DynamicFOV OFF"
call :ColorText 8 "                                       [ "
call :ColorText B " 2 "
call :ColorText 8 " ] " 
call :ColorText F " DynamicFOV ON"
echo.
echo.
echo.
call :ColorText 8 "                                                          [ X for Leave ]"
echo.
echo.
call :ColorText 08 "                         ________________________________________________________________________________"
echo.
echo.
set /p choose="Select > "

if /i "%choose%"=="1" (goto 1.7.10_GPU_DynOFF)
if /i "%choose%"=="2" (goto 1.7.10_GPU_DynON)
if /i "%choose%"=="X" (goto Exit)
goto 1.7.10_GPU

:1.7.10_GPU_DynOFF
cls

curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\optionsof.txt" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/1.7.10_GPU_DynOFF.txt"
SET msgboxTitle=IMPORTANT
SET msgboxBody=Open your game and set your Render Distance between 2 - 8 and your FPS to Unlimited
SET tmpmsgbox=%temp%\~tmpmsgbox.vbs
IF EXIST "%tmpmsgbox%" DEL /F /Q "%tmpmsgbox%"
ECHO msgbox "%msgboxBody%",0,"%msgboxTitle%">"%tmpmsgbox%"
WSCRIPT "%tmpmsgbox%"
exit

:1.7.10_GPU_DynON
cls
curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\optionsof.txt" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/1.7.10_GPU_DynON.txt"
SET msgboxTitle=IMPORTANT
SET msgboxBody=Open your game and set your Render Distance between 2 - 8 and your FPS to Unlimited
SET tmpmsgbox=%temp%\~tmpmsgbox.vbs
IF EXIST "%tmpmsgbox%" DEL /F /Q "%tmpmsgbox%"
ECHO msgbox "%msgboxBody%",0,"%msgboxTitle%">"%tmpmsgbox%"
WSCRIPT "%tmpmsgbox%"
exit

:1.8.9_GPU
cls
echo.
echo.
call :ColorText 08  "                                                            Version 2.0 
echo.
echo.
echo.                                                     .88b  d88.  .o88b.  .d88b.     
echo.                                                     88'YbdP`88 d8P  Y8 .8P  Y8. 
echo.                                                     88  88  88 8P      88    88      
echo.                                                     88  88  88 8b      88    88 
echo.                                                     88  88  88 Y8b  d8 `8b  d8'  
echo.                                                     YP  YP  YP  `Y88P'  `Y88P'  
echo.
echo. 
call :ColorText 08 "                         ________________________________________________________________________________"
echo.
echo.
echo.
call :ColorText 8 "                          [ "
call :ColorText B " 1 "
call :ColorText 8 " ] " 
call :ColorText F " DynamicFOV OFF"
call :ColorText 8 "                                       [ "
call :ColorText B " 2 "
call :ColorText 8 " ] " 
call :ColorText F " DynamicFOV ON"
echo.
echo.
echo.
call :ColorText 8 "                                                          [ X for Leave ]"
echo.
echo.
call :ColorText 08 "                         ________________________________________________________________________________"
echo.
echo.
set /p choose="Select > "

if /i "%choose%"=="1" (goto 1.8.9_GPU_DynOFF)
if /i "%choose%"=="2" (goto 1.8.9_GPU_DynON)
if /i "%choose%"=="X" (goto Exit)
goto 1.8.9_GPU

:1.8.9_GPU_DynOFF
cls
curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\optionsof.txt" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/1.8.9_GPU_DynOFF.txt"
SET msgboxTitle=IMPORTANT
SET msgboxBody=Open your game and set your Render Distance between 2 - 8 and your FPS to Unlimited
SET tmpmsgbox=%temp%\~tmpmsgbox.vbs
IF EXIST "%tmpmsgbox%" DEL /F /Q "%tmpmsgbox%"
ECHO msgbox "%msgboxBody%",0,"%msgboxTitle%">"%tmpmsgbox%"
WSCRIPT "%tmpmsgbox%"
exit

:1.8.9_GPU_DynON
cls
curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\optionsof.txt" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/1.8.9_GPU_DynON.txt"
SET msgboxTitle=IMPORTANT
SET msgboxBody=Open your game and set your Render Distance between 2 - 8 and your FPS to Unlimited
SET tmpmsgbox=%temp%\~tmpmsgbox.vbs
IF EXIST "%tmpmsgbox%" DEL /F /Q "%tmpmsgbox%"
ECHO msgbox "%msgboxBody%",0,"%msgboxTitle%">"%tmpmsgbox%"
WSCRIPT "%tmpmsgbox%"
exit

:2
cls
echo.
echo.
call :ColorText 08  "                                                            Version 2.0 
echo.
echo.
echo.                                                     .88b  d88.  .o88b.  .d88b.     
echo.                                                     88'YbdP`88 d8P  Y8 .8P  Y8. 
echo.                                                     88  88  88 8P      88    88      
echo.                                                     88  88  88 8b      88    88 
echo.                                                     88  88  88 Y8b  d8 `8b  d8'  
echo.                                                     YP  YP  YP  `Y88P'  `Y88P'  
echo.
echo. 
call :ColorText 08 "                         ________________________________________________________________________________"
echo.
echo.
echo.
call :ColorText 8 "                          [ "
call :ColorText B " 1 "
call :ColorText 8 " ] " 
call :ColorText F " 1.7.10"
call :ColorText 8 "                                                      [ "
call :ColorText B " 2 "
call :ColorText 8 " ] " 
call :ColorText F " 1.8.9"
echo.
echo.
echo.
call :ColorText 8 "                                                          [ X for Leave ]"
echo.
echo.
call :ColorText 08 "                         ________________________________________________________________________________"
echo.
echo.
set /p choose="Select > "

if /i "%choose%"=="1" (goto 1.7.10_iGPU)
if /i "%choose%"=="2" (goto 1.8.9_iGPU)
if /i "%choose%"=="X" (goto Exit)
goto 2

:1.7.10_iGPU
cls
echo.
echo.
call :ColorText 08  "                                                            Version 2.0 
echo.
echo.
echo.                                                     .88b  d88.  .o88b.  .d88b.     
echo.                                                     88'YbdP`88 d8P  Y8 .8P  Y8. 
echo.                                                     88  88  88 8P      88    88      
echo.                                                     88  88  88 8b      88    88 
echo.                                                     88  88  88 Y8b  d8 `8b  d8'  
echo.                                                     YP  YP  YP  `Y88P'  `Y88P'  
echo.
echo. 
call :ColorText 08 "                         ________________________________________________________________________________"
echo.
echo.
echo.
call :ColorText 8 "                          [ "
call :ColorText B " 1 "
call :ColorText 8 " ] " 
call :ColorText F " DynamicFOV OFF"
call :ColorText 8 "                                       [ "
call :ColorText B " 2 "
call :ColorText 8 " ] " 
call :ColorText F " DynamicFOV ON"
echo.
echo.
echo.
call :ColorText 8 "                                                          [ X for Leave ]"
echo.
echo.
call :ColorText 08 "                         ________________________________________________________________________________"
echo.
echo.
set /p choose="Select > "

if /i "%choose%"=="1" (goto 1.7.10_iGPU_DynOFF)
if /i "%choose%"=="2" (goto 1.7.10_iGPU_DynON)
if /i "%choose%"=="X" (goto Exit)
goto 1.7.10_iGPU

:1.7.10_iGPU_DynOFF
cls
curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\optionsof.txt" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/1.7.10_iGPU_DynOFF.txt"
SET msgboxTitle=IMPORTANT
SET msgboxBody=Open your game and set your Render Distance between 2 - 5 and your FPS to 255
SET tmpmsgbox=%temp%\~tmpmsgbox.vbs
IF EXIST "%tmpmsgbox%" DEL /F /Q "%tmpmsgbox%"
ECHO msgbox "%msgboxBody%",0,"%msgboxTitle%">"%tmpmsgbox%"
WSCRIPT "%tmpmsgbox%"
exit

:1.7.10_iGPU_DynON
cls
curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\optionsof.txt" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/1.7.10_iGPU_DynON.txt"
SET msgboxTitle=IMPORTANT
SET msgboxBody=Open your game and set your Render Distance between 2 - 5 and your FPS to 255
SET tmpmsgbox=%temp%\~tmpmsgbox.vbs
IF EXIST "%tmpmsgbox%" DEL /F /Q "%tmpmsgbox%"
ECHO msgbox "%msgboxBody%",0,"%msgboxTitle%">"%tmpmsgbox%"
WSCRIPT "%tmpmsgbox%"
exit

:1.8.9_GPU
cls
echo.
echo.
call :ColorText 08  "                                                            Version 2.0 
echo.
echo.
echo.                                                     .88b  d88.  .o88b.  .d88b.     
echo.                                                     88'YbdP`88 d8P  Y8 .8P  Y8. 
echo.                                                     88  88  88 8P      88    88      
echo.                                                     88  88  88 8b      88    88 
echo.                                                     88  88  88 Y8b  d8 `8b  d8'  
echo.                                                     YP  YP  YP  `Y88P'  `Y88P'  
echo.
echo. 
call :ColorText 08 "                         ________________________________________________________________________________"
echo.
echo.
echo.
call :ColorText 8 "                          [ "
call :ColorText B " 1 "
call :ColorText 8 " ] " 
call :ColorText F " DynamicFOV OFF"
call :ColorText 8 "                                       [ "
call :ColorText B " 2 "
call :ColorText 8 " ] " 
call :ColorText F " DynamicFOV ON"
echo.
echo.
echo.
call :ColorText 8 "                                                          [ X for Leave ]"
echo.
echo.
call :ColorText 08 "                         ________________________________________________________________________________"
echo.
echo.
set /p choose="Select > "

if /i "%choose%"=="1" (goto 1.8.9_iGPU_DynOFF)
if /i "%choose%"=="2" (goto 1.8.9_iGPU_DynON)
if /i "%choose%"=="X" (goto Exit)
goto 1.8.9_iGPU

:1.8.9_iGPU_DynOFF
cls
curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\optionsof.txt" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/1.8.9_iGPU_DynOFF.txt"
SET msgboxTitle=IMPORTANT
SET msgboxBody=Open your game and set your Render Distance between 2 - 5 and your FPS to 255
SET tmpmsgbox=%temp%\~tmpmsgbox.vbs
IF EXIST "%tmpmsgbox%" DEL /F /Q "%tmpmsgbox%"
ECHO msgbox "%msgboxBody%",0,"%msgboxTitle%">"%tmpmsgbox%"
WSCRIPT "%tmpmsgbox%"
exit

:1.8.9_iGPU_DynON
cls
curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\optionsof.txt" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/1.8.9_iGPU_DynON.txt"
SET msgboxTitle=IMPORTANT
SET msgboxBody=Open your game and set your Render Distance between 2 - 5 and your FPS to 255
SET tmpmsgbox=%temp%\~tmpmsgbox.vbs
IF EXIST "%tmpmsgbox%" DEL /F /Q "%tmpmsgbox%"
ECHO msgbox "%msgboxBody%",0,"%msgboxTitle%">"%tmpmsgbox%"
WSCRIPT "%tmpmsgbox%"
exit

:Exit
exit

:ColorText
echo off
<nul set /p ".=%DEL%" > "%~2"
findstr /v /a:%1 /R "^$" "%~2" nul
del "%~2" > nul  
goto :eof