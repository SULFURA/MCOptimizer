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
title Script MCOptimizer 2.1
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
set local=2.1
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
call :ColorText 08  "                                                            Version 2.1 
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
call :ColorText 08  "                                                            Version 2.1 
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
call :ColorText 08  "                                                            Version 2.1 
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
curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.ft\optionsof.txt" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/1.7.10_GPU_DynOFF.txt"
curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.lc\optionsof.txt" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/1.7.10_GPU_DynOFF.txt"

:: AZ-Client
if exist "C:\Users\%username%\AppData\Roaming\.az-client\config\" (
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.az-client\config\mods.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/AZ-Client/mods.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.az-client\config\options.txt" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/AZ-Client/options_gpu.json"
)

:: Badlion Client
if exist "C:\Users\%username%\AppData\Roaming\.minecraft\BLClient-Mod-Profiles\" (
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\badlion_settings.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/Badlion Client/badlion_settings.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\BLClient-Mod-Profiles\Vanilla.zip" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/Badlion Client/Vanilla.zip"
)

:: Badlion Client Lite
if exist "C:\Users\%username%\AppData\Roaming\.minecraft\BLClient-Mod-Profiles\" (
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\badlion_settings.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/Badlion Client Lite/badlion_settings.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\BLClient-Mod-Profiles\Vanilla.zip" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/Badlion Client Lite/Vanilla.zip"
) 

:: BatMod
if exist "C:\Users\%username%\AppData\Roaming\.minecraft\BatMod\" (
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\BatMod\hud.txt" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/BatMod/hud.txt"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\BatMod\options.txt" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/BatMod/options.txt"
)

:: BlazingPack
if exist "C:\Users\%username%\AppData\Roaming\Crystal-Launcher\instances\Blazingpack\" (
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\Crystal-Launcher\instances\Blazingpack\.minecraft\optionsbp.dat" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/BlazingPack/optionsbp.dat"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\Crystal-Launcher\instances\Blazingpack\.minecraft\optionsofbp.txt" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/BlazingPack/optionsofbp.txt"
) 

:: CheatBreaker
if exist "C:\Users\%username%\AppData\Roaming\.minecraft\config\cheatbreaker\" (
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\config\cheatbreaker\Default\general.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CheatBreaker/general.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\config\cheatbreaker\Default\mods.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CheatBreaker/mods.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\config\cheatbreaker\Default\performance.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CheatBreaker/performance.json"
)

:: CosmicLauncher
if exist "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\" (
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\admin_overlay.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/admin_overlay.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\anim.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/anim.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\armorhud.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/armorhud.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\breadcrumbs.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/breadcrumbs.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\chunkborders.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/chunkborders.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\compass.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/compass.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\cooldownhud.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/cooldownhud.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\crosshair.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/crosshair.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\cursorpersistence.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/cursorpersistence.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\emotes.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/emotes.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\eventhud.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/eventhud.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\hitsplat.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/hitsplat.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\hud.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/hud.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\leaderboard.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/leaderboard.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\mapwriter.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/mapwriter.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\minigame_leaderboard.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/minigame_leaderboard.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\mob_helper.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/mob_helper.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\motion_blur.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/motion_blur.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\notification_feed.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/notification_feed.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\peaceful_mining.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/peaceful_mining.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\perf.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/perf.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\ph.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/ph.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\pingallies.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/pingallies.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\polls.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/polls.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\potioncolors.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/potioncolors.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\roam.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/roam.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\satchelhud.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/satchelhud.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\schematica.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/schematica.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\scoreboard.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/scoreboard.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\screenshot.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/screenshot.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\settings.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/settings.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\tabchat.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/tabchat.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\target_health_bar.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/target_health_bar.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\togglesneak.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/togglesneak.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\togglesprint.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/togglesprint.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\tooltips.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/tooltips.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\vk.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/vk.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\voice.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/voice.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\wdl.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/wdl.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\worldborder.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/worldborder.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\worldeditcui.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/worldeditcui.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\xp_bar.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/xp_bar.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\xp_text.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/xp_text.json"
)

:: Feather Client
if exist "C:\Users\%username%\AppData\Roaming\.minecraft\feather\" (
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\feather\client_preferences.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/FeatherClient/client_preferences.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\essential\config.toml" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/FeatherClient/config.toml"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\feather\configuration\current.profile" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/FeatherClient/current.profile"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\feather\configuration\profiles\default.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/FeatherClient/default.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.feather\mods\feather-mods.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/FeatherClient/feather-mods.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.feather\user-mods\1.8.9\feather-mods.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/FeatherClient/HitDelayFix.jar"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\config\patcher_sounds.toml" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/FeatherClient/patcher_sounds.toml"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\config\patcher_sounds.toml" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/FeatherClient/patcher.toml"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\feather\patcher_sounds.toml" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/FeatherClient/sidebar.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.feather\user-mods\1.8.9\feather-mods.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/FeatherClient/TNT Time-1.1 (1.8.9).jar"

	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.ft\feather\client_preferences.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/FeatherClient/client_preferences.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.ft\essential\config.toml" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/FeatherClient/config.toml"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.ft\feather\configuration\current.profile" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/FeatherClient/current.profile"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.ft\feather\configuration\profiles\default.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/FeatherClient/default.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.ft\config\patcher_sounds.toml" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/FeatherClient/patcher_sounds.toml"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.ft\config\patcher_sounds.toml" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/FeatherClient/patcher.toml"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.ft\feather\patcher_sounds.toml" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/FeatherClient/sidebar.json"
)

:: LabyMod
if exist "C:\Users\%username%\AppData\Roaming\.minecraft\LabyMod\" (
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\LabyMod\addons-1.8\config\CustomCrosshair.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/LabyMod/CustomCrosshair.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\LabyMod\addons-1.8\config\CustomMainMenu.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/LabyMod/CustomMainMenu.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\LabyMod\addons-1.8\config\DamageIndicator.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/LabyMod/DamageIndicator.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\LabyMod\addons-1.8\config\DirectionHUD.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/LabyMod/DirectionHUD.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\LabyMod\addons-1.8\config\ItemPhysic.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/LabyMod/ItemPhysic.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\LabyMod\addons-1.8\config\Laby's Keystrokes.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/LabyMod/Laby's Keystrokes.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\LabyMod\addons-1.8\config\LabysMinimap.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/LabyMod/LabysMinimap.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\LabyMod\modules.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/LabyMod/modules.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\LabyMod\addons-1.8\config\MoreParticle.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/LabyMod/MoreParticle.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\LabyMod\addons-1.8\config\MotionBlur.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/LabyMod/MotionBlur.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\LabyMod\addons-1.8\config\Resourcepacks24.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/LabyMod/Resourcepacks24.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\LabyMod\addons-1.8\config\SettingsProfilesMod.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/LabyMod/SettingsProfilesMod.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\LabyMod\addons-1.8\config\SkyblockAddons.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/LabyMod/SkyblockAddons.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\LabyMod\addons-1.8\config\ToggleSneak.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/LabyMod/ToggleSneak.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\LabyMod\addons-1.8\config\VoiceChat.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/LabyMod/VoiceChat.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\LabyMod\addons-1.8\config\WorldEditCUI.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/LabyMod/WorldEditCUI.json"
)

:: Lunar Client
if exist "C:\Users\%username%\.lunarclient\settings\game\Default\" (
	curl -g -L -# -o "C:\Users\%username%\.lunarclient\settings\game\Default\general.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/LunarClient/general.json"
	curl -g -L -# -o "C:\Users\%username%\.lunarclient\settings\game\Default\mods.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/LunarClient/mods.json"
	curl -g -L -# -o "C:\Users\%username%\.lunarclient\settings\game\Default\performance.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/LunarClient/performance.json"
)


:: Salwyrr Launcher
if exist "C:\Users\%username%\AppData\Roaming\.Salwyrr\" (
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.Salwyrr\client.properties" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/SalwyrrLauncher/client.properties"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.Salwyrr\launcher\salwyrr.client.backup" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/SalwyrrLauncher/salwyrr.client.backup"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\salwyrr.properties.backup" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/SalwyrrLauncher/salwyrr.properties.backup"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.Salwyrr\launcher\cef\SalwyrrAdBrowser.jar" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/SalwyrrLauncher/SalwyrrAdBrowser.jar"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.Salwyrr\launcher\libs\SalwyrrConfig.jar" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/SalwyrrLauncher/SalwyrrConfig.jar"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.Salwyrr\optionsof.txt" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/1.7.10_GPU_DynOFF.txt"
)

:: Solar Tweaks
if exist "C:\Users\%username%\.lunarclient\solartweaks\" (
	curl -g -L -# -o "C:\Users\%username%\.lunarclient\solartweaks\config.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/Solar Tweaks/config.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\solartweaks\settings.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/SolarTweaks/settings.json"
)

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
curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.ft\optionsof.txt" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/1.7.10_GPU_DynON.txt"
curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.lc\optionsof.txt" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/1.7.10_GPU_DynON.txt"

:: AZ-Client
if exist "C:\Users\%username%\AppData\Roaming\.az-client\config\" (
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.az-client\config\mods.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/AZ-Client/mods.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.az-client\config\options.txt" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/AZ-Client/options_gpu.json"
	SET msgboxTitle=IMPORTANT
	SET msgboxBody=Open your game and set your Render Distance between 2 - 8 and your FPS to Unlimited
	SET tmpmsgbox=%temp%\~tmpmsgbox.vbs
	IF EXIST "%tmpmsgbox%" DEL /F /Q "%tmpmsgbox%"
	ECHO msgbox "%msgboxBody%",0,"%msgboxTitle%">"%tmpmsgbox%"
	WSCRIPT "%tmpmsgbox%"
	exit
) else (
	exit
)

:: Badlion Client
if exist "C:\Users\%username%\AppData\Roaming\.minecraft\BLClient-Mod-Profiles\" (
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\badlion_settings.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/Badlion Client/badlion_settings.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\BLClient-Mod-Profiles\Vanilla.zip" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/Badlion Client/Vanilla.zip"
	SET msgboxTitle=IMPORTANT
	SET msgboxBody=Open your game and set your Render Distance between 2 - 8 and your FPS to Unlimited
	SET tmpmsgbox=%temp%\~tmpmsgbox.vbs
	IF EXIST "%tmpmsgbox%" DEL /F /Q "%tmpmsgbox%"
	ECHO msgbox "%msgboxBody%",0,"%msgboxTitle%">"%tmpmsgbox%"
	WSCRIPT "%tmpmsgbox%"
	exit
) else (
	exit
)

:: Badlion Client Lite
if exist "C:\Users\%username%\AppData\Roaming\.minecraft\BLClient-Mod-Profiles\" (
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\badlion_settings.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/Badlion Client Lite/badlion_settings.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\BLClient-Mod-Profiles\Vanilla.zip" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/Badlion Client Lite/Vanilla.zip"
	SET msgboxTitle=IMPORTANT
	SET msgboxBody=Open your game and set your Render Distance between 2 - 8 and your FPS to Unlimited
	SET tmpmsgbox=%temp%\~tmpmsgbox.vbs
	IF EXIST "%tmpmsgbox%" DEL /F /Q "%tmpmsgbox%"
	ECHO msgbox "%msgboxBody%",0,"%msgboxTitle%">"%tmpmsgbox%"
	WSCRIPT "%tmpmsgbox%"
	exit

) else (
	exit
)

:: BatMod
if exist "C:\Users\%username%\AppData\Roaming\.minecraft\BatMod\" (
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\BatMod\hud.txt" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/BatMod/hud.txt"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\BatMod\options.txt" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/BatMod/options.txt"
	SET msgboxTitle=IMPORTANT
	SET msgboxBody=Open your game and set your Render Distance between 2 - 8 and your FPS to Unlimited
	SET tmpmsgbox=%temp%\~tmpmsgbox.vbs
	IF EXIST "%tmpmsgbox%" DEL /F /Q "%tmpmsgbox%"
	ECHO msgbox "%msgboxBody%",0,"%msgboxTitle%">"%tmpmsgbox%"
	WSCRIPT "%tmpmsgbox%"
	exit
) else (
	exit
)

:: BlazingPack
if exist "C:\Users\%username%\AppData\Roaming\Crystal-Launcher\instances\Blazingpack\" (
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\Crystal-Launcher\instances\Blazingpack\.minecraft\optionsbp.dat" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/BlazingPack/optionsbp.dat"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\Crystal-Launcher\instances\Blazingpack\.minecraft\optionsofbp.txt" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/BlazingPack/optionsofbp.txt"
	SET msgboxTitle=IMPORTANT
	SET msgboxBody=Open your game and set your Render Distance between 2 - 8 and your FPS to Unlimited
	SET tmpmsgbox=%temp%\~tmpmsgbox.vbs
	IF EXIST "%tmpmsgbox%" DEL /F /Q "%tmpmsgbox%"
	ECHO msgbox "%msgboxBody%",0,"%msgboxTitle%">"%tmpmsgbox%"
	WSCRIPT "%tmpmsgbox%"
	exit
) else (
	exit
)

:: CheatBreaker
if exist "C:\Users\%username%\AppData\Roaming\.minecraft\config\cheatbreaker\" (
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\config\cheatbreaker\Default\general.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CheatBreaker/general.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\config\cheatbreaker\Default\mods.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CheatBreaker/mods.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\config\cheatbreaker\Default\performance.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CheatBreaker/performance.json"
	SET msgboxTitle=IMPORTANT
	SET msgboxBody=Open your game and set your Render Distance between 2 - 8 and your FPS to Unlimited
	SET tmpmsgbox=%temp%\~tmpmsgbox.vbs
	IF EXIST "%tmpmsgbox%" DEL /F /Q "%tmpmsgbox%"
	ECHO msgbox "%msgboxBody%",0,"%msgboxTitle%">"%tmpmsgbox%"
	WSCRIPT "%tmpmsgbox%"
	exit
) else (
	exit
)

