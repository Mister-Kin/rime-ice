@chcp 936>nul
@echo off & title һ�����������ļ� & color F0
cd /d %~dp0

goto :start_job

:draw_line
@REM �ֲ��������ô�ӡ�ķ��ź������������ݵ�ȫ�ֻ���draw_line_chars������
setlocal enabledelayedexpansion
@REM ��ѯ��ǰ�ն˴��ڵ�������С��delims����:֮��û�пո񣬻����ж���ո���һ����Ч�������޷�trim����Ŀո񡣲���:���治�ܵ�����һ���ո񣬷����޷���ȷ��ȡ��
for /f "tokens=2 delims=:" %%c in ('mode con ^| findstr "��"') do set cols=%%c
@REM �Ƴ���������߶���Ŀո�
for /f "tokens=* delims=: " %%c in ('echo %cols%') do set cols=%%c
set "char=%~1"
set /a "count=%cols%"
set "line="
for /l %%i in (1,1,%count%) do set "line=!line!%char%"
endlocal & set "draw_line_chars=%line%"
echo %draw_line_chars%
exit /b

:log
setlocal
for /f "tokens=1-3 delims=/ " %%a in ('date /t') do (set "yy=%%a" & set "mm=%%b" & set "dd=%%c")
for /f "tokens=1-3 delims=:." %%a in ('echo %time%') do (set "hh=%%a" & set "mn=%%b" & set "ss=%%c")
set time_stamp=%yy%-%mm%-%dd%T%hh%:%mn%:%ss%+08:00
echo %time_stamp% %~1
endlocal
exit /b

:log_with_quote
setlocal
for /f "tokens=1-3 delims=/ " %%a in ('date /t') do (set "yy=%%a" & set "mm=%%b" & set "dd=%%c")
for /f "tokens=1-3 delims=:." %%a in ('echo %time%') do (set "hh=%%a" & set "mn=%%b" & set "ss=%%c")
set time_stamp=%yy%-%mm%-%dd%T%hh%:%mn%:%ss%+08:00
echo %time_stamp% "%~1"
endlocal
exit /b

:start_job
cls
call :draw_line "="
echo.
call :log "��ӭʹ�á�һ�����������ļ�����������"
echo.
call :log_with_quote "�������ߣ�Mr. Kin im.misterkin@gmail.com"
echo.
call :draw_line "="
echo.
call :log "��������Զ�������Ŀ�е�����С�Ǻ������ļ����Ƶ�С�Ǻ����û��ļ����£��� ��%AppData%\Rime�� ·����"
echo.
call :log "ע�⣺��������ͬ���ļ����ļ��н���ǿ�Ƹ��ǣ����豣����������ļ����ݣ��������д�����ļ���ִ�б�����"
echo.
call :draw_line "="
echo.
call :log "�밴���������������ɸ���"
@pause>nul
echo.
call :draw_line "="
echo.

if exist "%AppData%\Rime" (
    call :log "�Ѽ�⵽��%AppData%\Rime��·������ʼ���и��Ʋ���"
    echo.
) else (
    call :log "δ��⵽��%AppData%\Rime��·��"
    echo.
    call :log "���Ȱ�װ��С�Ǻ����뷨����֮�������б�����"
    echo.
    call :log "�밴������������߹ر��ն˴����˳�"
    echo.
    @pause>nul
    exit
)
call :draw_line "="
echo.
call :log "��ǰ·��Ϊ��%cd%��"
echo.
call :draw_line "="
echo.

@REM �������/i��������Ҫ�ֶ���Ŀ��·���������Ϸ�б��\���ű������Ǹ�Ŀ¼������xcopy������Ŀ¼·�����ļ������ļ���
xcopy /s /i /y .\cn_dicts "%AppData%\Rime\cn_dicts">nul
if "%errorlevel%" EQU "0" (
    call :copy_success_text "��cn_dicts���ļ���"
) else (
    call :copy_failed_text "��cn_dicts���ļ���"
)

xcopy /s /i /y .\en_dicts "%AppData%\Rime\en_dicts">nul
if "%errorlevel%" EQU "0" (
    call :copy_success_text "��en_dicts���ļ���"
) else (
    call :copy_failed_text "��en_dicts���ļ���"
)

xcopy /s /i /y .\lua "%AppData%\Rime\lua">nul
if "%errorlevel%" EQU "0" (
    call :copy_success_text "��lua���ļ���"
) else (
    call :copy_failed_text "��lua���ļ���"
)

xcopy /s /i /y .\opencc "%AppData%\Rime\opencc">nul
if "%errorlevel%" EQU "0" (
    call :copy_success_text "��opencc���ļ���"
) else (
    call :copy_failed_text "��opencc���ļ���"
)

xcopy /s /i /y .\others "%AppData%\Rime\others">nul
if "%errorlevel%" EQU "0" (
    call :copy_success_text "��others���ļ���"
) else (
    call :copy_failed_text "��others���ļ���"
)

xcopy /y .\*.yaml "%AppData%\Rime\">nul
if "%errorlevel%" EQU "0" (
    call :copy_success_text "������yaml���ļ�"
) else (
    call :copy_failed_text "������yaml���ļ�"
)

@REM Lua ģ�����÷�ʽ������ο�����commit��ɾ���� `rime.lua`��
@REM https://github.com/Mister-Kin/rime-ice/commit/aa505b7b2d5123a1fdef9951dea605a7cbb0d081
@REM xcopy /y .\rime.lua "%AppData%\Rime\">nul
@REM if "%errorlevel%" EQU "0" (
@REM     call :copy_success_text "��rime.lua���ļ�"
@REM ) else (
@REM     call :copy_failed_text "��rime.lua���ļ�"
@REM )

xcopy /y .\custom_phrase.txt "%AppData%\Rime\">nul
if "%errorlevel%" EQU "0" (
    call :copy_success_text "��custom_phrase.txt���ļ�"
) else (
    call :copy_failed_text "��custom_phrase.txt���ļ�"
)

call :draw_line "="
echo.
call :log "����ɸ��ƣ��밴������������߹ر��ն˴����˳�"
@pause>nul
exit

:copy_success_text
call :log "�ѳɹ�����%1����%AppData%\Rime��·����"
echo.
exit /b

:copy_failed_text
call :log "�޷�����%1����%AppData%\Rime��·���£���ص��������������л����ֶ����и���"
echo.
call :log "�밴����������˳����߹ر��ն˴����˳�"
echo.
@pause>nul
exit
