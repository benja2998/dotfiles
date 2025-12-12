@echo off

setlocal enabledelayedexpansion
:: [[ Variables ]] ::
set "PSH=powershell -NoProfile -NoLogo -ExecutionPolicy Bypass -Command"
:: [[ Uninstall apps ]] ::
%PSH% "Get-AppxPackage *zune* | Remove-AppxPackage"
%PSH% "Get-AppxPackage *outlook* | Remove-AppxPackage"
%PSH% "Get-AppxPackage *office* | Remove-AppxPackage"
%PSH% "Get-AppxPackage *candy* | Remove-AppxPackage"
%PSH% "Get-AppxPackage *bing* | Remove-AppxPackage"
:: [[ Run Windows Utility by Chris Titus Tech ]] ::
set "base_path=%~dp0"
set "temp_dir=%TEMP%"
set "config_path=%temp_dir%\winutil_config.json"
set "download_dir=%temp_dir%\debloater"
set "url=https://christitus.com/win"
set "name=winutil.ps1"
set "winutil_path=%download_dir%\%name%"
if not exist "%download_dir%" mkdir "%download_dir%"
%PSH% "$cfg=@{WPFTweaks=@('WPFTweaksDeBloat','WPFTweaksDisableLMS1','WPFTweaksAH','WPFTweaksServices','WPFTweaksConsumerFeatures','WPFTweaksRemoveCopilot','WPFTweaksWifi','WPFTweaksTele','WPFTweaksDisableBGapps','WPFTweaksRecallOff')};$cfg|ConvertTo-Json -Depth 5|Set-Content -Encoding UTF8 '%config_path%'"
%PSH% "Invoke-WebRequest -Uri '%url%' -OutFile '%winutil_path%'"
if not exist "%winutil_path%" exit /b 1
%PSH% "$c=Get-Content '%winutil_path%' -Raw;$re='(?ms)^\s*Write-Host \"Installing features\.\.\.\".*?Write-Host \"Done\.\"';$c=[regex]::Replace($c,$re,'Write-Host \"Features installation skipped\"`n');Set-Content -Path '%winutil_path%' -Value $c -Encoding UTF8"
%PSH% "& '%winutil_path%' -Config '%config_path%' -Run -NoUI"
endlocal