:: CosmicLauncher
if exist "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\" (
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\admin_overlay.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/admin_overlay.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\anim.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/anim.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\armorhud.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/armorhud.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\breadcrumbs.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/breadcrumbs.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\chunkborders.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/chunkborders.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\compass.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/compass.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\cooldownhud.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/cooldownhud.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\crosshair.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/crosshair.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\cursorpersistence.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/cursorpersistence.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\emotes.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/emotes.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\eventhud.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/eventhud.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\hitsplat.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/hitsplat.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\hud.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/hud.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\leaderboard.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/leaderboard.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\mapwriter.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/mapwriter.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\minigame_leaderboard.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/minigame_leaderboard.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\mob_helper.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/mob_helper.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\motion_blur.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/motion_blur.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\notification_feed.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/notification_feed.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\peaceful_mining.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/peaceful_mining.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\perf.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/perf.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\ph.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/ph.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\pingallies.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/pingallies.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\polls.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/polls.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\potioncolors.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/potioncolors.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\roam.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/roam.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\satchelhud.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/satchelhud.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\schematica.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/schematica.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\scoreboard.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/scoreboard.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\screenshot.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/screenshot.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\settings.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/settings.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\tabchat.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/tabchat.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\target_health_bar.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/target_health_bar.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\togglesneak.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/togglesneak.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\togglesprint.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/togglesprint.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\tooltips.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/tooltips.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\vk.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/vk.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\voice.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/voice.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\wdl.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/wdl.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\worldborder.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/worldborder.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\worldeditcui.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/worldeditcui.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\xp_bar.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/xp_bar.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\xp_text.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/xp_text.json"
	SET msgboxTitle=IMPORTANT
	SET msgboxBody=Open your game and set your Render Distance between 2 - 8 and your FPS to Unlimited
	SET tmpmsgbox=%temp%\~tmpmsgbox.vbs
	IF EXIST "%tmpmsgbox%" DEL /F /Q "%tmpmsgbox%"
	ECHO msgbox "%msgboxBody%",0,"%msgboxTitle%">"%tmpmsgbox%"
	WSCRIPT "%tmpmsgbox%"
	exit
) else (
	exit
)

:: Feather Client
if exist "C:\Users\%username%\AppData\Roaming\.minecraft\feather\" (
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\feather\client_preferences.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/FeatherClient/client_preferences.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\essential\config.toml" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/FeatherClient/config.toml"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\feather\configuration\current.profile" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/FeatherClient/current.profile"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\feather\configuration\profiles\default.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/FeatherClient/default.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.feather\mods\feather-mods.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/FeatherClient/feather-mods.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.feather\user-mods\1.8.9\feather-mods.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/FeatherClient/HitDelayFix.jar"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\config\patcher_sounds.toml" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/FeatherClient/patcher_sounds.toml"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\config\patcher_sounds.toml" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/FeatherClient/patcher.toml"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\feather\patcher_sounds.toml" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/FeatherClient/sidebar.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.feather\user-mods\1.8.9\feather-mods.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/FeatherClient/TNT Time-1.1 (1.8.9).jar"

	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.ft\feather\client_preferences.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/FeatherClient/client_preferences.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.ft\essential\config.toml" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/FeatherClient/config.toml"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.ft\feather\configuration\current.profile" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/FeatherClient/current.profile"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.ft\feather\configuration\profiles\default.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/FeatherClient/default.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.ft\config\patcher_sounds.toml" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/FeatherClient/patcher_sounds.toml"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.ft\config\patcher_sounds.toml" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/FeatherClient/patcher.toml"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.ft\feather\patcher_sounds.toml" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/FeatherClient/sidebar.json"
	SET msgboxTitle=IMPORTANT
	SET msgboxBody=Open your game and set your Render Distance between 2 - 8 and your FPS to Unlimited
	SET tmpmsgbox=%temp%\~tmpmsgbox.vbs
	IF EXIST "%tmpmsgbox%" DEL /F /Q "%tmpmsgbox%"
	ECHO msgbox "%msgboxBody%",0,"%msgboxTitle%">"%tmpmsgbox%"
	WSCRIPT "%tmpmsgbox%"
	exit
) else (
	exit
)

:: LabyMod
if exist "C:\Users\%username%\AppData\Roaming\.minecraft\LabyMod\" (
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\LabyMod\addons-1.8\config\CustomCrosshair.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/LabyMod/CustomCrosshair.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\LabyMod\addons-1.8\config\CustomMainMenu.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/LabyMod/CustomMainMenu.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\LabyMod\addons-1.8\config\DamageIndicator.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/LabyMod/DamageIndicator.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\LabyMod\addons-1.8\config\DirectionHUD.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/LabyMod/DirectionHUD.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\LabyMod\addons-1.8\config\ItemPhysic.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/LabyMod/ItemPhysic.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\LabyMod\addons-1.8\config\Laby's Keystrokes.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/LabyMod/Laby's Keystrokes.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\LabyMod\addons-1.8\config\LabysMinimap.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/LabyMod/LabysMinimap.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\LabyMod\modules.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/LabyMod/modules.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\LabyMod\addons-1.8\config\MoreParticle.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/LabyMod/MoreParticle.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\LabyMod\addons-1.8\config\MotionBlur.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/LabyMod/MotionBlur.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\LabyMod\addons-1.8\config\Resourcepacks24.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/LabyMod/Resourcepacks24.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\LabyMod\addons-1.8\config\SettingsProfilesMod.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/LabyMod/SettingsProfilesMod.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\LabyMod\addons-1.8\config\SkyblockAddons.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/LabyMod/SkyblockAddons.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\LabyMod\addons-1.8\config\ToggleSneak.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/LabyMod/ToggleSneak.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\LabyMod\addons-1.8\config\VoiceChat.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/LabyMod/VoiceChat.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\LabyMod\addons-1.8\config\WorldEditCUI.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/LabyMod/WorldEditCUI.json"
	SET msgboxTitle=IMPORTANT
	SET msgboxBody=Open your game and set your Render Distance between 2 - 8 and your FPS to Unlimited
	SET tmpmsgbox=%temp%\~tmpmsgbox.vbs
	IF EXIST "%tmpmsgbox%" DEL /F /Q "%tmpmsgbox%"
	ECHO msgbox "%msgboxBody%",0,"%msgboxTitle%">"%tmpmsgbox%"
	WSCRIPT "%tmpmsgbox%"
	exit
) else (
	exit
)

:: Lunar Client
if exist "C:\Users\%username%\.lunarclient\settings\game\Default\" (
	curl -g -L -# -o "C:\Users\%username%\.lunarclient\settings\game\Default\general.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/LunarClient/general.json"
	curl -g -L -# -o "C:\Users\%username%\.lunarclient\settings\game\Default\mods.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/LunarClient/mods.json"
	curl -g -L -# -o "C:\Users\%username%\.lunarclient\settings\game\Default\performance.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/LunarClient/performance.json"
	SET msgboxTitle=IMPORTANT
	SET msgboxBody=Open your game and set your Render Distance between 2 - 8 and your FPS to Unlimited
	SET tmpmsgbox=%temp%\~tmpmsgbox.vbs
	IF EXIST "%tmpmsgbox%" DEL /F /Q "%tmpmsgbox%"
	ECHO msgbox "%msgboxBody%",0,"%msgboxTitle%">"%tmpmsgbox%"
	WSCRIPT "%tmpmsgbox%"
	exit
) else (
	exit
)


:: Salwyrr Launcher
if exist "C:\Users\%username%\AppData\Roaming\.Salwyrr\" (
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.Salwyrr\client.properties" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/SalwyrrLauncher/client.properties"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.Salwyrr\launcher\salwyrr.client.backup" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/SalwyrrLauncher/salwyrr.client.backup"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\salwyrr.properties.backup" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/SalwyrrLauncher/salwyrr.properties.backup"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.Salwyrr\launcher\cef\SalwyrrAdBrowser.jar" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/SalwyrrLauncher/SalwyrrAdBrowser.jar"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.Salwyrr\launcher\libs\SalwyrrConfig.jar" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/SalwyrrLauncher/SalwyrrConfig.jar"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.Salwyrr\optionsof.txt" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/1.7.10_GPU_DynOFF.txt"
	SET msgboxTitle=IMPORTANT
	SET msgboxBody=Open your game and set your Render Distance between 2 - 8 and your FPS to Unlimited
	SET tmpmsgbox=%temp%\~tmpmsgbox.vbs
	IF EXIST "%tmpmsgbox%" DEL /F /Q "%tmpmsgbox%"
	ECHO msgbox "%msgboxBody%",0,"%msgboxTitle%">"%tmpmsgbox%"
	WSCRIPT "%tmpmsgbox%"
	exit
) else (
	exit
)

:: Solar Tweaks
if exist "C:\Users\%username%\AppData\Roaming\Crystal-Launcher\instances\Blazingpack\" (
	curl -g -L -# -o "C:\Users\%username%\.lunarclient\solartweaks\config.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/Solar Tweaks/badlion_settings.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\solartweaks\settings.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/Solar Tweaks/settings.json"
	SET msgboxTitle=IMPORTANT
	SET msgboxBody=Open your game and set your Render Distance between 2 - 8 and your FPS to Unlimited
	SET tmpmsgbox=%temp%\~tmpmsgbox.vbs
	IF EXIST "%tmpmsgbox%" DEL /F /Q "%tmpmsgbox%"
	ECHO msgbox "%msgboxBody%",0,"%msgboxTitle%">"%tmpmsgbox%"
	WSCRIPT "%tmpmsgbox%"
	exit
) else (
	exit
)

:1.8.9_GPU
cls
echo.
echo.
call :ColorText 08  "                                                            Version 2.1 
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
curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.ft\optionsof.txt" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/1.8.9_GPU_DynOFF.txt"
curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.lc\optionsof.txt" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/1.8.9_GPU_DynOFF.txt"

:: AZ-Client
if exist "C:\Users\%username%\AppData\Roaming\.az-client\config\" (
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.az-client\config\mods.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/AZ-Client/mods.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.az-client\config\options.txt" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/AZ-Client/options_gpu.json"
	SET msgboxTitle=IMPORTANT
	SET msgboxBody=Open your game and set your Render Distance between 2 - 8 and your FPS to Unlimited
	SET tmpmsgbox=%temp%\~tmpmsgbox.vbs
	IF EXIST "%tmpmsgbox%" DEL /F /Q "%tmpmsgbox%"
	ECHO msgbox "%msgboxBody%",0,"%msgboxTitle%">"%tmpmsgbox%"
	WSCRIPT "%tmpmsgbox%"
	exit
) else (
	exit
)

:: Badlion Client
if exist "C:\Users\%username%\AppData\Roaming\.minecraft\BLClient-Mod-Profiles\" (
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\badlion_settings.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/BadlionClient/badlion_settings.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\BLClient-Mod-Profiles\Vanilla.zip" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/BadlionClient/Vanilla.zip"
	SET msgboxTitle=IMPORTANT
	SET msgboxBody=Open your game and set your Render Distance between 2 - 8 and your FPS to Unlimited
	SET tmpmsgbox=%temp%\~tmpmsgbox.vbs
	IF EXIST "%tmpmsgbox%" DEL /F /Q "%tmpmsgbox%"
	ECHO msgbox "%msgboxBody%",0,"%msgboxTitle%">"%tmpmsgbox%"
	WSCRIPT "%tmpmsgbox%"
	exit
) else (
	exit
)

:: Badlion Client Lite
if exist "C:\Users\%username%\AppData\Roaming\.minecraft\BLClient-Mod-Profiles\" (
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\badlion_settings.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/BadlionClientLite/badlion_settings.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\BLClient-Mod-Profiles\Vanilla.zip" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/BadlionClientLite/Vanilla.zip"
	SET msgboxTitle=IMPORTANT
	SET msgboxBody=Open your game and set your Render Distance between 2 - 8 and your FPS to Unlimited
	SET tmpmsgbox=%temp%\~tmpmsgbox.vbs
	IF EXIST "%tmpmsgbox%" DEL /F /Q "%tmpmsgbox%"
	ECHO msgbox "%msgboxBody%",0,"%msgboxTitle%">"%tmpmsgbox%"
	WSCRIPT "%tmpmsgbox%"
	exit

) else (
	exit
)

:: BatMod
if exist "C:\Users\%username%\AppData\Roaming\.minecraft\BatMod\" (
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\BatMod\hud.txt" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/BatMod/hud.txt"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\BatMod\options.txt" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/BatMod/options.txt"
	SET msgboxTitle=IMPORTANT
	SET msgboxBody=Open your game and set your Render Distance between 2 - 8 and your FPS to Unlimited
	SET tmpmsgbox=%temp%\~tmpmsgbox.vbs
	IF EXIST "%tmpmsgbox%" DEL /F /Q "%tmpmsgbox%"
	ECHO msgbox "%msgboxBody%",0,"%msgboxTitle%">"%tmpmsgbox%"
	WSCRIPT "%tmpmsgbox%"
	exit
) else (
	exit
)

:: BlazingPack
if exist "C:\Users\%username%\AppData\Roaming\Crystal-Launcher\instances\Blazingpack\" (
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\Crystal-Launcher\instances\Blazingpack\.minecraft\optionsbp.dat" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/BlazingPack/optionsbp.dat"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\Crystal-Launcher\instances\Blazingpack\.minecraft\optionsofbp.txt" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/BlazingPack/optionsofbp.txt"
	SET msgboxTitle=IMPORTANT
	SET msgboxBody=Open your game and set your Render Distance between 2 - 8 and your FPS to Unlimited
	SET tmpmsgbox=%temp%\~tmpmsgbox.vbs
	IF EXIST "%tmpmsgbox%" DEL /F /Q "%tmpmsgbox%"
	ECHO msgbox "%msgboxBody%",0,"%msgboxTitle%">"%tmpmsgbox%"
	WSCRIPT "%tmpmsgbox%"
	exit
) else (
	exit
)

