@echo off
REM Starts the local TeraLeader content manager.
setlocal
cd /d "%~dp0"

where node >nul 2>nul
if errorlevel 1 (
  echo Node.js was not found in PATH.
  echo Install Node.js LTS from https://nodejs.org/ and run this file again.
  pause
  exit /b 1
)

start "" "http://127.0.0.1:5081/"
node tools\content-manager\server.mjs

echo.
echo Content manager has stopped.
pause
