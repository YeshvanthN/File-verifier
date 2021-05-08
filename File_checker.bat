@echo off
title File Checker
:BEG

CALL :FILE
CALL :HTYPE
set /p chash=" Enter hash to compare (if no enter 'n'): "

echo Your output is ....
if %chash%==n (CALL :CF) else (CALL :CC)

echo.
set /p c=" DO YOU WANT TO CONTINUE (Y/N) : "
echo.
if %c% EQU Y (CALL :BEG) else if %c% EQU y (CALL :BEG)

EXIT /B %ERRORLEVEL%

:CC
certutil -hashfile %direc% %htype% | find /i /v "hash" | find /i /v "successfully" > temp.txt
set /p temp=<temp.txt
if %temp% EQU %chash% (echo Safe to go) else (echo WARNING hash does not match)
pause
EXIT /B 0

:CF
certutil -hashfile %direc% %htype% > temp.txt 
temp.txt
EXIT /B 0

:HTYPE
set /p htype=" Enter Type of hash to generate : "
for %%h in (md2,MD2,md3,MD3,md4,MD4,md5,MD5,sha1,SHA1,sha256,SHA256,sha384,SHA384,sha512,SHA512) do (set /A %i=1
if %%h==%htype% (EXIT /B 0) else (set /A i=0))
echo.
if %i%==0 (echo Enter a format in the following :
echo MD2 MD4 MD5 SHA1 SHA256 SHA384 SHA512
pause
CALL :HTYPE)
EXIT /B 0

:FILE
set /p direc=" Enter file path : "
IF EXIST %direc% (EXIT /B 0) ELSE (echo.
echo Enter a valid path
CALL :FILE)
EXIT /B 0

EXIT /B