:: CheatBreaker
if exist "C:\Users\%username%\AppData\Roaming\.minecraft\config\cheatbreaker\" (
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\config\cheatbreaker\Default\general.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CheatBreaker/general.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\config\cheatbreaker\Default\mods.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CheatBreaker/mods.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\config\cheatbreaker\Default\performance.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CheatBreaker/performance.json"
	SET msgboxTitle=IMPORTANT
	SET msgboxBody=Open your game and set your Render Distance between 2 - 8 and your FPS to Unlimited
	SET tmpmsgbox=%temp%\~tmpmsgbox.vbs
	IF EXIST "%tmpmsgbox%" DEL /F /Q "%tmpmsgbox%"
	ECHO msgbox "%msgboxBody%",0,"%msgboxTitle%">"%tmpmsgbox%"
	WSCRIPT "%tmpmsgbox%"
	exit
) else (
	exit
)

:: CosmicLauncher
if exist "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\" (
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\admin_overlay.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/admin_overlay.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\anim.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/anim.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\armorhud.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/armorhud.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\breadcrumbs.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/breadcrumbs.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\chunkborders.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/chunkborders.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\compass.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/compass.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\cooldownhud.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/cooldownhud.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\crosshair.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/crosshair.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\cursorpersistence.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/cursorpersistence.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\emotes.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/emotes.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\eventhud.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/eventhud.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\hitsplat.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/hitsplat.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\hud.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/hud.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\leaderboard.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/leaderboard.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\mapwriter.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/mapwriter.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\minigame_leaderboard.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/minigame_leaderboard.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\mob_helper.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/mob_helper.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\motion_blur.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/motion_blur.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\notification_feed.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/notification_feed.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\peaceful_mining.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/peaceful_mining.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\perf.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/perf.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\ph.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/ph.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\pingallies.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/pingallies.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\polls.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/polls.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\potioncolors.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/potioncolors.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\roam.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/roam.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\satchelhud.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/satchelhud.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\schematica.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/schematica.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\scoreboard.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/scoreboard.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\screenshot.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/screenshot.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\settings.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/settings.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\tabchat.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/tabchat.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\target_health_bar.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/target_health_bar.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\togglesneak.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/togglesneak.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\togglesprint.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/togglesprint.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\tooltips.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/tooltips.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\vk.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/vk.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\voice.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/voice.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\wdl.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/wdl.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\worldborder.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/worldborder.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\worldeditcui.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/worldeditcui.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\xp_bar.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/xp_bar.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\xp_text.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/xp_text.json"
	SET msgboxTitle=IMPORTANT
	SET msgboxBody=Open your game and set your Render Distance between 2 - 8 and your FPS to Unlimited
	SET tmpmsgbox=%temp%\~tmpmsgbox.vbs
	IF EXIST "%tmpmsgbox%" DEL /F /Q "%tmpmsgbox%"
	ECHO msgbox "%msgboxBody%",0,"%msgboxTitle%">"%tmpmsgbox%"
	WSCRIPT "%tmpmsgbox%"
	exit
) else (
	exit
)

:: Feather Client
if exist "C:\Users\%username%\AppData\Roaming\.minecraft\feather\" (
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\feather\client_preferences.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/FeatherClient/client_preferences.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\essential\config.toml" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/FeatherClient/config.toml"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\feather\configuration\current.profile" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/FeatherClient/current.profile"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\feather\configuration\profiles\default.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/FeatherClient/default.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.feather\mods\feather-mods.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/FeatherClient/feather-mods.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.feather\user-mods\1.8.9\feather-mods.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/FeatherClient/HitDelayFix.jar"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\config\patcher_sounds.toml" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/FeatherClient/patcher_sounds.toml"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\config\patcher_sounds.toml" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/FeatherClient/patcher.toml"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\feather\patcher_sounds.toml" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/FeatherClient/sidebar.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.feather\user-mods\1.8.9\feather-mods.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/FeatherClient/TNT Time-1.1 (1.8.9).jar"

	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.ft\feather\client_preferences.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/FeatherClient/client_preferences.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.ft\essential\config.toml" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/FeatherClient/config.toml"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.ft\feather\configuration\current.profile" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/FeatherClient/current.profile"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.ft\feather\configuration\profiles\default.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/FeatherClient/default.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.ft\config\patcher_sounds.toml" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/FeatherClient/patcher_sounds.toml"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.ft\config\patcher_sounds.toml" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/FeatherClient/patcher.toml"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.ft\feather\patcher_sounds.toml" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/FeatherClient/sidebar.json"
	SET msgboxTitle=IMPORTANT
	SET msgboxBody=Open your game and set your Render Distance between 2 - 8 and your FPS to Unlimited
	SET tmpmsgbox=%temp%\~tmpmsgbox.vbs
	IF EXIST "%tmpmsgbox%" DEL /F /Q "%tmpmsgbox%"
	ECHO msgbox "%msgboxBody%",0,"%msgboxTitle%">"%tmpmsgbox%"
	WSCRIPT "%tmpmsgbox%"
	exit
) else (
	exit
)

:: LabyMod
if exist "C:\Users\%username%\AppData\Roaming\.minecraft\LabyMod\" (
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\LabyMod\addons-1.8\config\CustomCrosshair.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/LabyMod/CustomCrosshair.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\LabyMod\addons-1.8\config\CustomMainMenu.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/LabyMod/CustomMainMenu.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\LabyMod\addons-1.8\config\DamageIndicator.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/LabyMod/DamageIndicator.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\LabyMod\addons-1.8\config\DirectionHUD.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/LabyMod/DirectionHUD.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\LabyMod\addons-1.8\config\ItemPhysic.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/LabyMod/ItemPhysic.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\LabyMod\addons-1.8\config\Laby's Keystrokes.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/LabyMod/Laby's Keystrokes.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\LabyMod\addons-1.8\config\LabysMinimap.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/LabyMod/LabysMinimap.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\LabyMod\modules.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/LabyMod/modules.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\LabyMod\addons-1.8\config\MoreParticle.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/LabyMod/MoreParticle.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\LabyMod\addons-1.8\config\MotionBlur.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/LabyMod/MotionBlur.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\LabyMod\addons-1.8\config\Resourcepacks24.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/LabyMod/Resourcepacks24.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\LabyMod\addons-1.8\config\SettingsProfilesMod.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/LabyMod/SettingsProfilesMod.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\LabyMod\addons-1.8\config\SkyblockAddons.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/LabyMod/SkyblockAddons.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\LabyMod\addons-1.8\config\ToggleSneak.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/LabyMod/ToggleSneak.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\LabyMod\addons-1.8\config\VoiceChat.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/LabyMod/VoiceChat.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\LabyMod\addons-1.8\config\WorldEditCUI.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/LabyMod/WorldEditCUI.json"
	SET msgboxTitle=IMPORTANT
	SET msgboxBody=Open your game and set your Render Distance between 2 - 8 and your FPS to Unlimited
	SET tmpmsgbox=%temp%\~tmpmsgbox.vbs
	IF EXIST "%tmpmsgbox%" DEL /F /Q "%tmpmsgbox%"
	ECHO msgbox "%msgboxBody%",0,"%msgboxTitle%">"%tmpmsgbox%"
	WSCRIPT "%tmpmsgbox%"
	exit
) else (
	exit
)

:: Lunar Client
if exist "C:\Users\%username%\.lunarclient\settings\game\Default\" (
	curl -g -L -# -o "C:\Users\%username%\.lunarclient\settings\game\Default\general.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/LunarClient/general.json"
	curl -g -L -# -o "C:\Users\%username%\.lunarclient\settings\game\Default\mods.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/LunarClient/mods.json"
	curl -g -L -# -o "C:\Users\%username%\.lunarclient\settings\game\Default\performance.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/LunarClient/performance.json"
	SET msgboxTitle=IMPORTANT
	SET msgboxBody=Open your game and set your Render Distance between 2 - 8 and your FPS to Unlimited
	SET tmpmsgbox=%temp%\~tmpmsgbox.vbs
	IF EXIST "%tmpmsgbox%" DEL /F /Q "%tmpmsgbox%"
	ECHO msgbox "%msgboxBody%",0,"%msgboxTitle%">"%tmpmsgbox%"
	WSCRIPT "%tmpmsgbox%"
	exit
) else (
	exit
)


:: Salwyrr Launcher
if exist "C:\Users\%username%\AppData\Roaming\.Salwyrr\" (
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.Salwyrr\client.properties" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/SalwyrrLauncher/client.properties"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.Salwyrr\launcher\salwyrr.client.backup" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/SalwyrrLauncher/salwyrr.client.backup"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\salwyrr.properties.backup" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/SalwyrrLauncher/salwyrr.properties.backup"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.Salwyrr\launcher\cef\SalwyrrAdBrowser.jar" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/SalwyrrLauncher/SalwyrrAdBrowser.jar"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.Salwyrr\launcher\libs\SalwyrrConfig.jar" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/SalwyrrLauncher/SalwyrrConfig.jar"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.Salwyrr\optionsof.txt" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/1.7.10_GPU_DynOFF.txt"
	SET msgboxTitle=IMPORTANT
	SET msgboxBody=Open your game and set your Render Distance between 2 - 8 and your FPS to Unlimited
	SET tmpmsgbox=%temp%\~tmpmsgbox.vbs
	IF EXIST "%tmpmsgbox%" DEL /F /Q "%tmpmsgbox%"
	ECHO msgbox "%msgboxBody%",0,"%msgboxTitle%">"%tmpmsgbox%"
	WSCRIPT "%tmpmsgbox%"
	exit
) else (
	exit
)

:: Solar Tweaks
if exist "C:\Users\%username%\AppData\Roaming\Crystal-Launcher\instances\Blazingpack\" (
	curl -g -L -# -o "C:\Users\%username%\.lunarclient\solartweaks\config.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/SolarTweaks/badlion_settings.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\solartweaks\settings.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/SolarTweaks/settings.json"
	SET msgboxTitle=IMPORTANT
	SET msgboxBody=Open your game and set your Render Distance between 2 - 8 and your FPS to Unlimited
	SET tmpmsgbox=%temp%\~tmpmsgbox.vbs
	IF EXIST "%tmpmsgbox%" DEL /F /Q "%tmpmsgbox%"
	ECHO msgbox "%msgboxBody%",0,"%msgboxTitle%">"%tmpmsgbox%"
	WSCRIPT "%tmpmsgbox%"
	exit
) else (
	exit
)

:1.8.9_GPU_DynON
cls
curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\optionsof.txt" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/1.8.9_GPU_DynON.txt"
curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.ft\optionsof.txt" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/1.8.9_GPU_DynON.txt"
curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.lc\optionsof.txt" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/1.8.9_GPU_DynON.txt"

:: AZ-Client
if exist "C:\Users\%username%\AppData\Roaming\.az-client\config\" (
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.az-client\config\mods.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/AZ-Client/mods.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.az-client\config\options.txt" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/AZ-Client/options_gpu.json"
	SET msgboxTitle=IMPORTANT
	SET msgboxBody=Open your game and set your Render Distance between 2 - 8 and your FPS to Unlimited
	SET tmpmsgbox=%temp%\~tmpmsgbox.vbs
	IF EXIST "%tmpmsgbox%" DEL /F /Q "%tmpmsgbox%"
	ECHO msgbox "%msgboxBody%",0,"%msgboxTitle%">"%tmpmsgbox%"
	WSCRIPT "%tmpmsgbox%"
	exit
) else (
	exit
)

:: Badlion Client
if exist "C:\Users\%username%\AppData\Roaming\.minecraft\BLClient-Mod-Profiles\" (
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\badlion_settings.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/Badlion Client/badlion_settings.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\BLClient-Mod-Profiles\Vanilla.zip" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/Badlion Client/Vanilla.zip"
	SET msgboxTitle=IMPORTANT
	SET msgboxBody=Open your game and set your Render Distance between 2 - 8 and your FPS to Unlimited
	SET tmpmsgbox=%temp%\~tmpmsgbox.vbs
	IF EXIST "%tmpmsgbox%" DEL /F /Q "%tmpmsgbox%"
	ECHO msgbox "%msgboxBody%",0,"%msgboxTitle%">"%tmpmsgbox%"
	WSCRIPT "%tmpmsgbox%"
	exit
) else (
	exit
)

:: Badlion Client Lite
if exist "C:\Users\%username%\AppData\Roaming\.minecraft\BLClient-Mod-Profiles\" (
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\badlion_settings.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/Badlion Client Lite/badlion_settings.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\BLClient-Mod-Profiles\Vanilla.zip" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/Badlion Client Lite/Vanilla.zip"
	SET msgboxTitle=IMPORTANT
	SET msgboxBody=Open your game and set your Render Distance between 2 - 8 and your FPS to Unlimited
	SET tmpmsgbox=%temp%\~tmpmsgbox.vbs
	IF EXIST "%tmpmsgbox%" DEL /F /Q "%tmpmsgbox%"
	ECHO msgbox "%msgboxBody%",0,"%msgboxTitle%">"%tmpmsgbox%"
	WSCRIPT "%tmpmsgbox%"
	exit

) else (
	exit
)

:: BatMod
if exist "C:\Users\%username%\AppData\Roaming\.minecraft\BatMod\" (
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\BatMod\hud.txt" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/BatMod/hud.txt"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\BatMod\options.txt" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/BatMod/options.txt"
	SET msgboxTitle=IMPORTANT
	SET msgboxBody=Open your game and set your Render Distance between 2 - 8 and your FPS to Unlimited
	SET tmpmsgbox=%temp%\~tmpmsgbox.vbs
	IF EXIST "%tmpmsgbox%" DEL /F /Q "%tmpmsgbox%"
	ECHO msgbox "%msgboxBody%",0,"%msgboxTitle%">"%tmpmsgbox%"
	WSCRIPT "%tmpmsgbox%"
	exit
) else (
	exit
)

:: BlazingPack
if exist "C:\Users\%username%\AppData\Roaming\Crystal-Launcher\instances\Blazingpack\" (
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\Crystal-Launcher\instances\Blazingpack\.minecraft\optionsbp.dat" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/BlazingPack/optionsbp.dat"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\Crystal-Launcher\instances\Blazingpack\.minecraft\optionsofbp.txt" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/BlazingPack/optionsofbp.txt"
	SET msgboxTitle=IMPORTANT
	SET msgboxBody=Open your game and set your Render Distance between 2 - 8 and your FPS to Unlimited
	SET tmpmsgbox=%temp%\~tmpmsgbox.vbs
	IF EXIST "%tmpmsgbox%" DEL /F /Q "%tmpmsgbox%"
	ECHO msgbox "%msgboxBody%",0,"%msgboxTitle%">"%tmpmsgbox%"
	WSCRIPT "%tmpmsgbox%"
	exit
) else (
	exit
)

