@echo off

zoxide --version >nul 2>&1
if errorlevel 1 (
    echo Zoxide not installed
    exit /b 1
)

set "arg=%~1"

if "%arg%"=="-" (
    cd /d "%oldcwd%" >nul 2>&1 || (
        exit /b 1
    )
    set "oldcwd=%CD%"
    exit /b 0
)

set "oldcwd=%CD%"

if "%arg%"=="" (
    cd /d "%USERPROFILE%"
    exit /b 0
)

if "%arg:~0,1%"=="~" set "arg=%USERPROFILE%%arg:~1%"

cd /d "%arg%" >nul 2>&1 || (
    zoxide add "%CD%"
    goto zoxide
)

zoxide add "%CD%"

goto :eof

:zoxide

for /f "usebackq delims=" %%i in (`zoxide query "%arg%" 2^>nul`) do (
    if errorlevel 1 (
        echo zoxide error
        exit /b 1
    )
    cd /d "%%i"
    zoxide add "%CD%"
    exit /b
)
