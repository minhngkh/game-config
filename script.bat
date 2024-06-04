@echo off
echo --- GAME CONFIG ---
echo Finding csgo's config directory...

for /f "skip=1delims=" %%a in ('wmic process where name^="steam.exe" get ExecutablePath') do (
    set "path=%%~dpa"
    goto next
)
:next
set cs2_path=%path%steamapps\common\Counter-Strike Global Offensive\game\csgo\
if not exist "%cs2_path%" (echo Can't find path, make sure Steam is running && goto skip)

echo Adding config files...
copy "*.cfg" "%cs2_path%\cfg\" > NUL

:skip
if exist "eapo.exe" (goto installed)

set exe=https://webwerks.dl.sourceforge.net/project/equalizerapo/1.3.2/EqualizerAPO64-1.3.2.exe?viasf=1
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
start /w net stop audiosrvs
start /w net start audiosrv

echo --- LAUNCH OPTIONS ---
echo +exec autoexec.cfg -high -nojoy
echo --- END ---
pause
