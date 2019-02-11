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
	ECHO �}�l�M�z�L����ơAZIP �O�s���� %ZipFile_Keep_Day% �ѡALOG �O�s���� %LogFile_Keep_Day% ��
	>>%log% ECHO !time! �M�z�L����ƶ}�l
	>>%log% ECHO !time! LogFile_Keep_Day=%LogFile_Keep_Day%�AZipFile_Keep_Day=%ZipFile_Keep_Day%

	IF EXIST "%logfile_01%" (
		ECHO �M�z�L�����@Log: %logfile_01%
		:: /D days ; /P path ; /S ���j ; /M �j�M���� ; /C command
		FORFILES /D -%LogFile_Keep_Day% /P %logfile_01% /S /M *.* /C "cmd /c >>%log% ECHO !time! �R���ɮ� @path & DEL /Q /S ^"@path^" >NUL 2>&1"
	)
	
	IF EXIST "%logfile_02%" (
		ECHO �M�z�L���ʱ�Log: %logfile_02%
		:: /D days ; /P path ; /S ���j ; /M �j�M���� ; /C command
		FORFILES /D -%LogFile_Keep_Day% /P %logfile_02% /S /M *.* /C "cmd /c >>%log% ECHO !time! �R���ɮ� @path & DEL /Q /S ^"@path^" >NUL 2>&1"
	)
	
	IF EXIST "%zipfile_01%" (
		ECHO �M�z�L�����ɸ��: %zipfile_01%
		:: /D days ; /P path ; /S ���j ; /M �j�M���� ; /C command
		FORFILES /D -%ZipFile_Keep_Day% /P %zipfile_01% /S /M *.* /C "cmd /c >>%log% ECHO !time! �R���L�����ɸ�� @path & DEL /Q /S ^"@path^" >NUL 2>&1"
	)
	
	IF EXIST "%logfile_03%" (
		ECHO �M�z�L����s��: %logfile_03%
		>>%log% ECHO !time! �R���L����s�� %logfile_03%
		:: /MINAGE �ư����w�Ѽƫ᪺�ɮ� ; /E �]�t�Ū��l�ؿ� ; /MOVE �ƻs��R�� ; /NJH �L���D ; /NJS �L�K�n ; /NS �L�j�p ; /NC �L���� ; /NP �L�i��
		ROBOCOPY %logfile_03% D:\del_tmp /MINAGE:%LogFile_Keep_Day% /E /MOVE /NJH /NJS /NS /NC /NP >>%log%
	)
	
	IF EXIST "%logfile_04%" (
		ECHO �M�z�L���ƥ���: %logfile_04%
		>>%log% ECHO !time! �R���L���ƥ��� %logfile_04%
		:: /MINAGE �ư����w�Ѽƫ᪺�ɮ� ; /E �]�t�Ū��l�ؿ� ; /MOVE �ƻs��R�� ; /NJH �L���D ; /NJS �L�K�n ; /NS �L�j�p ; /NC �L���� ; /NP �L�i��
		ROBOCOPY %logfile_04% D:\del_tmp /MINAGE:%LogFile_Keep_Day% /E /MOVE /NJH /NJS /NS /NC /NP >>%log%
	)		
	
	IF EXIST "D:\del_tmp" (
		RMDIR /Q /S "D:\del_tmp" >NUL 2>&1
	)

CHOICE /C QP /M "3 ���۰ʵ���...." /T 3 /D Q
	IF ERRORLEVEL 2 TIMEOUT -1
EXIT