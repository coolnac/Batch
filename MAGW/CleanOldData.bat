@ECHO OFF
	REM 2018-10-30 Initial Version
::----------------------------------------------------------------------------------------------
	SETLOCAL ENABLEDELAYEDEXPANSION
	SET "today=%Date:~0,4%%Date:~5,2%%Date:~8,2%"
	SET "log=D:\ChangeLog\HousekeepingLog-%today%.log"
	SET "logfile_01=D:\ChangeLog"
	SET "logfile_02=D:\MonitorLog"
	SET "logfile_03=D:\update"
	SET "logfile_04=D:\backup"
	SET "zipfile_01=D:\BillhunterUltimate\DecodeFolder"
	SET "ZipFile_Keep_Day=90"
	SET "LogFile_Keep_Day=90"
::----------------------------------------------------------------------------------------------
	IF NOT EXIST "D:\ChangeLog" MKDIR "D:\ChangeLog"
	ECHO 開始清理過期資料，ZIP 保存期限 %ZipFile_Keep_Day% 天，LOG 保存期限 %LogFile_Keep_Day% 天
	>>%log% ECHO !time! 清理過期資料開始
	>>%log% ECHO !time! LogFile_Keep_Day=%LogFile_Keep_Day%，ZipFile_Keep_Day=%ZipFile_Keep_Day%

	IF EXIST "%logfile_01%" (
		ECHO 清理過期維護Log: %logfile_01%
		:: /D days ; /P path ; /S 遞迴 ; /M 搜尋條件 ; /C command
		FORFILES /D -%LogFile_Keep_Day% /P %logfile_01% /S /M *.* /C "cmd /c >>%log% ECHO !time! 刪除檔案 @path & DEL /Q /S ^"@path^" >NUL 2>&1"
	)
	
	IF EXIST "%logfile_02%" (
		ECHO 清理過期監控Log: %logfile_02%
		:: /D days ; /P path ; /S 遞迴 ; /M 搜尋條件 ; /C command
		FORFILES /D -%LogFile_Keep_Day% /P %logfile_02% /S /M *.* /C "cmd /c >>%log% ECHO !time! 刪除檔案 @path & DEL /Q /S ^"@path^" >NUL 2>&1"
	)
	
	IF EXIST "%zipfile_01%" (
		ECHO 清理過期轉檔資料: %zipfile_01%
		:: /D days ; /P path ; /S 遞迴 ; /M 搜尋條件 ; /C command
		FORFILES /D -%ZipFile_Keep_Day% /P %zipfile_01% /S /M *.* /C "cmd /c >>%log% ECHO !time! 刪除過期轉檔資料 @path & DEL /Q /S ^"@path^" >NUL 2>&1"
	)
	
	IF EXIST "%logfile_03%" (
		ECHO 清理過期更新檔: %logfile_03%
		>>%log% ECHO !time! 刪除過期更新檔 %logfile_03%
		:: /MINAGE 排除指定天數後的檔案 ; /E 包含空的子目錄 ; /MOVE 複製後刪除 ; /NJH 無標題 ; /NJS 無摘要 ; /NS 無大小 ; /NC 無類型 ; /NP 無進度
		ROBOCOPY %logfile_03% D:\del_tmp /MINAGE:%LogFile_Keep_Day% /E /MOVE /NJH /NJS /NS /NC /NP >>%log%
	)
	
	IF EXIST "%logfile_04%" (
		ECHO 清理過期備份檔: %logfile_04%
		>>%log% ECHO !time! 刪除過期備份檔 %logfile_04%
		:: /MINAGE 排除指定天數後的檔案 ; /E 包含空的子目錄 ; /MOVE 複製後刪除 ; /NJH 無標題 ; /NJS 無摘要 ; /NS 無大小 ; /NC 無類型 ; /NP 無進度
		ROBOCOPY %logfile_04% D:\del_tmp /MINAGE:%LogFile_Keep_Day% /E /MOVE /NJH /NJS /NS /NC /NP >>%log%
	)		
	
	IF EXIST "D:\del_tmp" (
		RMDIR /Q /S "D:\del_tmp" >NUL 2>&1
	)

CHOICE /C QP /M "3 秒後自動結束...." /T 3 /D Q
	IF ERRORLEVEL 2 TIMEOUT -1
EXIT