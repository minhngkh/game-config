@echo off
echo --- CSGO CONFIG ---
echo Finding csgo's config directory...

for /f "skip=1delims=" %%a in ('wmic process where name^="steam.exe" get ExecutablePath') do (
    set "path=%%~dpa"
    goto next
)
:next
set csgo=%path%steamapps\common\Counter-Strike Global Offensive\csgo
if not exist "%csgo%" (echo Can't find path, make sure Steam is running && goto skip)

echo Adding config files...
copy "*.cfg" "%csgo%\cfg\" > NUL
echo Applying colormod...
copy "colormod\*" "%csgo%\resource\" > NUL
echo Applying Simple Radar...
copy "Simple Radar\01 default\*" "%csgo%\resource\overviews\" > NUL
copy "Simple Radar\02 spectate\*" "%csgo%\resource\overviews\" > NUL

:skip
if exist "eapo.exe" (goto installed)

set exe=https://onboardcloud.dl.sourceforge.net/project/equalizerapo/1.3/EqualizerAPO64-1.3.exe
echo Downloading EqualizerAPO
start /w curl -o eapo.exe "%exe%"

:installed
echo Intalling EqualizerAPO
start /w eapo.exe

set eapo=C:\Program Files\EqualizerAPO\config
if not exist "%eapo%" (echo Can't find path, make sure EqualizerAPO 1.3 is properly installed)

echo Applying EqualizerAPO config...
copy "EqualizerAPO\config.txt" "%eapo%\config.txt" > NUL

echo Restarting audio server
start /w net stop audiosrv
start /w net start audiosrv

echo --- LAUNCH OPTIONS ---
echo 128 tick: +exec autoexec.cfg -high -novid -nojoy -language colormod -freq 240 -tickrate 128
echo 64 tick: +exec autoexec.cfg -high -novid -nojoy -language colormod -freq 240 -tickrate 64
echo --- END ---
pause