:: CheatBreaker
if exist "C:\Users\%username%\AppData\Roaming\.minecraft\config\cheatbreaker\" (
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\config\cheatbreaker\Default\general.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CheatBreaker/general.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\config\cheatbreaker\Default\mods.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CheatBreaker/mods.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\config\cheatbreaker\Default\performance.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CheatBreaker/performance.json"
	SET msgboxTitle=IMPORTANT
	SET msgboxBody=Open your game and set your Render Distance between 2 - 8 and your FPS to Unlimited
	SET tmpmsgbox=%temp%\~tmpmsgbox.vbs
	IF EXIST "%tmpmsgbox%" DEL /F /Q "%tmpmsgbox%"
	ECHO msgbox "%msgboxBody%",0,"%msgboxTitle%">"%tmpmsgbox%"
	WSCRIPT "%tmpmsgbox%"
	exit
) else (
	exit
)

:: CosmicLauncher
if exist "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\" (
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\admin_overlay.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/admin_overlay.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\anim.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/anim.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\armorhud.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/armorhud.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\breadcrumbs.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/breadcrumbs.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\chunkborders.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/chunkborders.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\compass.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/compass.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\cooldownhud.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/cooldownhud.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\crosshair.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/crosshair.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\cursorpersistence.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/cursorpersistence.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\emotes.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/emotes.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\eventhud.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/eventhud.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\hitsplat.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/hitsplat.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\hud.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/hud.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\leaderboard.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/leaderboard.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\mapwriter.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/mapwriter.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\minigame_leaderboard.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/minigame_leaderboard.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\mob_helper.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/mob_helper.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\motion_blur.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/motion_blur.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\notification_feed.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/notification_feed.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\peaceful_mining.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/peaceful_mining.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\perf.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/perf.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\ph.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/ph.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\pingallies.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/pingallies.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\polls.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/polls.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\potioncolors.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/potioncolors.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\roam.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/roam.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\satchelhud.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/satchelhud.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\schematica.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/schematica.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\scoreboard.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/scoreboard.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\screenshot.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/screenshot.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\settings.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/settings.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\tabchat.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/tabchat.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\target_health_bar.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/target_health_bar.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\togglesneak.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/togglesneak.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\togglesprint.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/togglesprint.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\tooltips.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/tooltips.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\vk.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/vk.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\voice.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/voice.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\wdl.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/wdl.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\worldborder.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/worldborder.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\worldeditcui.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/worldeditcui.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\xp_bar.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/xp_bar.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\xp_text.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/xp_text.json"
	SET msgboxTitle=IMPORTANT
	SET msgboxBody=Open your game and set your Render Distance between 2 - 8 and your FPS to Unlimited
	SET tmpmsgbox=%temp%\~tmpmsgbox.vbs
	IF EXIST "%tmpmsgbox%" DEL /F /Q "%tmpmsgbox%"
	ECHO msgbox "%msgboxBody%",0,"%msgboxTitle%">"%tmpmsgbox%"
	WSCRIPT "%tmpmsgbox%"
	exit
) else (
	exit
)

:: Feather Client
if exist "C:\Users\%username%\AppData\Roaming\.minecraft\feather\" (
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\feather\client_preferences.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/FeatherClient/client_preferences.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\essential\config.toml" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/FeatherClient/config.toml"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\feather\configuration\current.profile" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/FeatherClient/current.profile"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\feather\configuration\profiles\default.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/FeatherClient/default.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.feather\mods\feather-mods.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/FeatherClient/feather-mods.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.feather\user-mods\1.8.9\feather-mods.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/FeatherClient/HitDelayFix.jar"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\config\patcher_sounds.toml" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/FeatherClient/patcher_sounds.toml"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\config\patcher_sounds.toml" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/FeatherClient/patcher.toml"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\feather\patcher_sounds.toml" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/FeatherClient/sidebar.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.feather\user-mods\1.8.9\feather-mods.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/FeatherClient/TNT Time-1.1 (1.8.9).jar"

	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.ft\feather\client_preferences.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/FeatherClient/client_preferences.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.ft\essential\config.toml" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/FeatherClient/config.toml"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.ft\feather\configuration\current.profile" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/FeatherClient/current.profile"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.ft\feather\configuration\profiles\default.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/FeatherClient/default.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.ft\config\patcher_sounds.toml" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/FeatherClient/patcher_sounds.toml"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.ft\config\patcher_sounds.toml" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/FeatherClient/patcher.toml"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.ft\feather\patcher_sounds.toml" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/FeatherClient/sidebar.json"
	SET msgboxTitle=IMPORTANT
	SET msgboxBody=Open your game and set your Render Distance between 2 - 8 and your FPS to Unlimited
	SET tmpmsgbox=%temp%\~tmpmsgbox.vbs
	IF EXIST "%tmpmsgbox%" DEL /F /Q "%tmpmsgbox%"
	ECHO msgbox "%msgboxBody%",0,"%msgboxTitle%">"%tmpmsgbox%"
	WSCRIPT "%tmpmsgbox%"
	exit
) else (
	exit
)

:: LabyMod
if exist "C:\Users\%username%\AppData\Roaming\.minecraft\LabyMod\" (
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\LabyMod\addons-1.8\config\CustomCrosshair.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/LabyMod/CustomCrosshair.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\LabyMod\addons-1.8\config\CustomMainMenu.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/LabyMod/CustomMainMenu.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\LabyMod\addons-1.8\config\DamageIndicator.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/LabyMod/DamageIndicator.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\LabyMod\addons-1.8\config\DirectionHUD.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/LabyMod/DirectionHUD.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\LabyMod\addons-1.8\config\ItemPhysic.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/LabyMod/ItemPhysic.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\LabyMod\addons-1.8\config\Laby's Keystrokes.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/LabyMod/Laby's Keystrokes.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\LabyMod\addons-1.8\config\LabysMinimap.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/LabyMod/LabysMinimap.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\LabyMod\modules.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/LabyMod/modules.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\LabyMod\addons-1.8\config\MoreParticle.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/LabyMod/MoreParticle.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\LabyMod\addons-1.8\config\MotionBlur.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/LabyMod/MotionBlur.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\LabyMod\addons-1.8\config\Resourcepacks24.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/LabyMod/Resourcepacks24.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\LabyMod\addons-1.8\config\SettingsProfilesMod.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/LabyMod/SettingsProfilesMod.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\LabyMod\addons-1.8\config\SkyblockAddons.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/LabyMod/SkyblockAddons.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\LabyMod\addons-1.8\config\ToggleSneak.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/LabyMod/ToggleSneak.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\LabyMod\addons-1.8\config\VoiceChat.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/LabyMod/VoiceChat.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\LabyMod\addons-1.8\config\WorldEditCUI.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/LabyMod/WorldEditCUI.json"
	SET msgboxTitle=IMPORTANT
	SET msgboxBody=Open your game and set your Render Distance between 2 - 8 and your FPS to Unlimited
	SET tmpmsgbox=%temp%\~tmpmsgbox.vbs
	IF EXIST "%tmpmsgbox%" DEL /F /Q "%tmpmsgbox%"
	ECHO msgbox "%msgboxBody%",0,"%msgboxTitle%">"%tmpmsgbox%"
	WSCRIPT "%tmpmsgbox%"
	exit
) else (
	exit
)

:: Lunar Client
if exist "C:\Users\%username%\.lunarclient\settings\game\Default\" (
	curl -g -L -# -o "C:\Users\%username%\.lunarclient\settings\game\Default\general.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/LunarClient/general.json"
	curl -g -L -# -o "C:\Users\%username%\.lunarclient\settings\game\Default\mods.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/LunarClient/mods.json"
	curl -g -L -# -o "C:\Users\%username%\.lunarclient\settings\game\Default\performance.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/LunarClient/performance.json"
	SET msgboxTitle=IMPORTANT
	SET msgboxBody=Open your game and set your Render Distance between 2 - 8 and your FPS to Unlimited
	SET tmpmsgbox=%temp%\~tmpmsgbox.vbs
	IF EXIST "%tmpmsgbox%" DEL /F /Q "%tmpmsgbox%"
	ECHO msgbox "%msgboxBody%",0,"%msgboxTitle%">"%tmpmsgbox%"
	WSCRIPT "%tmpmsgbox%"
	exit
) else (
	exit
)


:: Salwyrr Launcher
if exist "C:\Users\%username%\AppData\Roaming\.Salwyrr\" (
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.Salwyrr\client.properties" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/SalwyrrLauncher/client.properties"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.Salwyrr\launcher\salwyrr.client.backup" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/SalwyrrLauncher/salwyrr.client.backup"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\salwyrr.properties.backup" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/SalwyrrLauncher/salwyrr.properties.backup"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.Salwyrr\launcher\cef\SalwyrrAdBrowser.jar" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/SalwyrrLauncher/SalwyrrAdBrowser.jar"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.Salwyrr\launcher\libs\SalwyrrConfig.jar" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/SalwyrrLauncher/SalwyrrConfig.jar"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.Salwyrr\optionsof.txt" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/1.7.10_GPU_DynOFF.txt"
	SET msgboxTitle=IMPORTANT
	SET msgboxBody=Open your game and set your Render Distance between 2 - 8 and your FPS to Unlimited
	SET tmpmsgbox=%temp%\~tmpmsgbox.vbs
	IF EXIST "%tmpmsgbox%" DEL /F /Q "%tmpmsgbox%"
	ECHO msgbox "%msgboxBody%",0,"%msgboxTitle%">"%tmpmsgbox%"
	WSCRIPT "%tmpmsgbox%"
	exit
) else (
	exit
)

:: Solar Tweaks
if exist "C:\Users\%username%\AppData\Roaming\Crystal-Launcher\instances\Blazingpack\" (
	curl -g -L -# -o "C:\Users\%username%\.lunarclient\solartweaks\config.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/Solar Tweaks/badlion_settings.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\solartweaks\settings.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/Solar Tweaks/settings.json"
	SET msgboxTitle=IMPORTANT
	SET msgboxBody=Open your game and set your Render Distance between 2 - 8 and your FPS to Unlimited
	SET tmpmsgbox=%temp%\~tmpmsgbox.vbs
	IF EXIST "%tmpmsgbox%" DEL /F /Q "%tmpmsgbox%"
	ECHO msgbox "%msgboxBody%",0,"%msgboxTitle%">"%tmpmsgbox%"
	WSCRIPT "%tmpmsgbox%"
	exit
) else (
	exit
)

:2
cls
echo.
echo.
call :ColorText 08  "                                                            Version 2.1 
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
call :ColorText 08  "                                                            Version 2.1 
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
curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.ft\optionsof.txt" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/1.7.10_iGPU_DynOFF.txt"
curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.lc\optionsof.txt" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/1.7.10_iGPU_DynOFF.txt"

:: AZ-Client
if exist "C:\Users\%username%\AppData\Roaming\.az-client\config\" (
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.az-client\config\mods.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/AZ-Client/mods.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.az-client\config\options.txt" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/AZ-Client/options_igpu.json"
	SET msgboxTitle=IMPORTANT
	SET msgboxBody=Open your game and set your Render Distance between 2 - 8 and your FPS to Unlimited
	SET tmpmsgbox=%temp%\~tmpmsgbox.vbs
	IF EXIST "%tmpmsgbox%" DEL /F /Q "%tmpmsgbox%"
	ECHO msgbox "%msgboxBody%",0,"%msgboxTitle%">"%tmpmsgbox%"
	WSCRIPT "%tmpmsgbox%"
	exit
) else (
	exit
)

:: Badlion Client
if exist "C:\Users\%username%\AppData\Roaming\.minecraft\BLClient-Mod-Profiles\" (
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\badlion_settings.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/Badlion Client/badlion_settings.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\BLClient-Mod-Profiles\Vanilla.zip" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/Badlion Client/Vanilla.zip"
	SET msgboxTitle=IMPORTANT
	SET msgboxBody=Open your game and set your Render Distance between 2 - 8 and your FPS to Unlimited
	SET tmpmsgbox=%temp%\~tmpmsgbox.vbs
	IF EXIST "%tmpmsgbox%" DEL /F /Q "%tmpmsgbox%"
	ECHO msgbox "%msgboxBody%",0,"%msgboxTitle%">"%tmpmsgbox%"
	WSCRIPT "%tmpmsgbox%"
	exit
) else (
	exit
)

:: Badlion Client Lite
if exist "C:\Users\%username%\AppData\Roaming\.minecraft\BLClient-Mod-Profiles\" (
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\badlion_settings.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/Badlion Client Lite/badlion_settings.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\BLClient-Mod-Profiles\Vanilla.zip" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/Badlion Client Lite/Vanilla.zip"
	SET msgboxTitle=IMPORTANT
	SET msgboxBody=Open your game and set your Render Distance between 2 - 8 and your FPS to Unlimited
	SET tmpmsgbox=%temp%\~tmpmsgbox.vbs
	IF EXIST "%tmpmsgbox%" DEL /F /Q "%tmpmsgbox%"
	ECHO msgbox "%msgboxBody%",0,"%msgboxTitle%">"%tmpmsgbox%"
	WSCRIPT "%tmpmsgbox%"
	exit

) else (
	exit
)

:: BatMod
if exist "C:\Users\%username%\AppData\Roaming\.minecraft\BatMod\" (
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\BatMod\hud.txt" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/BatMod/hud.txt"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\BatMod\options.txt" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/BatMod/options.txt"
	SET msgboxTitle=IMPORTANT
	SET msgboxBody=Open your game and set your Render Distance between 2 - 8 and your FPS to Unlimited
	SET tmpmsgbox=%temp%\~tmpmsgbox.vbs
	IF EXIST "%tmpmsgbox%" DEL /F /Q "%tmpmsgbox%"
	ECHO msgbox "%msgboxBody%",0,"%msgboxTitle%">"%tmpmsgbox%"
	WSCRIPT "%tmpmsgbox%"
	exit
) else (
	exit
)

