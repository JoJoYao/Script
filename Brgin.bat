@echo off   
title ADB Install  Apks or uninstall or clear cleanmaster
goto BEGIN  

pause  
:BEGIN  
echo.  
echo ------------------------------------------  
echo        1.New Install(single)  ------Please Keyin(1) 
echo.  
echo        2.Cover install(single)------Please Keyin(2) 
echo. 
echo        3.Uninstall            ------Please Keyin(3)  
echo.  
echo        4.New Install(Multi)   ------Please Keyin(4)
echo.   
echo        5.Uninstall(Multi)     ------Please Keyin(5)
echo.    
echo        6.anr log              ------Please Keyin(6)
echo.  
echo        7.Logcat               ------Please Keyin(7) 
echo. 
echo        8.EXIT                 ------Please Keyin(8) 
echo. 
echo        0.Open BD CMlog        ------Please Keyin(0) 
echo ------------------------------------------ 
goto MAIN  
:MAIN  
choice /c 123456780 /M "Please Keyin:" 
if errorlevel 8 goto end
if errorlevel 7 goto logcat
if errorlevel 6 goto ANR
if errorlevel 5 goto multiuninstall
if errorlevel 4 goto multieinstall
if errorlevel 3 goto uninstall
if errorlevel 2 goto ReinstallAPK
if errorlevel 1 goto installAPK
if errorlevel 0 goto openlog

:installAPK
rem set work_path=d:\ftpapk1
rem cd /d %work_path% 
FOR %%i IN (*.apk) DO ( 
 	adb install "%%i"
	break;
 	) 
echo ----------------  Install complete!   ---------------  
goto BEGIN 
 
:ReinstallAPK
FOR %%i IN (*.apk) DO ( 
 	adb install -r "%%i"
	break;
 	) 
echo ----------------  Reinstall complete!   ---------------  
goto BEGIN 

:multieinstall
adb devices > devices.txt
set num=-1
for /f "usebackq" %%b in (devices.txt) do set /a linenum+=1
echo Devices: %num%
for /f "skip=1" %%i in (devices.txt) do start cmd /c install.cmd %%i )

echo ----------------  Install complete!   ---------------  
goto BEGIN

:multiuninstall
adb devices > devices.txt
set num=-1
for /f "usebackq" %%b in (devices.txt) do set /a linenum+=1
echo Devices: %num%
for /f "skip=1" %%i in (devices.txt) do start cmd /c uninstall.cmd %%i )

echo ----------------  uninstall complete!   ---------------  
goto BEGIN

:uninstall   
adb uninstall com.ijinshan.kbatterydoctor_en
goto BEGIN 

:ANR 
echo Get anr log   
echo 路徑：%cd%
adb pull /data/anr/traces.txt %cd% 
goto BEGIN 

:logcat 
echo Get crash log  
echo 路徑：%~dp0 
adb logcat -v threadtime > %~dp0/logcat.txt  
goto BEGIN 

:openlog
echo Open BD CMlog
adb shell setprop log.tag.CMLog VERBOSE
goto BEGIN

:end 
echo.  
pause  