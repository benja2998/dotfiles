@echo off

rem autorun.bat
rem Runs on Command Processor AutoRun

chcp 65001 >nul

set "TERM=xterm-256color"

net session >nul 2>&1

if errorlevel 1 (
    prompt $e[33m[$t]$e[0m$s$e[32m%username%@%computername%$s$e[34m$p$e[0m$s$$$s
) else (
    prompt $e[33m[$t]$e[0m$s$e[31m%username%$e[0m@%computername%$s$p$s#$s
)

doskey sudo=gsudo $*
doskey cat=bat -pP $*
doskey clear=cls $*
doskey vim=nvim $*
doskey ls=dir $*
set "PATH=%~dp0scripts;%PATH%"

rem Automatically run chocolatey elevated
doskey choco=gsudo choco $*