:: BlazingPack
if exist "C:\Users\%username%\AppData\Roaming\Crystal-Launcher\instances\Blazingpack\" (
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\Crystal-Launcher\instances\Blazingpack\.minecraft\optionsbp.dat" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/BlazingPack/optionsbp.dat"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\Crystal-Launcher\instances\Blazingpack\.minecraft\optionsofbp.txt" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/BlazingPack/optionsofbp.txt"
	SET msgboxTitle=IMPORTANT
	SET msgboxBody=Open your game and set your Render Distance between 2 - 8 and your FPS to Unlimited
	SET tmpmsgbox=%temp%\~tmpmsgbox.vbs
	IF EXIST "%tmpmsgbox%" DEL /F /Q "%tmpmsgbox%"
	ECHO msgbox "%msgboxBody%",0,"%msgboxTitle%">"%tmpmsgbox%"
	WSCRIPT "%tmpmsgbox%"
	exit
) else (
	exit
)

:: CheatBreaker
if exist "C:\Users\%username%\AppData\Roaming\.minecraft\config\cheatbreaker\" (
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\config\cheatbreaker\Default\general.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CheatBreaker/general.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\config\cheatbreaker\Default\mods.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CheatBreaker/mods.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\config\cheatbreaker\Default\performance.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CheatBreaker/performance.json"
	SET msgboxTitle=IMPORTANT
	SET msgboxBody=Open your game and set your Render Distance between 2 - 8 and your FPS to Unlimited
	SET tmpmsgbox=%temp%\~tmpmsgbox.vbs
	IF EXIST "%tmpmsgbox%" DEL /F /Q "%tmpmsgbox%"
	ECHO msgbox "%msgboxBody%",0,"%msgboxTitle%">"%tmpmsgbox%"
	WSCRIPT "%tmpmsgbox%"
	exit
) else (
	exit
)

:: CosmicLauncher
if exist "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\" (
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\admin_overlay.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/admin_overlay.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\anim.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/anim.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\armorhud.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/armorhud.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\breadcrumbs.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/breadcrumbs.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\chunkborders.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/chunkborders.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\compass.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/compass.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\cooldownhud.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/cooldownhud.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\crosshair.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/crosshair.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\cursorpersistence.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/cursorpersistence.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\emotes.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/emotes.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\eventhud.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/eventhud.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\hitsplat.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/hitsplat.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\hud.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/hud.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\leaderboard.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/leaderboard.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\mapwriter.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/mapwriter.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\minigame_leaderboard.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/minigame_leaderboard.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\mob_helper.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/mob_helper.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\motion_blur.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/motion_blur.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\notification_feed.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/notification_feed.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\peaceful_mining.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/peaceful_mining.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\perf.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/perf.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\ph.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/ph.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\pingallies.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/pingallies.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\polls.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/polls.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\potioncolors.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/potioncolors.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\roam.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/roam.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\satchelhud.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/satchelhud.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\schematica.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/schematica.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\scoreboard.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/scoreboard.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\screenshot.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/screenshot.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\settings.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/settings.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\tabchat.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/tabchat.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\target_health_bar.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/target_health_bar.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\togglesneak.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/togglesneak.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\togglesprint.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/togglesprint.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\tooltips.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/tooltips.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\vk.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/vk.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\voice.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/voice.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\wdl.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/wdl.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\worldborder.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/worldborder.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\worldeditcui.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/worldeditcui.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\xp_bar.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/xp_bar.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\xp_text.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/xp_text.json"
	SET msgboxTitle=IMPORTANT
	SET msgboxBody=Open your game and set your Render Distance between 2 - 8 and your FPS to Unlimited
	SET tmpmsgbox=%temp%\~tmpmsgbox.vbs
	IF EXIST "%tmpmsgbox%" DEL /F /Q "%tmpmsgbox%"
	ECHO msgbox "%msgboxBody%",0,"%msgboxTitle%">"%tmpmsgbox%"
	WSCRIPT "%tmpmsgbox%"
	exit
) else (
	exit
)

:: Feather Client
if exist "C:\Users\%username%\AppData\Roaming\.minecraft\feather\" (
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\feather\client_preferences.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/FeatherClient/client_preferences.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\essential\config.toml" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/FeatherClient/config.toml"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\feather\configuration\current.profile" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/FeatherClient/current.profile"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\feather\configuration\profiles\default.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/FeatherClient/default.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.feather\mods\feather-mods.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/FeatherClient/feather-mods.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.feather\user-mods\1.8.9\feather-mods.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/FeatherClient/HitDelayFix.jar"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\config\patcher_sounds.toml" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/FeatherClient/patcher_sounds.toml"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\config\patcher_sounds.toml" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/FeatherClient/patcher.toml"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\feather\patcher_sounds.toml" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/FeatherClient/sidebar.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.feather\user-mods\1.8.9\feather-mods.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/FeatherClient/TNT Time-1.1 (1.8.9).jar"

	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.ft\feather\client_preferences.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/FeatherClient/client_preferences.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.ft\essential\config.toml" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/FeatherClient/config.toml"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.ft\feather\configuration\current.profile" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/FeatherClient/current.profile"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.ft\feather\configuration\profiles\default.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/FeatherClient/default.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.ft\config\patcher_sounds.toml" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/FeatherClient/patcher_sounds.toml"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.ft\config\patcher_sounds.toml" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/FeatherClient/patcher.toml"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.ft\feather\patcher_sounds.toml" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/FeatherClient/sidebar.json"
	SET msgboxTitle=IMPORTANT
	SET msgboxBody=Open your game and set your Render Distance between 2 - 8 and your FPS to Unlimited
	SET tmpmsgbox=%temp%\~tmpmsgbox.vbs
	IF EXIST "%tmpmsgbox%" DEL /F /Q "%tmpmsgbox%"
	ECHO msgbox "%msgboxBody%",0,"%msgboxTitle%">"%tmpmsgbox%"
	WSCRIPT "%tmpmsgbox%"
	exit
) else (
	exit
)

:: LabyMod
if exist "C:\Users\%username%\AppData\Roaming\.minecraft\LabyMod\" (
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\LabyMod\addons-1.8\config\CustomCrosshair.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/LabyMod/CustomCrosshair.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\LabyMod\addons-1.8\config\CustomMainMenu.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/LabyMod/CustomMainMenu.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\LabyMod\addons-1.8\config\DamageIndicator.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/LabyMod/DamageIndicator.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\LabyMod\addons-1.8\config\DirectionHUD.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/LabyMod/DirectionHUD.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\LabyMod\addons-1.8\config\ItemPhysic.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/LabyMod/ItemPhysic.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\LabyMod\addons-1.8\config\Laby's Keystrokes.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/LabyMod/Laby's Keystrokes.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\LabyMod\addons-1.8\config\LabysMinimap.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/LabyMod/LabysMinimap.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\LabyMod\modules.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/LabyMod/modules.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\LabyMod\addons-1.8\config\MoreParticle.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/LabyMod/MoreParticle.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\LabyMod\addons-1.8\config\MotionBlur.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/LabyMod/MotionBlur.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\LabyMod\addons-1.8\config\Resourcepacks24.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/LabyMod/Resourcepacks24.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\LabyMod\addons-1.8\config\SettingsProfilesMod.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/LabyMod/SettingsProfilesMod.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\LabyMod\addons-1.8\config\SkyblockAddons.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/LabyMod/SkyblockAddons.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\LabyMod\addons-1.8\config\ToggleSneak.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/LabyMod/ToggleSneak.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\LabyMod\addons-1.8\config\VoiceChat.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/LabyMod/VoiceChat.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\LabyMod\addons-1.8\config\WorldEditCUI.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/LabyMod/WorldEditCUI.json"
	SET msgboxTitle=IMPORTANT
	SET msgboxBody=Open your game and set your Render Distance between 2 - 8 and your FPS to Unlimited
	SET tmpmsgbox=%temp%\~tmpmsgbox.vbs
	IF EXIST "%tmpmsgbox%" DEL /F /Q "%tmpmsgbox%"
	ECHO msgbox "%msgboxBody%",0,"%msgboxTitle%">"%tmpmsgbox%"
	WSCRIPT "%tmpmsgbox%"
	exit
) else (
	exit
)

:: Lunar Client
if exist "C:\Users\%username%\.lunarclient\settings\game\Default\" (
	curl -g -L -# -o "C:\Users\%username%\.lunarclient\settings\game\Default\general.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/LunarClient/general.json"
	curl -g -L -# -o "C:\Users\%username%\.lunarclient\settings\game\Default\mods.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/LunarClient/mods.json"
	curl -g -L -# -o "C:\Users\%username%\.lunarclient\settings\game\Default\performance.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/LunarClient/performance.json"
	SET msgboxTitle=IMPORTANT
	SET msgboxBody=Open your game and set your Render Distance between 2 - 8 and your FPS to Unlimited
	SET tmpmsgbox=%temp%\~tmpmsgbox.vbs
	IF EXIST "%tmpmsgbox%" DEL /F /Q "%tmpmsgbox%"
	ECHO msgbox "%msgboxBody%",0,"%msgboxTitle%">"%tmpmsgbox%"
	WSCRIPT "%tmpmsgbox%"
	exit
) else (
	exit
)


:: Salwyrr Launcher
if exist "C:\Users\%username%\AppData\Roaming\.Salwyrr\" (
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.Salwyrr\client.properties" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/SalwyrrLauncher/client.properties"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.Salwyrr\launcher\salwyrr.client.backup" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/SalwyrrLauncher/salwyrr.client.backup"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\salwyrr.properties.backup" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/SalwyrrLauncher/salwyrr.properties.backup"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.Salwyrr\launcher\cef\SalwyrrAdBrowser.jar" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/SalwyrrLauncher/SalwyrrAdBrowser.jar"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.Salwyrr\launcher\libs\SalwyrrConfig.jar" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/SalwyrrLauncher/SalwyrrConfig.jar"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.Salwyrr\optionsof.txt" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/1.7.10_iGPU_DynOFF.txt"
	SET msgboxTitle=IMPORTANT
	SET msgboxBody=Open your game and set your Render Distance between 2 - 8 and your FPS to Unlimited
	SET tmpmsgbox=%temp%\~tmpmsgbox.vbs
	IF EXIST "%tmpmsgbox%" DEL /F /Q "%tmpmsgbox%"
	ECHO msgbox "%msgboxBody%",0,"%msgboxTitle%">"%tmpmsgbox%"
	WSCRIPT "%tmpmsgbox%"
	exit
) else (
	exit
)

:: Solar Tweaks
if exist "C:\Users\%username%\AppData\Roaming\Crystal-Launcher\instances\Blazingpack\" (
	curl -g -L -# -o "C:\Users\%username%\.lunarclient\solartweaks\config.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/Solar Tweaks/badlion_settings.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\solartweaks\settings.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/Solar Tweaks/settings.json"
	SET msgboxTitle=IMPORTANT
	SET msgboxBody=Open your game and set your Render Distance between 2 - 8 and your FPS to Unlimited
	SET tmpmsgbox=%temp%\~tmpmsgbox.vbs
	IF EXIST "%tmpmsgbox%" DEL /F /Q "%tmpmsgbox%"
	ECHO msgbox "%msgboxBody%",0,"%msgboxTitle%">"%tmpmsgbox%"
	WSCRIPT "%tmpmsgbox%"
	exit
) else (
	exit
)

:1.7.10_iGPU_DynON
cls
curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\optionsof.txt" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/1.7.10_iGPU_DynON.txt"
curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.ft\optionsof.txt" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/1.7.10_iGPU_DynON.txt"
curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.lc\optionsof.txt" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/1.7.10_iGPU_DynON.txt"

:: AZ-Client
if exist "C:\Users\%username%\AppData\Roaming\.az-client\config\" (
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.az-client\config\mods.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/AZ-Client/mods.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.az-client\config\options.txt" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/AZ-Client/options_igpu.json"
	SET msgboxTitle=IMPORTANT
	SET msgboxBody=Open your game and set your Render Distance between 2 - 8 and your FPS to Unlimited
	SET tmpmsgbox=%temp%\~tmpmsgbox.vbs
	IF EXIST "%tmpmsgbox%" DEL /F /Q "%tmpmsgbox%"
	ECHO msgbox "%msgboxBody%",0,"%msgboxTitle%">"%tmpmsgbox%"
	WSCRIPT "%tmpmsgbox%"
	exit
) else (
	exit
)

:: Badlion Client
if exist "C:\Users\%username%\AppData\Roaming\.minecraft\BLClient-Mod-Profiles\" (
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\badlion_settings.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/Badlion Client/badlion_settings.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\BLClient-Mod-Profiles\Vanilla.zip" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/Badlion Client/Vanilla.zip"
	SET msgboxTitle=IMPORTANT
	SET msgboxBody=Open your game and set your Render Distance between 2 - 8 and your FPS to Unlimited
	SET tmpmsgbox=%temp%\~tmpmsgbox.vbs
	IF EXIST "%tmpmsgbox%" DEL /F /Q "%tmpmsgbox%"
	ECHO msgbox "%msgboxBody%",0,"%msgboxTitle%">"%tmpmsgbox%"
	WSCRIPT "%tmpmsgbox%"
	exit
) else (
	exit
)

:: Badlion Client Lite
if exist "C:\Users\%username%\AppData\Roaming\.minecraft\BLClient-Mod-Profiles\" (
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\badlion_settings.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/Badlion Client Lite/badlion_settings.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\BLClient-Mod-Profiles\Vanilla.zip" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/Badlion Client Lite/Vanilla.zip"
	SET msgboxTitle=IMPORTANT
	SET msgboxBody=Open your game and set your Render Distance between 2 - 8 and your FPS to Unlimited
	SET tmpmsgbox=%temp%\~tmpmsgbox.vbs
	IF EXIST "%tmpmsgbox%" DEL /F /Q "%tmpmsgbox%"
	ECHO msgbox "%msgboxBody%",0,"%msgboxTitle%">"%tmpmsgbox%"
	WSCRIPT "%tmpmsgbox%"
	exit

) else (
	exit
)

