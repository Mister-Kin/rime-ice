@chcp 936>nul
@echo off & title 一键复制配置文件 & color F0
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
call :log "欢迎使用「一键复制配置文件」自助程序"
echo.
call :log_with_quote "程序作者：Mr. Kin im.misterkin@gmail.com"
echo.
call :draw_line "="
echo.
call :log "本程序会自动将本项目中的所有小狼毫配置文件复制到小狼毫的用户文件夹下，即 「%AppData%\Rime」 路径下"
echo.
call :log "注意：本程序会对同名文件及文件夹进行强制覆盖，若需保存相关配置文件数据，请先自行处理好文件再执行本程序"
echo.
call :draw_line "="
echo.
call :log "请按键盘任意键继续完成复制"
@pause>nul
echo.
call :draw_line "="
echo.

if exist "%AppData%\Rime" (
    call :log "已检测到「%AppData%\Rime」路径，开始进行复制操作"
    echo.
) else (
    call :log "未检测到「%AppData%\Rime」路径"
    echo.
    call :log "请先安装好小狼毫输入法程序，之后再运行本程序"
    echo.
    call :log "请按键盘任意键或者关闭终端窗口退出"
    echo.
    @pause>nul
    exit
)
call :draw_line "="
echo.
call :log "当前路径为「%cd%」"
echo.
call :draw_line "="
echo.

@REM 如果不加/i参数，需要手动在目标路径的最后加上反斜杠\符号表明这是个目录，否则xcopy会提问目录路径是文件还是文件夹
xcopy /s /i /y .\cn_dicts "%AppData%\Rime\cn_dicts">nul
if "%errorlevel%" EQU "0" (
    call :copy_success_text "「cn_dicts」文件夹"
) else (
    call :copy_failed_text "「cn_dicts」文件夹"
)

xcopy /s /i /y .\en_dicts "%AppData%\Rime\en_dicts">nul
if "%errorlevel%" EQU "0" (
    call :copy_success_text "「en_dicts」文件夹"
) else (
    call :copy_failed_text "「en_dicts」文件夹"
)

xcopy /s /i /y .\lua "%AppData%\Rime\lua">nul
if "%errorlevel%" EQU "0" (
    call :copy_success_text "「lua」文件夹"
) else (
    call :copy_failed_text "「lua」文件夹"
)

xcopy /s /i /y .\opencc "%AppData%\Rime\opencc">nul
if "%errorlevel%" EQU "0" (
    call :copy_success_text "「opencc」文件夹"
) else (
    call :copy_failed_text "「opencc」文件夹"
)

xcopy /s /i /y .\others "%AppData%\Rime\others">nul
if "%errorlevel%" EQU "0" (
    call :copy_success_text "「others」文件夹"
) else (
    call :copy_failed_text "「others」文件夹"
)

xcopy /y .\*.yaml "%AppData%\Rime\">nul
if "%errorlevel%" EQU "0" (
    call :copy_success_text "「所有yaml」文件"
) else (
    call :copy_failed_text "「所有yaml」文件"
)

@REM Lua 模块引用方式变更，参考下面commit（删除了 `rime.lua`）
@REM https://github.com/Mister-Kin/rime-ice/commit/aa505b7b2d5123a1fdef9951dea605a7cbb0d081
@REM xcopy /y .\rime.lua "%AppData%\Rime\">nul
@REM if "%errorlevel%" EQU "0" (
@REM     call :copy_success_text "「rime.lua」文件"
@REM ) else (
@REM     call :copy_failed_text "「rime.lua」文件"
@REM )

xcopy /y .\custom_phrase.txt "%AppData%\Rime\">nul
if "%errorlevel%" EQU "0" (
    call :copy_success_text "「custom_phrase.txt」文件"
) else (
    call :copy_failed_text "「custom_phrase.txt」文件"
)

call :draw_line "="
echo.
call :log "已完成复制，请按键盘任意键或者关闭终端窗口退出"
@pause>nul
exit

:copy_success_text
call :log "已成功复制%1到「%AppData%\Rime」路径下"
echo.
exit /b

:copy_failed_text
call :log "无法复制%1到「%AppData%\Rime」路径下，请关掉程序尝试重新运行或者手动进行复制"
echo.
call :log "请按键盘任意键退出或者关闭终端窗口退出"
echo.
@pause>nul
exit
