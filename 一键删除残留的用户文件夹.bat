@chcp 936>nul
@echo off & title һ��ɾ���������û��ļ��� & color F0
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
call :log "��ӭʹ�á�һ��ɾ���������û��ļ��С���������"
echo.
call :log_with_quote "�������ߣ�Mr. Kin im.misterkin@gmail.com"
echo.
call :draw_line "="
echo.
call :log "����������ж��С�Ǻ����뷨������Զ�ɾ���������û��ļ��У��� ��%AppData%\Rime�� ·��"
echo.
call :log "ע�⣺�����޼ۣ����豣����������ļ����ݣ��������д�����ļ���ִ�б�����"
echo.
call :draw_line "="
echo.
call :log "�밴����������������ɾ��"
@pause>nul
echo.
call :draw_line "="
echo.

if exist "%AppData%\Rime" (
    call :log "�Ѽ�⵽��%AppData%\Rime��·������ʼ����ɾ������"
    echo.
    rmdir /s /q "%AppData%\Rime"
    if "%errorlevel%" EQU "0" (
        call :log "��ɾ����%AppData%\Rime���ļ���"
        echo.
        call :draw_line "="
        echo.
        call :log "�����ɾ�����밴������������߹ر��ն˴����˳�"
        @pause>nul
        exit
    ) else (
        call :log "�޷�ɾ����%AppData%\Rime���ļ��У���ص��������������л����ֶ�����ɾ��"
        echo.
        call :log "�밴��������߹ر��ն˴����˳�"
        echo.
        @pause>nul
    )
) else (
    call :log "δ��⵽��%AppData%\Rime��·��"
    echo.
    call :log "����ִ��ɾ��"
    echo.
    call :log "�밴��������߹ر��ն˴����˳�"
    echo.
    @pause>nul
)
exit