:: BatMod
if exist "C:\Users\%username%\AppData\Roaming\.minecraft\BatMod\" (
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\BatMod\hud.txt" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/BatMod/hud.txt"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\BatMod\options.txt" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/BatMod/options.txt"
	SET msgboxTitle=IMPORTANT
	SET msgboxBody=Open your game and set your Render Distance between 2 - 8 and your FPS to Unlimited
	SET tmpmsgbox=%temp%\~tmpmsgbox.vbs
	IF EXIST "%tmpmsgbox%" DEL /F /Q "%tmpmsgbox%"
	ECHO msgbox "%msgboxBody%",0,"%msgboxTitle%">"%tmpmsgbox%"
	WSCRIPT "%tmpmsgbox%"
	exit
) else (
	exit
)

:: BlazingPack
if exist "C:\Users\%username%\AppData\Roaming\Crystal-Launcher\instances\Blazingpack\" (
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\Crystal-Launcher\instances\Blazingpack\.minecraft\optionsbp.dat" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/BlazingPack/optionsbp.dat"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\Crystal-Launcher\instances\Blazingpack\.minecraft\optionsofbp.txt" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/BlazingPack/optionsofbp.txt"
	SET msgboxTitle=IMPORTANT
	SET msgboxBody=Open your game and set your Render Distance between 2 - 8 and your FPS to Unlimited
	SET tmpmsgbox=%temp%\~tmpmsgbox.vbs
	IF EXIST "%tmpmsgbox%" DEL /F /Q "%tmpmsgbox%"
	ECHO msgbox "%msgboxBody%",0,"%msgboxTitle%">"%tmpmsgbox%"
	WSCRIPT "%tmpmsgbox%"
	exit
) else (
	exit
)

:: CheatBreaker
if exist "C:\Users\%username%\AppData\Roaming\.minecraft\config\cheatbreaker\" (
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\config\cheatbreaker\Default\general.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CheatBreaker/general.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\config\cheatbreaker\Default\mods.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CheatBreaker/mods.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\config\cheatbreaker\Default\performance.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CheatBreaker/performance.json"
	SET msgboxTitle=IMPORTANT
	SET msgboxBody=Open your game and set your Render Distance between 2 - 8 and your FPS to Unlimited
	SET tmpmsgbox=%temp%\~tmpmsgbox.vbs
	IF EXIST "%tmpmsgbox%" DEL /F /Q "%tmpmsgbox%"
	ECHO msgbox "%msgboxBody%",0,"%msgboxTitle%">"%tmpmsgbox%"
	WSCRIPT "%tmpmsgbox%"
	exit
) else (
	exit
)

:: CosmicLauncher
if exist "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\" (
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\admin_overlay.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/admin_overlay.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\anim.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/anim.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\armorhud.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/armorhud.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\breadcrumbs.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/breadcrumbs.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\chunkborders.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/chunkborders.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\compass.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/compass.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\cooldownhud.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/cooldownhud.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\crosshair.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/crosshair.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\cursorpersistence.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/cursorpersistence.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\emotes.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/emotes.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\eventhud.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/eventhud.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\hitsplat.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/hitsplat.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\hud.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/hud.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\leaderboard.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/leaderboard.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\mapwriter.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/mapwriter.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\minigame_leaderboard.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/minigame_leaderboard.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\mob_helper.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/mob_helper.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\motion_blur.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/motion_blur.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\notification_feed.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/notification_feed.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\peaceful_mining.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/peaceful_mining.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\perf.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/perf.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\ph.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/ph.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\pingallies.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/pingallies.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\polls.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/polls.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\potioncolors.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/potioncolors.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\roam.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/roam.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\satchelhud.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/satchelhud.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\schematica.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/schematica.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\scoreboard.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/scoreboard.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\screenshot.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/screenshot.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\settings.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/settings.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\tabchat.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/tabchat.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\target_health_bar.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/target_health_bar.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\togglesneak.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/togglesneak.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\togglesprint.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/togglesprint.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\tooltips.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/tooltips.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\vk.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/vk.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\voice.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/voice.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\wdl.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/wdl.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\worldborder.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/worldborder.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\worldeditcui.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/worldeditcui.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\xp_bar.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/xp_bar.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\xp_text.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/xp_text.json"
	SET msgboxTitle=IMPORTANT
	SET msgboxBody=Open your game and set your Render Distance between 2 - 8 and your FPS to Unlimited
	SET tmpmsgbox=%temp%\~tmpmsgbox.vbs
	IF EXIST "%tmpmsgbox%" DEL /F /Q "%tmpmsgbox%"
	ECHO msgbox "%msgboxBody%",0,"%msgboxTitle%">"%tmpmsgbox%"
	WSCRIPT "%tmpmsgbox%"
	exit
) else (
	exit
)

:: Feather Client
if exist "C:\Users\%username%\AppData\Roaming\.minecraft\feather\" (
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\feather\client_preferences.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/FeatherClient/client_preferences.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\essential\config.toml" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/FeatherClient/config.toml"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\feather\configuration\current.profile" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/FeatherClient/current.profile"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\feather\configuration\profiles\default.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/FeatherClient/default.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.feather\mods\feather-mods.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/FeatherClient/feather-mods.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.feather\user-mods\1.8.9\feather-mods.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/FeatherClient/HitDelayFix.jar"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\config\patcher_sounds.toml" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/FeatherClient/patcher_sounds.toml"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\config\patcher_sounds.toml" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/FeatherClient/patcher.toml"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\feather\patcher_sounds.toml" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/FeatherClient/sidebar.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.feather\user-mods\1.8.9\feather-mods.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/FeatherClient/TNT Time-1.1 (1.8.9).jar"

	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.ft\feather\client_preferences.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/FeatherClient/client_preferences.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.ft\essential\config.toml" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/FeatherClient/config.toml"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.ft\feather\configuration\current.profile" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/FeatherClient/current.profile"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.ft\feather\configuration\profiles\default.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/FeatherClient/default.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.ft\config\patcher_sounds.toml" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/FeatherClient/patcher_sounds.toml"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.ft\config\patcher_sounds.toml" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/FeatherClient/patcher.toml"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.ft\feather\patcher_sounds.toml" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/FeatherClient/sidebar.json"
	SET msgboxTitle=IMPORTANT
	SET msgboxBody=Open your game and set your Render Distance between 2 - 8 and your FPS to Unlimited
	SET tmpmsgbox=%temp%\~tmpmsgbox.vbs
	IF EXIST "%tmpmsgbox%" DEL /F /Q "%tmpmsgbox%"
	ECHO msgbox "%msgboxBody%",0,"%msgboxTitle%">"%tmpmsgbox%"
	WSCRIPT "%tmpmsgbox%"
	exit
) else (
	exit
)

:: LabyMod
if exist "C:\Users\%username%\AppData\Roaming\.minecraft\LabyMod\" (
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\LabyMod\addons-1.8\config\CustomCrosshair.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/LabyMod/CustomCrosshair.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\LabyMod\addons-1.8\config\CustomMainMenu.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/LabyMod/CustomMainMenu.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\LabyMod\addons-1.8\config\DamageIndicator.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/LabyMod/DamageIndicator.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\LabyMod\addons-1.8\config\DirectionHUD.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/LabyMod/DirectionHUD.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\LabyMod\addons-1.8\config\ItemPhysic.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/LabyMod/ItemPhysic.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\LabyMod\addons-1.8\config\Laby's Keystrokes.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/LabyMod/Laby's Keystrokes.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\LabyMod\addons-1.8\config\LabysMinimap.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/LabyMod/LabysMinimap.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\LabyMod\modules.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/LabyMod/modules.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\LabyMod\addons-1.8\config\MoreParticle.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/LabyMod/MoreParticle.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\LabyMod\addons-1.8\config\MotionBlur.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/LabyMod/MotionBlur.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\LabyMod\addons-1.8\config\Resourcepacks24.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/LabyMod/Resourcepacks24.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\LabyMod\addons-1.8\config\SettingsProfilesMod.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/LabyMod/SettingsProfilesMod.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\LabyMod\addons-1.8\config\SkyblockAddons.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/LabyMod/SkyblockAddons.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\LabyMod\addons-1.8\config\ToggleSneak.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/LabyMod/ToggleSneak.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\LabyMod\addons-1.8\config\VoiceChat.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/LabyMod/VoiceChat.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\LabyMod\addons-1.8\config\WorldEditCUI.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/LabyMod/WorldEditCUI.json"
	SET msgboxTitle=IMPORTANT
	SET msgboxBody=Open your game and set your Render Distance between 2 - 8 and your FPS to Unlimited
	SET tmpmsgbox=%temp%\~tmpmsgbox.vbs
	IF EXIST "%tmpmsgbox%" DEL /F /Q "%tmpmsgbox%"
	ECHO msgbox "%msgboxBody%",0,"%msgboxTitle%">"%tmpmsgbox%"
	WSCRIPT "%tmpmsgbox%"
	exit
) else (
	exit
)

:: Lunar Client
if exist "C:\Users\%username%\.lunarclient\settings\game\Default\" (
	curl -g -L -# -o "C:\Users\%username%\.lunarclient\settings\game\Default\general.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/LunarClient/general.json"
	curl -g -L -# -o "C:\Users\%username%\.lunarclient\settings\game\Default\mods.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/LunarClient/mods.json"
	curl -g -L -# -o "C:\Users\%username%\.lunarclient\settings\game\Default\performance.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/LunarClient/performance.json"
	SET msgboxTitle=IMPORTANT
	SET msgboxBody=Open your game and set your Render Distance between 2 - 8 and your FPS to Unlimited
	SET tmpmsgbox=%temp%\~tmpmsgbox.vbs
	IF EXIST "%tmpmsgbox%" DEL /F /Q "%tmpmsgbox%"
	ECHO msgbox "%msgboxBody%",0,"%msgboxTitle%">"%tmpmsgbox%"
	WSCRIPT "%tmpmsgbox%"
	exit
) else (
	exit
)


:: Salwyrr Launcher
if exist "C:\Users\%username%\AppData\Roaming\.Salwyrr\" (
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.Salwyrr\client.properties" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/SalwyrrLauncher/client.properties"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.Salwyrr\launcher\salwyrr.client.backup" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/SalwyrrLauncher/salwyrr.client.backup"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\salwyrr.properties.backup" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/SalwyrrLauncher/salwyrr.properties.backup"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.Salwyrr\launcher\cef\SalwyrrAdBrowser.jar" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/SalwyrrLauncher/SalwyrrAdBrowser.jar"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.Salwyrr\launcher\libs\SalwyrrConfig.jar" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/SalwyrrLauncher/SalwyrrConfig.jar"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.Salwyrr\optionsof.txt" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/1.7.10_iGPU_DynON.txt"
	SET msgboxTitle=IMPORTANT
	SET msgboxBody=Open your game and set your Render Distance between 2 - 8 and your FPS to Unlimited
	SET tmpmsgbox=%temp%\~tmpmsgbox.vbs
	IF EXIST "%tmpmsgbox%" DEL /F /Q "%tmpmsgbox%"
	ECHO msgbox "%msgboxBody%",0,"%msgboxTitle%">"%tmpmsgbox%"
	WSCRIPT "%tmpmsgbox%"
	exit
) else (
	exit
)

:: Solar Tweaks
if exist "C:\Users\%username%\AppData\Roaming\Crystal-Launcher\instances\Blazingpack\" (
	curl -g -L -# -o "C:\Users\%username%\.lunarclient\solartweaks\config.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/Solar Tweaks/badlion_settings.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\solartweaks\settings.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/Solar Tweaks/settings.json"
	SET msgboxTitle=IMPORTANT
	SET msgboxBody=Open your game and set your Render Distance between 2 - 8 and your FPS to Unlimited
	SET tmpmsgbox=%temp%\~tmpmsgbox.vbs
	IF EXIST "%tmpmsgbox%" DEL /F /Q "%tmpmsgbox%"
	ECHO msgbox "%msgboxBody%",0,"%msgboxTitle%">"%tmpmsgbox%"
	WSCRIPT "%tmpmsgbox%"
	exit
) else (
	exit
)

:1.8.9_GPU
cls
echo.
echo.
call :ColorText 08  "                                                            Version 2.1 
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
curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.ft\optionsof.txt" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/1.8.9_iGPU_DynOFF.txt"
curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.lc\optionsof.txt" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/1.8.9_iGPU_DynOFF.txt"

:: AZ-Client
if exist "C:\Users\%username%\AppData\Roaming\.az-client\config\" (
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.az-client\config\mods.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/AZ-Client/mods.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.az-client\config\options.txt" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/AZ-Client/options_igpu.json"
	SET msgboxTitle=IMPORTANT
	SET msgboxBody=Open your game and set your Render Distance between 2 - 8 and your FPS to Unlimited
	SET tmpmsgbox=%temp%\~tmpmsgbox.vbs
	IF EXIST "%tmpmsgbox%" DEL /F /Q "%tmpmsgbox%"
	ECHO msgbox "%msgboxBody%",0,"%msgboxTitle%">"%tmpmsgbox%"
	WSCRIPT "%tmpmsgbox%"
	exit
) else (
	exit
)

:: Badlion Client
if exist "C:\Users\%username%\AppData\Roaming\.minecraft\BLClient-Mod-Profiles\" (
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\badlion_settings.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/Badlion Client/badlion_settings.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\BLClient-Mod-Profiles\Vanilla.zip" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/Badlion Client/Vanilla.zip"
	SET msgboxTitle=IMPORTANT
	SET msgboxBody=Open your game and set your Render Distance between 2 - 8 and your FPS to Unlimited
	SET tmpmsgbox=%temp%\~tmpmsgbox.vbs
	IF EXIST "%tmpmsgbox%" DEL /F /Q "%tmpmsgbox%"
	ECHO msgbox "%msgboxBody%",0,"%msgboxTitle%">"%tmpmsgbox%"
	WSCRIPT "%tmpmsgbox%"
	exit
) else (
	exit
)

