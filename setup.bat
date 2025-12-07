@echo off
set "target=%~dp0.autorun.bat"

net session >nul 2>&1

if errorlevel 1 (
    echo Requesting administrative privileges...
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit /b
)

echo Press any key to continue with dotfiles setup...
pause >nul

rem Ensure Neovim config directory exists
if not exist "%LOCALAPPDATA%\nvim" (
    echo Creating Neovim config directory...
    mkdir "%LOCALAPPDATA%\nvim"
)

rem Create symlinks for dotfiles
move /y "%LOCALAPPDATA%\nvim\init.lua" "%LOCALAPPDATA%\nvim\init.lua.backup"
del /f /q "%LOCALAPPDATA%\nvim\init.lua"
mklink "%LOCALAPPDATA%\nvim\init.lua" "%~dp0neovim\init.lua"

echo Symlink for Neovim init.lua created.

rem Install programs
winget install -e --id sharkdp.bat
winget install -e --id eza-community.eza
winget install -e --id gerardog.gsudo
winget install -e --id ajeetdsouza.zoxide

echo Programs installed.

if exist "%USERPROFILE%\.emacs" del "%USERPROFILE%\.emacs" 2>nul
if exist "%APPDATA%\.emacs" del "%APPDATA%\.emacs" 2>nul
mklink "%USERPROFILE%\.emacs" "%~dp0emacs\.emacs"
mklink "%APPDATA%\.emacs" "%~dp0emacs\.emacs"

echo Symlink for Emacs created.

if exist "%USERPROFILE%\.bashrc" del "%USERPROFILE%\.bashrc" 2>nul
mklink "%USERPROFILE%\.bashrc" "%~dp0bash\.bashrc"
if exist "%USERPROFILE%\.inputrc" del "%USERPROFILE%\.inputrc" 2>nul
mklink "%USERPROFILE%\.inputrc" "%~dp0bash\.inputrc"

echo Symlinks for Bash created.

echo Adding autorun for Command Prompt...
reg add "HKCU\Software\Microsoft\Command Processor" /v AutoRun /t REG_SZ /d "%~dp0cmd\autorun.bat" /f
echo CMD autorun set to: %~dp0cmd\autorun.bat

echo Dotfiles setup complete.
pause >nul
