@echo off
setlocal EnableDelayedExpansion
set today=%Date:~0,4%%Date:~5,2%%Date:~8,2%
set folder=D:\backup\%today%
set log=D:\ChangeLog\BackupSystemLog-%today%.txt
set BHU=BillhunterUltimate
set StartTime=!today! !time!
echo ------------------------------------------------
echo *  Billhunter自動備份工具
echo *
echo *  檔案將備份至 %folder%
echo ------------------------------------------------
timeout 3 & echo.
echo 開始備份作業....

if not exist "D:\ChangeLog" mkdir "D:\ChangeLog"
if exist "%log%" del %log% /Q

:obank_ftp
if not exist "C:\obank_ftp.xml" (
goto BHSetting
) else (
echo backup: C:\obank_ftp.xml 
robocopy "C:\ "  "%folder%\C" /if "obank_ftp.xml" >> %log%
echo done.
)

:BHSetting
if not exist "C:\BHSetting.xml" (
goto BHSetting
) else (
echo.
echo backup: C:\BHSetting.xml 
robocopy "C:\ "  "%folder%\C" /if "BHSetting.xml" >> %log%
echo done.
)

:EasyUse
if not exist "C:\Program Files (x86)\EasyUse" (
goto BHU
) else (
echo.
echo backup: C:\Program Files ^(x86^)
robocopy "C:\Program Files (x86)\EasyUse" "%folder%\C\Program Files (x86)\EasyUse" /mir /mt:80 >> %log% 
echo done.
)

:BHU
if not exist "D:\%BHU%" (
goto finish
) else (
echo.
echo backup: D:\%BHU% 
robocopy "D:\%BHU%" "%folder%\%BHU%" /xd "D:\%BHU%\DecodeFolder" "D:\%BHU%\EmlStorage" "D:\%BHU%\log" /mir /mt:80 >> %log% 
echo done.
)

:finish
if not exist "%folder%" (
echo 未做任何備份. 程式即將結束!
timeout 3
exit
) else (
attrib -s -a -h %folder% >> %log%
attrib -s -a -h %folder%\C >> %log%
attrib -s -a -h %folder%\BillhunterUltimate >> %log%
echo 備份完成!
)
set EndTime=!today! !time! & timeout 1 > nul
echo --&echo StartTime: %StartTime% & echo EndTime  : %EndTime% & echo --
endlocal
choice /C QP /M "3秒後將自動(Q)結束....(P)等待" /T 3 /D Q
	if errorlevel 2 timeout -1
exit