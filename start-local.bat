@echo off
rem ---------------------------------------------------------------
rem  Double-click this file to preview the portfolio on this PC.
rem  It serves this folder at http://localhost:8000 and opens the
rem  site in your browser. Close this window to stop the server.
rem ---------------------------------------------------------------

setlocal
cd /d "%~dp0"

set "PORT=8000"
set "PAGE=yogesh-portfolio.html"

echo.
echo  Yogesh Salunkhe - Portfolio (local preview)
echo  -------------------------------------------
echo.

rem --- Find something on this PC that can serve a folder -----------

where py >nul 2>nul
if %errorlevel%==0 (
    set "SERVE=py -3 -m http.server %PORT% --bind 127.0.0.1"
    goto :run
)

where python >nul 2>nul
if %errorlevel%==0 (
    set "SERVE=python -m http.server %PORT% --bind 127.0.0.1"
    goto :run
)

where npx >nul 2>nul
if %errorlevel%==0 (
    set "SERVE=npx --yes serve -l tcp://127.0.0.1:%PORT%"
    goto :run
)

rem --- Nothing found: fall back to opening the file directly -------

echo  Python and Node are not installed on this PC, so there is no
echo  local server to start. Opening the page directly instead -
echo  the site is self-contained, so it will still look correct.
echo.
start "" "%~dp0%PAGE%"
echo  Press any key to close.
pause >nul
exit /b 0

:run

rem Open the browser a couple of seconds from now, in the background,
rem so the server below has time to come up first.
start "" /b cmd /c "ping -n 3 127.0.0.1 >nul & explorer http://localhost:%PORT%/%PAGE%"

echo   Portfolio:  http://localhost:%PORT%/%PAGE%
echo   Dashboard:  http://localhost:%PORT%/admin-dashboard.html
echo.
echo   Starting server... close this window to stop it.
echo.

%SERVE%

rem Only reached if the server quit on its own - usually means the
rem port is already taken by another copy of this script.
echo.
echo  The server stopped. If that happened immediately, port %PORT% is
echo  probably already in use - close the other preview window and
echo  try again.
echo.
pause
