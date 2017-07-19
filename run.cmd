@echo off
set saxon9=saxon\saxon9he.jar
set projxslt=project.xslt
set var2x=variable2xslt.xslt
call :variableslist project.txt
call :testjava
if exist "%projxslt%" del "%projxslt%"
@echo on
java -jar "%saxon9%" -o:"%projxslt%" "%var2x%" "%var2x%"
@if not exist "%projxslt%" pause
@if exist "%outfile%" del "%outfile%"
java -jar "%saxon9%" --suppressXsltNamespaceCheck:on -o:"%outfile%" "%script%" "%script%"
@if not exist "%outfile%" pause
@if exist "%outfile%" start notepad "%outfile%"
goto :eof

:variableslist
:: Description: Handles variables list supplied in a file.
:: Required parameters:
:: list - a filename with name=value on each line of the file
set list=%~1
FOR /F "eol=[ delims== tokens=1,2" %%s IN (%list%) DO set %%s=%%t
goto :eof

:testjava
SETLOCAL ENABLEDELAYEDEXPANSION
SET count=1
FOR /F "tokens=* USEBACKQ" %%F IN (`where java`) DO (
  SET var!count!=%%F
  SET /a count=!count!+1
)
ECHO %var1%
if '%var1%' neq '%var1:INFO=%' echo Is java installed? It was not found in the path!& pause & exit
ENDLOCAL
goto :eof