:: Badlion Client Lite
if exist "C:\Users\%username%\AppData\Roaming\.minecraft\BLClient-Mod-Profiles\" (
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\badlion_settings.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/Badlion Client Lite/badlion_settings.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\BLClient-Mod-Profiles\Vanilla.zip" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/Badlion Client Lite/Vanilla.zip"
	SET msgboxTitle=IMPORTANT
	SET msgboxBody=Open your game and set your Render Distance between 2 - 8 and your FPS to Unlimited
	SET tmpmsgbox=%temp%\~tmpmsgbox.vbs
	IF EXIST "%tmpmsgbox%" DEL /F /Q "%tmpmsgbox%"
	ECHO msgbox "%msgboxBody%",0,"%msgboxTitle%">"%tmpmsgbox%"
	WSCRIPT "%tmpmsgbox%"
	exit

) else (
	exit
)

:: BatMod
if exist "C:\Users\%username%\AppData\Roaming\.minecraft\BatMod\" (
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\BatMod\hud.txt" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/BatMod/hud.txt"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\BatMod\options.txt" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/BatMod/options.txt"
	SET msgboxTitle=IMPORTANT
	SET msgboxBody=Open your game and set your Render Distance between 2 - 8 and your FPS to Unlimited
	SET tmpmsgbox=%temp%\~tmpmsgbox.vbs
	IF EXIST "%tmpmsgbox%" DEL /F /Q "%tmpmsgbox%"
	ECHO msgbox "%msgboxBody%",0,"%msgboxTitle%">"%tmpmsgbox%"
	WSCRIPT "%tmpmsgbox%"
	exit
) else (
	exit
)

:: BlazingPack
if exist "C:\Users\%username%\AppData\Roaming\Crystal-Launcher\instances\Blazingpack\" (
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\Crystal-Launcher\instances\Blazingpack\.minecraft\optionsbp.dat" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/BlazingPack/optionsbp.dat"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\Crystal-Launcher\instances\Blazingpack\.minecraft\optionsofbp.txt" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/BlazingPack/optionsofbp.txt"
	SET msgboxTitle=IMPORTANT
	SET msgboxBody=Open your game and set your Render Distance between 2 - 8 and your FPS to Unlimited
	SET tmpmsgbox=%temp%\~tmpmsgbox.vbs
	IF EXIST "%tmpmsgbox%" DEL /F /Q "%tmpmsgbox%"
	ECHO msgbox "%msgboxBody%",0,"%msgboxTitle%">"%tmpmsgbox%"
	WSCRIPT "%tmpmsgbox%"
	exit
) else (
	exit
)

:: CheatBreaker
if exist "C:\Users\%username%\AppData\Roaming\.minecraft\config\cheatbreaker\" (
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\config\cheatbreaker\Default\general.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CheatBreaker/general.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\config\cheatbreaker\Default\mods.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CheatBreaker/mods.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\config\cheatbreaker\Default\performance.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CheatBreaker/performance.json"
	SET msgboxTitle=IMPORTANT
	SET msgboxBody=Open your game and set your Render Distance between 2 - 8 and your FPS to Unlimited
	SET tmpmsgbox=%temp%\~tmpmsgbox.vbs
	IF EXIST "%tmpmsgbox%" DEL /F /Q "%tmpmsgbox%"
	ECHO msgbox "%msgboxBody%",0,"%msgboxTitle%">"%tmpmsgbox%"
	WSCRIPT "%tmpmsgbox%"
	exit
) else (
	exit
)

:: CosmicLauncher
if exist "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\" (
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\admin_overlay.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/admin_overlay.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\anim.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/anim.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\armorhud.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/armorhud.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\breadcrumbs.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/breadcrumbs.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\chunkborders.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/chunkborders.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\compass.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/compass.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\cooldownhud.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/cooldownhud.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\crosshair.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/crosshair.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\cursorpersistence.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/cursorpersistence.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\emotes.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/emotes.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\eventhud.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/eventhud.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\hitsplat.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/hitsplat.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\hud.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/hud.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\leaderboard.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/leaderboard.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\mapwriter.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/mapwriter.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\minigame_leaderboard.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/minigame_leaderboard.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\mob_helper.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/mob_helper.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\motion_blur.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/motion_blur.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\notification_feed.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/notification_feed.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\peaceful_mining.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/peaceful_mining.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\perf.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/perf.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\ph.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/ph.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\pingallies.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/pingallies.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\polls.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/polls.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\potioncolors.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/potioncolors.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\roam.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/roam.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\satchelhud.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/satchelhud.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\schematica.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/schematica.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\scoreboard.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/scoreboard.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\screenshot.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/screenshot.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\settings.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/settings.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\tabchat.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/tabchat.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\target_health_bar.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/target_health_bar.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\togglesneak.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/togglesneak.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\togglesprint.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/togglesprint.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\tooltips.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/tooltips.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\vk.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/vk.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\voice.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/voice.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\wdl.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/wdl.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\worldborder.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/worldborder.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\worldeditcui.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/worldeditcui.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\xp_bar.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/xp_bar.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\xp_text.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/xp_text.json"
	SET msgboxTitle=IMPORTANT
	SET msgboxBody=Open your game and set your Render Distance between 2 - 8 and your FPS to Unlimited
	SET tmpmsgbox=%temp%\~tmpmsgbox.vbs
	IF EXIST "%tmpmsgbox%" DEL /F /Q "%tmpmsgbox%"
	ECHO msgbox "%msgboxBody%",0,"%msgboxTitle%">"%tmpmsgbox%"
	WSCRIPT "%tmpmsgbox%"
	exit
) else (
	exit
)

:: Feather Client
if exist "C:\Users\%username%\AppData\Roaming\.minecraft\feather\" (
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\feather\client_preferences.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/FeatherClient/client_preferences.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\essential\config.toml" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/FeatherClient/config.toml"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\feather\configuration\current.profile" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/FeatherClient/current.profile"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\feather\configuration\profiles\default.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/FeatherClient/default.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.feather\mods\feather-mods.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/FeatherClient/feather-mods.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.feather\user-mods\1.8.9\feather-mods.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/FeatherClient/HitDelayFix.jar"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\config\patcher_sounds.toml" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/FeatherClient/patcher_sounds.toml"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\config\patcher_sounds.toml" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/FeatherClient/patcher.toml"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\feather\patcher_sounds.toml" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/FeatherClient/sidebar.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.feather\user-mods\1.8.9\feather-mods.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/FeatherClient/TNT Time-1.1 (1.8.9).jar"

	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.ft\feather\client_preferences.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/FeatherClient/client_preferences.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.ft\essential\config.toml" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/FeatherClient/config.toml"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.ft\feather\configuration\current.profile" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/FeatherClient/current.profile"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.ft\feather\configuration\profiles\default.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/FeatherClient/default.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.ft\config\patcher_sounds.toml" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/FeatherClient/patcher_sounds.toml"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.ft\config\patcher_sounds.toml" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/FeatherClient/patcher.toml"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.ft\feather\patcher_sounds.toml" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/FeatherClient/sidebar.json"
	SET msgboxTitle=IMPORTANT
	SET msgboxBody=Open your game and set your Render Distance between 2 - 8 and your FPS to Unlimited
	SET tmpmsgbox=%temp%\~tmpmsgbox.vbs
	IF EXIST "%tmpmsgbox%" DEL /F /Q "%tmpmsgbox%"
	ECHO msgbox "%msgboxBody%",0,"%msgboxTitle%">"%tmpmsgbox%"
	WSCRIPT "%tmpmsgbox%"
	exit
) else (
	exit
)

:: LabyMod
if exist "C:\Users\%username%\AppData\Roaming\.minecraft\LabyMod\" (
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\LabyMod\addons-1.8\config\CustomCrosshair.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/LabyMod/CustomCrosshair.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\LabyMod\addons-1.8\config\CustomMainMenu.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/LabyMod/CustomMainMenu.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\LabyMod\addons-1.8\config\DamageIndicator.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/LabyMod/DamageIndicator.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\LabyMod\addons-1.8\config\DirectionHUD.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/LabyMod/DirectionHUD.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\LabyMod\addons-1.8\config\ItemPhysic.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/LabyMod/ItemPhysic.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\LabyMod\addons-1.8\config\Laby's Keystrokes.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/LabyMod/Laby's Keystrokes.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\LabyMod\addons-1.8\config\LabysMinimap.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/LabyMod/LabysMinimap.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\LabyMod\modules.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/LabyMod/modules.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\LabyMod\addons-1.8\config\MoreParticle.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/LabyMod/MoreParticle.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\LabyMod\addons-1.8\config\MotionBlur.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/LabyMod/MotionBlur.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\LabyMod\addons-1.8\config\Resourcepacks24.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/LabyMod/Resourcepacks24.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\LabyMod\addons-1.8\config\SettingsProfilesMod.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/LabyMod/SettingsProfilesMod.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\LabyMod\addons-1.8\config\SkyblockAddons.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/LabyMod/SkyblockAddons.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\LabyMod\addons-1.8\config\ToggleSneak.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/LabyMod/ToggleSneak.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\LabyMod\addons-1.8\config\VoiceChat.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/LabyMod/VoiceChat.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\LabyMod\addons-1.8\config\WorldEditCUI.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/LabyMod/WorldEditCUI.json"
	SET msgboxTitle=IMPORTANT
	SET msgboxBody=Open your game and set your Render Distance between 2 - 8 and your FPS to Unlimited
	SET tmpmsgbox=%temp%\~tmpmsgbox.vbs
	IF EXIST "%tmpmsgbox%" DEL /F /Q "%tmpmsgbox%"
	ECHO msgbox "%msgboxBody%",0,"%msgboxTitle%">"%tmpmsgbox%"
	WSCRIPT "%tmpmsgbox%"
	exit
) else (
	exit
)

:: Lunar Client
if exist "C:\Users\%username%\.lunarclient\settings\game\Default\" (
	curl -g -L -# -o "C:\Users\%username%\.lunarclient\settings\game\Default\general.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/LunarClient/general.json"
	curl -g -L -# -o "C:\Users\%username%\.lunarclient\settings\game\Default\mods.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/LunarClient/mods.json"
	curl -g -L -# -o "C:\Users\%username%\.lunarclient\settings\game\Default\performance.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/LunarClient/performance.json"
	SET msgboxTitle=IMPORTANT
	SET msgboxBody=Open your game and set your Render Distance between 2 - 8 and your FPS to Unlimited
	SET tmpmsgbox=%temp%\~tmpmsgbox.vbs
	IF EXIST "%tmpmsgbox%" DEL /F /Q "%tmpmsgbox%"
	ECHO msgbox "%msgboxBody%",0,"%msgboxTitle%">"%tmpmsgbox%"
	WSCRIPT "%tmpmsgbox%"
	exit
) else (
	exit
)


:: Salwyrr Launcher
if exist "C:\Users\%username%\AppData\Roaming\.Salwyrr\" (
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.Salwyrr\client.properties" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/SalwyrrLauncher/client.properties"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.Salwyrr\launcher\salwyrr.client.backup" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/SalwyrrLauncher/salwyrr.client.backup"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\salwyrr.properties.backup" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/SalwyrrLauncher/salwyrr.properties.backup"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.Salwyrr\launcher\cef\SalwyrrAdBrowser.jar" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/SalwyrrLauncher/SalwyrrAdBrowser.jar"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.Salwyrr\launcher\libs\SalwyrrConfig.jar" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/SalwyrrLauncher/SalwyrrConfig.jar"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.Salwyrr\optionsof.txt" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/1.8.9_iGPU_DynOFF.txt"
	SET msgboxTitle=IMPORTANT
	SET msgboxBody=Open your game and set your Render Distance between 2 - 8 and your FPS to Unlimited
	SET tmpmsgbox=%temp%\~tmpmsgbox.vbs
	IF EXIST "%tmpmsgbox%" DEL /F /Q "%tmpmsgbox%"
	ECHO msgbox "%msgboxBody%",0,"%msgboxTitle%">"%tmpmsgbox%"
	WSCRIPT "%tmpmsgbox%"
	exit
) else (
	exit
)

:: Solar Tweaks
if exist "C:\Users\%username%\AppData\Roaming\Crystal-Launcher\instances\Blazingpack\" (
	curl -g -L -# -o "C:\Users\%username%\.lunarclient\solartweaks\config.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/Solar Tweaks/badlion_settings.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\solartweaks\settings.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/Solar Tweaks/settings.json"
	SET msgboxTitle=IMPORTANT
	SET msgboxBody=Open your game and set your Render Distance between 2 - 8 and your FPS to Unlimited
	SET tmpmsgbox=%temp%\~tmpmsgbox.vbs
	IF EXIST "%tmpmsgbox%" DEL /F /Q "%tmpmsgbox%"
	ECHO msgbox "%msgboxBody%",0,"%msgboxTitle%">"%tmpmsgbox%"
	WSCRIPT "%tmpmsgbox%"
	exit
) else (
	exit
)

:1.8.9_iGPU_DynON
cls
curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\optionsof.txt" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/1.8.9_iGPU_DynON.txt"
curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.ft\optionsof.txt" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/1.8.9_iGPU_DynON.txt"
curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.lc\optionsof.txt" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/1.8.9_iGPU_DynON.txt"

:: AZ-Client
if exist "C:\Users\%username%\AppData\Roaming\.az-client\config\" (
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.az-client\config\mods.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/AZ-Client/mods.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.az-client\config\options.txt" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/AZ-Client/options_igpu.json"
	SET msgboxTitle=IMPORTANT
	SET msgboxBody=Open your game and set your Render Distance between 2 - 8 and your FPS to Unlimited
	SET tmpmsgbox=%temp%\~tmpmsgbox.vbs
	IF EXIST "%tmpmsgbox%" DEL /F /Q "%tmpmsgbox%"
	ECHO msgbox "%msgboxBody%",0,"%msgboxTitle%">"%tmpmsgbox%"
	WSCRIPT "%tmpmsgbox%"
	exit
) else (
	exit
)

