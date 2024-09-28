@echo off
chcp 65001 > nul
echo Mental Omega Redux version 0.1 by Eagle-Vulture
echo.

set MIX=Tools\ccmix.exe
set CSFTOOL=Tools\CSFTool.exe

: Удаление ранее скомпилированной папки
rmdir /s /q Build
mkdir Build

echo Компилирование строкой таблицы...
%CSFTOOL% -t "Source\MIX\EXPANDMD42\stringtable00.txt" -o "Source\MIX\EXPANDMD42\stringtable00.csf" -a

echo Копирование файлов клиента...
xcopy /h /y /c /r /s Source\CLIENT\ Build\

echo Копирование расширений движка...
for /f "tokens=*" %%f in ('dir "Source\" /a:a /b') do (
	copy "Source\%%f" "Build\%%f"
	)
echo.

echo Копирование предкомпилированных архивов...
for /f "tokens=*" %%f in ('dir "Source\MIX" /a:a /b') do (
	copy "Source\MIX\%%f" "Build\%%f"
	)
echo.

for /f "tokens=*" %%f in ('dir "Source\MIX\" /a:d /b') do (
	echo Компилирование %%f.mix...
	%MIX% --create --lmd --game=ra2 --dir "Source\MIX\%%f" --mix "Build\%%f.mix"
	echo.
	)

echo Все MIX-архивы были собраны.
echo Сборка проекта окончена. Пожалуйста, проверьте папку Build.
