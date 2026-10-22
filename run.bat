@echo off
setlocal
pushd "%~dp0"
call mvnw.cmd javafx:run
set "GAME_EXIT_CODE=%ERRORLEVEL%"
popd
exit /b %GAME_EXIT_CODE%
