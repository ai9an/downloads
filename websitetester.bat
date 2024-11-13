@echo off & Setlocal
title WebTest 

:VBSDynamicBuild
SET TempVBSFile=%temp%\~tmpSendKeysTemp.vbs
IF EXIST "%TempVBSFile%" DEL /F /Q "%TempVBSFile%"
ECHO Set WshShell = WScript.CreateObject("WScript.Shell") >>"%TempVBSFile%"
ECHO Wscript.Sleep 100                                    >>"%TempVBSFile%"
ECHO WshShell.SendKeys "{F11}"                            >>"%TempVBSFile%
ECHO Wscript.Sleep 100                                   >>"%TempVBSFile%"

CSCRIPT //nologo "%TempVBSFile%"

setlocal EnableDelayedExpansion

:: Made by https://www.tiktok.com/rad @RAD @RADWR

:intro
cls
type c:\Users\UKGC\Desktop\websitetester.txt
echo Welcome to the Website Tester tool. Press any button to begin @RAD
pause >nul
goto menu

:menu
color 0F
 cls
set /p website="Enter the website URL: "
 ping localhost -n 1 >nul
 IF "%website%"=="" goto nothing
 goto ping
 
 :nothing
 cls
 color 04
  ping localhost -n 2 >nul
 echo Operation failed.
 echo.
 ping localhost -n 1.5 >nul
 echo You did not type anything in the prompt or you have entered a sub-domain.
 set /p help=""
 if %help%==y goto help
  if %help%==yes goto help
	ELSE
	goto menu
	
 
::pinging the server
 :ping
 cls
 echo Testing this website to make sure it exists.
set ip=%website%
ping -n 1 %ip% | find "TTL" >nul
if not errorlevel 1 set error=win >nul
if errorlevel 1 set error=fail >nul
 ping localhost -n 2 >nul
if %error%==fail goto fail
if %error%==win goto worked



 :worked
 color 02
 ping localhost -n 1 >nul
 echo.
  echo This website does exist and is working at the time of %time% on %date%.
  echo 1. Goto Main Menu
 echo 2. Keep pinging this website
 echo 3. View source code.
 set /p restart=""
  if %restart%==2 goto pingcooldown
 if %restart%==1 goto menu
  if %restart%==3 goto code

 :fail
 color 04
 cls
  echo This website does not exist or is not working at the time of %time% on %date%.
  echo.
  echo This website does not exist. 
 ping localhost -n 1.5 >nul
 echo.
 echo 1. Goto Main Menu
 echo 2. Keep pinging this website
 echo 3. View source code.
 set /p restart=""
  if %restart%==2 goto pingcooldown
 if %restart%==1 goto menu
  if %restart%==3 goto code
  
  :code
  cls
  color 01
  type c:\Users\UKGC\Desktop\code.txt
  echo Press any button to go to main menu.
  pause >nul
  goto menu
  
  :pingcooldown
  cls
  color 0F
  echo Set a delay for your pings in seconds.
  set /p cooldown=""
  ping localhost -n 1.5 >nul
  cls
  echo Cooldown successfully set to %cooldown%
   ping localhost -n 1 >nul
   echo Would you like your pings to show? (y/n)
set /p pingshow="" 
cls
echo Cooldown successfully set to %cooldown%
if %pingshow%==n set show=nul
if %pingshow%==y set show= 
if %pingshow%==n set showing=not showing
if %pingshow%==n set symbol=^>
if %pingshow%==y set showing=
if %pingshow%==y set showing=showing
echo Showing pings successfully set to %showing%
ping localhost -n 2 >nul
cls
  goto pingrepeat
  
  :pingrepeat
  ping -n %cooldown% %ip% | find "TTL" %symbol% %show%
if not errorlevel 1 set error=Online >nul
if errorlevel 1 set error=Offline >nul
if not errorlevel 1 color 02
if errorlevel 1 color 04
 echo %error%
 goto pingrepeat