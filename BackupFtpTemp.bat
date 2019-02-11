@ECHO OFF
	REM 2019-01-28 Initial Version
::----------------------------------------------------------------------------------------------
	SETLOCAL ENABLEDELAYEDEXPANSION
	SET "today=%Date:~0,4%%Date:~5,2%%Date:~8,2%"
	SET "tofolder=D:\backup\ftptemp\%today%"
	SET "log=D:\ChangeLog\BackupFtpTemp-%today%.log"
	SET "ftptemp=D:\BillhunterUltimate\ftptemp"
	SET "StartTime=!time!"
::----------------------------------------------------------------------------------------------
	IF NOT EXIST "D:\ChangeLog" MKDIR "D:\ChangeLog"
	
	IF NOT EXIST "%ftptemp%" (
	GOTO FINISH
	) ELSE (
	>>%log% ECHO %StartTime% 開始備份 %ftptemp% 到 %tofolder%
	:: /NJH 無標題 ; /NJS 無摘要 ; /NS 無大小 ; /NC 無類型 ; /NP 無進度 ; /MOV 移動檔案並從來源端刪除 ; /MINAGE 排除指定天數後的檔案
	ROBOCOPY "%ftptemp%" "%tofolder%" /mir /mt:80 /NJH /NJS /NS /NC /NP /MOV /MINAGE:1 >> %log%
	)

:FINISH
	IF NOT EXIST "%tofolder%" ECHO 未做任何備份，程式即將結束。>>%log% & EXIT

	attrib -s -a -h %tofolder% >> %log%
	SET "EndTime=!time!"
	>>%log% ECHO %EndTime% 備份完成。

ENDLOCAL
CHOICE /C QP /M "3 秒後自動結束...." /T 3 /D Q
	IF ERRORLEVEL 2 TEIMEOUT -1
EXIT