@chcp 936>nul
@echo off & title 一键删除残留的用户文件夹 & color F0
cd /d %~dp0

goto :start_job

:draw_line
@REM 局部环境设置打印的符号和数量，并传递到全局环境draw_line_chars变量中
setlocal enabledelayedexpansion
@REM 查询当前终端窗口的列数大小，delims后面:之后没有空格，或者有多个空格都是一样的效果，它无法trim多余的空格。并且:后面不能单独加一个空格，否则无法正确获取。
for /f "tokens=2 delims=:" %%c in ('mode con ^| findstr "列"') do set cols=%%c
@REM 移除变量中左边多余的空格
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
call :log "欢迎使用「一键删除残留的用户文件夹」自助程序"
echo.
call :log_with_quote "程序作者：Mr. Kin im.misterkin@gmail.com"
echo.
call :draw_line "="
echo.
call :log "本程序用于卸载小狼毫输入法程序后，自动删除残留的用户文件夹，即 「%AppData%\Rime」 路径"
echo.
call :log "注意：数据无价，若需保存相关配置文件数据，请先自行处理好文件再执行本程序"
echo.
call :draw_line "="
echo.
call :log "请按键盘任意键继续完成删除"
@pause>nul
echo.
call :draw_line "="
echo.

if exist "%AppData%\Rime" (
    call :log "已检测到「%AppData%\Rime」路径，开始进行删除操作"
    echo.
    rmdir /s /q "%AppData%\Rime"
    if "%errorlevel%" EQU "0" (
        call :log "已删除「%AppData%\Rime」文件夹"
        echo.
        call :draw_line "="
        echo.
        call :log "已完成删除，请按键盘任意键或者关闭终端窗口退出"
        @pause>nul
        exit
    ) else (
        call :log "无法删除「%AppData%\Rime」文件夹，请关掉程序尝试重新运行或者手动进行删除"
        echo.
        call :log "请按任意键或者关闭终端窗口退出"
        echo.
        @pause>nul
    )
) else (
    call :log "未检测到「%AppData%\Rime」路径"
    echo.
    call :log "无需执行删除"
    echo.
    call :log "请按任意键或者关闭终端窗口退出"
    echo.
    @pause>nul
)
exit