:: Badlion Client
if exist "C:\Users\%username%\AppData\Roaming\.minecraft\BLClient-Mod-Profiles\" (
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\badlion_settings.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/Badlion Client/badlion_settings.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\BLClient-Mod-Profiles\Vanilla.zip" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/Badlion Client/Vanilla.zip"
	SET msgboxTitle=IMPORTANT
	SET msgboxBody=Open your game and set your Render Distance between 2 - 8 and your FPS to Unlimited
	SET tmpmsgbox=%temp%\~tmpmsgbox.vbs
	IF EXIST "%tmpmsgbox%" DEL /F /Q "%tmpmsgbox%"
	ECHO msgbox "%msgboxBody%",0,"%msgboxTitle%">"%tmpmsgbox%"
	WSCRIPT "%tmpmsgbox%"
	exit
) else (
	exit
)

:: Badlion Client Lite
if exist "C:\Users\%username%\AppData\Roaming\.minecraft\BLClient-Mod-Profiles\" (
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\badlion_settings.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/Badlion Client Lite/badlion_settings.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\BLClient-Mod-Profiles\Vanilla.zip" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/Badlion Client Lite/Vanilla.zip"
	SET msgboxTitle=IMPORTANT
	SET msgboxBody=Open your game and set your Render Distance between 2 - 8 and your FPS to Unlimited
	SET tmpmsgbox=%temp%\~tmpmsgbox.vbs
	IF EXIST "%tmpmsgbox%" DEL /F /Q "%tmpmsgbox%"
	ECHO msgbox "%msgboxBody%",0,"%msgboxTitle%">"%tmpmsgbox%"
	WSCRIPT "%tmpmsgbox%"
	exit

) else (
	exit
)

:: BatMod
if exist "C:\Users\%username%\AppData\Roaming\.minecraft\BatMod\" (
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\BatMod\hud.txt" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/BatMod/hud.txt"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\BatMod\options.txt" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/BatMod/options.txt"
	SET msgboxTitle=IMPORTANT
	SET msgboxBody=Open your game and set your Render Distance between 2 - 8 and your FPS to Unlimited
	SET tmpmsgbox=%temp%\~tmpmsgbox.vbs
	IF EXIST "%tmpmsgbox%" DEL /F /Q "%tmpmsgbox%"
	ECHO msgbox "%msgboxBody%",0,"%msgboxTitle%">"%tmpmsgbox%"
	WSCRIPT "%tmpmsgbox%"
	exit
) else (
	exit
)

:: BlazingPack
if exist "C:\Users\%username%\AppData\Roaming\Crystal-Launcher\instances\Blazingpack\" (
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\Crystal-Launcher\instances\Blazingpack\.minecraft\optionsbp.dat" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/BlazingPack/optionsbp.dat"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\Crystal-Launcher\instances\Blazingpack\.minecraft\optionsofbp.txt" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/BlazingPack/optionsofbp.txt"
	SET msgboxTitle=IMPORTANT
	SET msgboxBody=Open your game and set your Render Distance between 2 - 8 and your FPS to Unlimited
	SET tmpmsgbox=%temp%\~tmpmsgbox.vbs
	IF EXIST "%tmpmsgbox%" DEL /F /Q "%tmpmsgbox%"
	ECHO msgbox "%msgboxBody%",0,"%msgboxTitle%">"%tmpmsgbox%"
	WSCRIPT "%tmpmsgbox%"
	exit
) else (
	exit
)

:: CheatBreaker
if exist "C:\Users\%username%\AppData\Roaming\.minecraft\config\cheatbreaker\" (
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\config\cheatbreaker\Default\general.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CheatBreaker/general.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\config\cheatbreaker\Default\mods.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CheatBreaker/mods.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\config\cheatbreaker\Default\performance.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CheatBreaker/performance.json"
	SET msgboxTitle=IMPORTANT
	SET msgboxBody=Open your game and set your Render Distance between 2 - 8 and your FPS to Unlimited
	SET tmpmsgbox=%temp%\~tmpmsgbox.vbs
	IF EXIST "%tmpmsgbox%" DEL /F /Q "%tmpmsgbox%"
	ECHO msgbox "%msgboxBody%",0,"%msgboxTitle%">"%tmpmsgbox%"
	WSCRIPT "%tmpmsgbox%"
	exit
) else (
	exit
)

:: CosmicLauncher
if exist "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\" (
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\admin_overlay.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/admin_overlay.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\anim.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/anim.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\armorhud.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/armorhud.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\breadcrumbs.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/breadcrumbs.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\chunkborders.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/chunkborders.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\compass.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/compass.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\cooldownhud.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/cooldownhud.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\crosshair.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/crosshair.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\cursorpersistence.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/cursorpersistence.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\emotes.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/emotes.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\eventhud.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/eventhud.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\hitsplat.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/hitsplat.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\hud.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/hud.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\leaderboard.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/leaderboard.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\mapwriter.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/mapwriter.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\minigame_leaderboard.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/minigame_leaderboard.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\mob_helper.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/mob_helper.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\motion_blur.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/motion_blur.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\notification_feed.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/notification_feed.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\peaceful_mining.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/peaceful_mining.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\perf.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/perf.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\ph.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/ph.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\pingallies.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/pingallies.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\polls.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/polls.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\potioncolors.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/potioncolors.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\roam.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/roam.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\satchelhud.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/satchelhud.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\schematica.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/schematica.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\scoreboard.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/scoreboard.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\screenshot.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/screenshot.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\settings.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/settings.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\tabchat.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/tabchat.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\target_health_bar.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/target_health_bar.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\togglesneak.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/togglesneak.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\togglesprint.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/togglesprint.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\tooltips.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/tooltips.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\vk.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/vk.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\voice.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/voice.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\wdl.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/wdl.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\worldborder.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/worldborder.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\worldeditcui.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/worldeditcui.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\xp_bar.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/xp_bar.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\cosmic\profiles\default\xp_text.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/CosmicLauncher/xp_text.json"
	SET msgboxTitle=IMPORTANT
	SET msgboxBody=Open your game and set your Render Distance between 2 - 8 and your FPS to Unlimited
	SET tmpmsgbox=%temp%\~tmpmsgbox.vbs
	IF EXIST "%tmpmsgbox%" DEL /F /Q "%tmpmsgbox%"
	ECHO msgbox "%msgboxBody%",0,"%msgboxTitle%">"%tmpmsgbox%"
	WSCRIPT "%tmpmsgbox%"
	exit
) else (
	exit
)

:: Feather Client
if exist "C:\Users\%username%\AppData\Roaming\.minecraft\feather\" (
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\feather\client_preferences.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/FeatherClient/client_preferences.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\essential\config.toml" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/FeatherClient/config.toml"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\feather\configuration\current.profile" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/FeatherClient/current.profile"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\feather\configuration\profiles\default.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/FeatherClient/default.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.feather\mods\feather-mods.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/FeatherClient/feather-mods.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.feather\user-mods\1.8.9\feather-mods.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/FeatherClient/HitDelayFix.jar"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\config\patcher_sounds.toml" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/FeatherClient/patcher_sounds.toml"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\config\patcher_sounds.toml" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/FeatherClient/patcher.toml"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\feather\patcher_sounds.toml" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/FeatherClient/sidebar.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.feather\user-mods\1.8.9\feather-mods.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/FeatherClient/TNT Time-1.1 (1.8.9).jar"

	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.ft\feather\client_preferences.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/FeatherClient/client_preferences.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.ft\essential\config.toml" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/FeatherClient/config.toml"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.ft\feather\configuration\current.profile" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/FeatherClient/current.profile"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.ft\feather\configuration\profiles\default.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/FeatherClient/default.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.ft\config\patcher_sounds.toml" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/FeatherClient/patcher_sounds.toml"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.ft\config\patcher_sounds.toml" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/FeatherClient/patcher.toml"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.ft\feather\patcher_sounds.toml" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/FeatherClient/sidebar.json"
	SET msgboxTitle=IMPORTANT
	SET msgboxBody=Open your game and set your Render Distance between 2 - 8 and your FPS to Unlimited
	SET tmpmsgbox=%temp%\~tmpmsgbox.vbs
	IF EXIST "%tmpmsgbox%" DEL /F /Q "%tmpmsgbox%"
	ECHO msgbox "%msgboxBody%",0,"%msgboxTitle%">"%tmpmsgbox%"
	WSCRIPT "%tmpmsgbox%"
	exit
) else (
	exit
)

:: LabyMod
if exist "C:\Users\%username%\AppData\Roaming\.minecraft\LabyMod\" (
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\LabyMod\addons-1.8\config\CustomCrosshair.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/LabyMod/CustomCrosshair.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\LabyMod\addons-1.8\config\CustomMainMenu.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/LabyMod/CustomMainMenu.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\LabyMod\addons-1.8\config\DamageIndicator.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/LabyMod/DamageIndicator.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\LabyMod\addons-1.8\config\DirectionHUD.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/LabyMod/DirectionHUD.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\LabyMod\addons-1.8\config\ItemPhysic.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/LabyMod/ItemPhysic.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\LabyMod\addons-1.8\config\Laby's Keystrokes.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/LabyMod/Laby's Keystrokes.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\LabyMod\addons-1.8\config\LabysMinimap.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/LabyMod/LabysMinimap.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\LabyMod\modules.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/LabyMod/modules.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\LabyMod\addons-1.8\config\MoreParticle.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/LabyMod/MoreParticle.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\LabyMod\addons-1.8\config\MotionBlur.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/LabyMod/MotionBlur.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\LabyMod\addons-1.8\config\Resourcepacks24.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/LabyMod/Resourcepacks24.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\LabyMod\addons-1.8\config\SettingsProfilesMod.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/LabyMod/SettingsProfilesMod.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\LabyMod\addons-1.8\config\SkyblockAddons.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/LabyMod/SkyblockAddons.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\LabyMod\addons-1.8\config\ToggleSneak.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/LabyMod/ToggleSneak.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\LabyMod\addons-1.8\config\VoiceChat.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/LabyMod/VoiceChat.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.minecraft\LabyMod\addons-1.8\config\WorldEditCUI.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/LabyMod/WorldEditCUI.json"
	SET msgboxTitle=IMPORTANT
	SET msgboxBody=Open your game and set your Render Distance between 2 - 8 and your FPS to Unlimited
	SET tmpmsgbox=%temp%\~tmpmsgbox.vbs
	IF EXIST "%tmpmsgbox%" DEL /F /Q "%tmpmsgbox%"
	ECHO msgbox "%msgboxBody%",0,"%msgboxTitle%">"%tmpmsgbox%"
	WSCRIPT "%tmpmsgbox%"
	exit
) else (
	exit
)

:: Lunar Client
if exist "C:\Users\%username%\.lunarclient\settings\game\Default\" (
	curl -g -L -# -o "C:\Users\%username%\.lunarclient\settings\game\Default\general.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/LunarClient/general.json"
	curl -g -L -# -o "C:\Users\%username%\.lunarclient\settings\game\Default\mods.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/LunarClient/mods.json"
	curl -g -L -# -o "C:\Users\%username%\.lunarclient\settings\game\Default\performance.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/LunarClient/performance.json"
	SET msgboxTitle=IMPORTANT
	SET msgboxBody=Open your game and set your Render Distance between 2 - 8 and your FPS to Unlimited
	SET tmpmsgbox=%temp%\~tmpmsgbox.vbs
	IF EXIST "%tmpmsgbox%" DEL /F /Q "%tmpmsgbox%"
	ECHO msgbox "%msgboxBody%",0,"%msgboxTitle%">"%tmpmsgbox%"
	WSCRIPT "%tmpmsgbox%"
	exit
) else (
	exit
)


:: Salwyrr Launcher
if exist "C:\Users\%username%\AppData\Roaming\.Salwyrr\" (
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.Salwyrr\client.properties" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/SalwyrrLauncher/client.properties"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.Salwyrr\launcher\salwyrr.client.backup" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/SalwyrrLauncher/salwyrr.client.backup"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\salwyrr.properties.backup" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/SalwyrrLauncher/salwyrr.properties.backup"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.Salwyrr\launcher\cef\SalwyrrAdBrowser.jar" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/SalwyrrLauncher/SalwyrrAdBrowser.jar"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.Salwyrr\launcher\libs\SalwyrrConfig.jar" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/SalwyrrLauncher/SalwyrrConfig.jar"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\.Salwyrr\optionsof.txt" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/1.8.9_iGPU_DynON.txt"
	SET msgboxTitle=IMPORTANT
	SET msgboxBody=Open your game and set your Render Distance between 2 - 8 and your FPS to Unlimited
	SET tmpmsgbox=%temp%\~tmpmsgbox.vbs
	IF EXIST "%tmpmsgbox%" DEL /F /Q "%tmpmsgbox%"
	ECHO msgbox "%msgboxBody%",0,"%msgboxTitle%">"%tmpmsgbox%"
	WSCRIPT "%tmpmsgbox%"
	exit
) else (
	exit
)

:: Solar Tweaks
if exist "C:\Users\%username%\AppData\Roaming\Crystal-Launcher\instances\Blazingpack\" (
	curl -g -L -# -o "C:\Users\%username%\.lunarclient\solartweaks\config.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/Solar Tweaks/badlion_settings.json"
	curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\solartweaks\settings.json" "https://raw.githubusercontent.com/SULFURA/MCOptimizer/main/files/Solar Tweaks/settings.json"
	SET msgboxTitle=IMPORTANT
	SET msgboxBody=Open your game and set your Render Distance between 2 - 8 and your FPS to Unlimited
	SET tmpmsgbox=%temp%\~tmpmsgbox.vbs
	IF EXIST "%tmpmsgbox%" DEL /F /Q "%tmpmsgbox%"
	ECHO msgbox "%msgboxBody%",0,"%msgboxTitle%">"%tmpmsgbox%"
	WSCRIPT "%tmpmsgbox%"
	exit
) else (
	exit
)

:Exit
exit

:ColorText
echo off
<nul set /p ".=%DEL%" > "%~2"
findstr /v /a:%1 /R "^$" "%~2" nul
del "%~2" > nul  
goto :eof