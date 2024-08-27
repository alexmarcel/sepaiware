@echo off
Title SEPAIware

set "global_location=KKM, BAHAGIAN PENGURUSAN LATIHAN, ILKKM TAWAU"
set "global_tagid=null"
set "global_installtype=null"
set "global_hostname=i08P"

:: check installer if exist
set "filename=GLPI-Agent-1.7.3-x64.msi"
if exist "%filename%" (
	echo %filename% found.
) else (
	echo ERROR! The file %filename% not found.
)
set "filename=GLPI-Agent-1.7.3-x86.msi"
if exist "%filename%" (
	echo %filename% found.
) else (
	echo ERROR! The file %filename% not found.
)


:mainmenu
cls
echo HOSTNAME : %ComputerName%
:: Check processor architecture
if "%PROCESSOR_ARCHITECTURE%"=="AMD64" (
    echo ARCHITECTURE : x64
) else if "%PROCESSOR_ARCHITECTURE%"=="x86" (
    echo ARCHITECTURE : x86
) else (
    echo Unknown architecture: %PROCESSOR_ARCHITECTURE%
)
netsh advfirewall show allprofiles state
echo.
echo Select an option
echo 1. Change HOSTNAME
echo 2. Install GLPI
echo 3. Exit
echo.
set /p choice="Enter your choice (1-3): "

if "%choice%"=="1" goto hostname
if "%choice%"=="2" goto location
if "%choice%"=="3" goto exit

echo Invalid choice. Please select a valid option.
goto mainmenu




:hostname
echo.
set /p newHostname="Current hostname is %ComputerName%. Enter new hostname: %global_hostname%"

:: Display the entered text
echo.
set "newHostName=%global_hostname%%newHostname%"

:hostnameYN
set /p userInput="Set new hostname to %newHostName%? (Y/N): "

:: Convert input to uppercase to make the comparison case-insensitive
set "userInput=%userInput:~0,1%"
set "userInput=%userInput: =%"
echo.

:: Check the user input
if /i "%userInput%"=="Y" (
	Wmic ComputerSystem where Caption='%ComputerName%' rename %newHostName%
	echo Command Executed. Restart for the hostname change to take effect.
	echo.
	goto restartpc
) else if /i "%userInput%"=="N" (
	goto mainmenu
) else (
	echo Invalid choice. Please enter Y or N.
	echo.
    	goto hostnameYN
)
goto mainmenu


:restartpc
echo.
set /p userInput="Restart Computer? (Y/N): "

:: Convert input to uppercase to make the comparison case-insensitive
set "userInput=%userInput:~0,1%"
set "userInput=%userInput: =%"
echo.

:: Check the user input
if /i "%userInput%"=="Y" (
	shutdown /r
	echo Restarting...
	pause
) else if /i "%userInput%"=="N" (
	goto mainmenu
) else (
	echo Invalid choice. Please enter Y or N.
	echo.
    	goto restartpc
)
goto exit


:location
echo.
echo Available locations:
echo 0. [CUSTOM]
echo 1. BILIK PENGARAH
echo 2. BILIK TIMBALAN PENGARAH AKADEMIK
echo 3. BILIK TIMBALAN PENGARAH HEP
echo 4. BILIK KPNK
echo 5. PEJABAT PENTADBIRAN
echo 6. PEJABAT AKAUN
echo 7. PEJABAT PENGAJAR
echo 8. PERPUSTAKAAN
echo 9. BILIK PEPERIKSAAN
echo 10. BILIK PEMANDU
echo 11. MAKMAL KETERAMPILAN 1
echo 12. STOR ALAT TULIS
echo 13. DEWAN DOVE
echo 14. DEWAN CANARY
echo 15. DEWAN NIGHTINGALE
echo 16. DEWAN PERSIDANGAN
echo 17. PEJABAT KESELAMATAN
echo 18. PEJABAT KLINIKAL
echo 19. PEJABAT ASRAMA
echo 20. [Back to Main]
echo.

set /p choice="Select a location TAG (0-20): "

:: Set a variable based on the user's choice
if "%choice%"=="0" goto customlocation
if "%choice%"=="1" set "selected=BILIK PENGARAH"
if "%choice%"=="2" set "selected=BILIK TIMBALAN PENGARAH AKADEMIK"
if "%choice%"=="3" set "selected=BILIK TIMBALAN PENGARAH HEP"
if "%choice%"=="4" set "selected=BILIK KPNK"
if "%choice%"=="5" set "selected=PEJABAT PENTADBIRAN"
if "%choice%"=="6" set "selected=PEJABAT AKAUN"
if "%choice%"=="7" set "selected=PEJABAT PENGAJAR"
if "%choice%"=="8" set "selected=PERPUSTAKAAN"
if "%choice%"=="9" set "selected=BILIK PEPERIKSAAN"
if "%choice%"=="10" set "selected=BILIK PEMANDU"
if "%choice%"=="11" set "selected=MAKMAL KETERAMPILAN 1"
if "%choice%"=="12" set "selected=STOR ALAT TULIS"
if "%choice%"=="13" set "selected=DEWAN DOVE"
if "%choice%"=="14" set "selected=DEWAN CANARY"
if "%choice%"=="15" set "selected=DEWAN NIGHTINGALE"
if "%choice%"=="16" set "selected=DEWAN PERSIDANGAN"
if "%choice%"=="17" set "selected=PEJABAT KESELAMATAN"
if "%choice%"=="18" set "selected=PEJABAT KLINIKAL"
if "%choice%"=="19" set "selected=PEJABAT ASRAMA"
if "%choice%"=="20" goto mainmenu

if not defined selected (
    echo Invalid location. Please select a valid location.
    goto :location
)

echo.
echo You selected %selected%
echo TAG ID will be : "%global_location%, %selected%"
set "global_tagid=%global_location%, %selected%"
goto menu




:customlocation
echo.
echo Please enter your custom location:
set /p customLoc="Location: "

:: Display the entered text
echo.
echo You entered "%customLoc%"
echo TAG ID will be : "%global_location%, %customLoc%"
set "global_tagid=%global_location%, %customLoc%"
goto menu





:menu
echo.
:: Check processor architecture
if "%PROCESSOR_ARCHITECTURE%"=="AMD64" (
    echo Architecture detected : x64
) else if "%PROCESSOR_ARCHITECTURE%"=="x86" (
    echo Architecture detected : x86
) else (
    echo Unknown architecture: %PROCESSOR_ARCHITECTURE%
)
echo.
echo Select an option
echo 1. Run GLPI-Agent-1.7.3-x64.msi
echo 2. Run GLPI-Agent-1.7.3-x86.msi
echo 3. Set Location Again
echo 4. Open Force Inventory URL
echo 5. Back to Main
echo 6. Exit
echo.

set /p choice="Enter your choice (1-6): "

if "%choice%"=="1" goto option1
if "%choice%"=="2" goto option2
if "%choice%"=="3" goto location
if "%choice%"=="4" goto option4
if "%choice%"=="5" goto mainmenu
if "%choice%"=="6" goto exit

echo Invalid choice. Please select a valid option.
goto menu




:option1
echo.
echo GLPI-Agent-1.7.3-x64.msi selected.
set "global_installtype=x64"
echo.
echo The following command will be executed :
echo.
echo msiexec.exe /i "C:\GLPI-Agent-1.7.3-%global_installtype%.msi" /norestart SERVER="https://helpdeskict.moh.gov.my/" RUNNOW=1 ADDLOCAL=ALL ADD_FIREWALL_EXCEPTION=1 NO_SSL_CHECK=1 tag="%global_tagid%" 
echo.
set /p userInput="Run command? (Y/N): "

:: Convert input to uppercase to make the comparison case-insensitive
set "userInput=%userInput:~0,1%"
set "userInput=%userInput: =%"
echo.

:: Check the user input
if /i "%userInput%"=="Y" (
	:: run command
	msiexec.exe /i "C:\GLPI-Agent-1.7.3-%global_installtype%.msi" /norestart SERVER="https://helpdeskict.moh.gov.my/" RUNNOW=1 ADDLOCAL=ALL ADD_FIREWALL_EXCEPTION=1 NO_SSL_CHECK=1 tag="%global_tagid%"
	echo Command Executed.
	echo.
	echo msiexec.exe /i "C:\GLPI-Agent-1.7.3-%global_installtype%.msi" /norestart SERVER="https://helpdeskict.moh.gov.my/" RUNNOW=1 ADDLOCAL=ALL ADD_FIREWALL_EXCEPTION=1 NO_SSL_CHECK=1 tag="%global_tagid%" > runspai-"%selected%"-"%global_installtype%".bat
	echo runspai-%selected%-%global_installtype%.bat created in %CD% as backup.
	echo.
) else if /i "%userInput%"=="N" (
	goto menu
) else (
	echo Invalid choice. Please enter Y or N.
	echo.
    	goto option1
)

goto menu




:option2
echo.
echo GLPI-Agent-1.7.3-x86.msi selected.
set "global_installtype=x86"
echo.
echo The following command will be executed :
echo.
echo msiexec.exe /i "C:\GLPI-Agent-1.7.3-%global_installtype%.msi" /norestart SERVER="https://helpdeskict.moh.gov.my/" RUNNOW=1 ADDLOCAL=ALL ADD_FIREWALL_EXCEPTION=1 NO_SSL_CHECK=1 tag="%global_tagid%" 
echo.
set /p userInput="Run command? (Y/N): "

:: Convert input to uppercase to make the comparison case-insensitive
set "userInput=%userInput:~0,1%"
set "userInput=%userInput: =%"
echo.

:: Check the user input
if /i "%userInput%"=="Y" (
	:: run command
	msiexec.exe /i "C:\GLPI-Agent-1.7.3-%global_installtype%.msi" /norestart SERVER="https://helpdeskict.moh.gov.my/" RUNNOW=1 ADDLOCAL=ALL ADD_FIREWALL_EXCEPTION=1 NO_SSL_CHECK=1 tag="%global_tagid%"
	echo Command Executed.
	echo.
	echo msiexec.exe /i "C:\GLPI-Agent-1.7.3-%global_installtype%.msi" /norestart SERVER="https://helpdeskict.moh.gov.my/" RUNNOW=1 ADDLOCAL=ALL ADD_FIREWALL_EXCEPTION=1 NO_SSL_CHECK=1 tag="%global_tagid%" > runspai-"%selected%"-"%global_installtype%".bat
	echo runspai-%selected%-%global_installtype%.bat created in %CD% as backup.
	echo.
) else if /i "%userInput%"=="N" (
	goto menu
) else (
	echo Invalid choice. Please enter Y or N.
	echo.
    	goto option2
)

goto menu




:option4
echo.
echo Turning off windows firewall..
netsh advfirewall set allprofiles state off
echo.
netsh advfirewall show allprofiles state
echo.
echo Opening force inventory URL http://127.0.0.1:62354/
start "" "http://127.0.0.1:62354/"
echo.
echo After setting up force inventory, press any key to enable firewall back.
pause
echo.
echo Turning on windows firewall..
netsh advfirewall set allprofiles state on
echo.
netsh advfirewall show allprofiles state
goto menu




:exit
exit