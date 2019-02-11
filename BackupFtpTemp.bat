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
	>>%log% ECHO %StartTime% �}�l�ƥ� %ftptemp% �� %tofolder%
	:: /NJH �L���D ; /NJS �L�K�n ; /NS �L�j�p ; /NC �L���� ; /NP �L�i�� ; /MOV �����ɮרñq�ӷ��ݧR�� ; /MINAGE �ư����w�Ѽƫ᪺�ɮ�
	ROBOCOPY "%ftptemp%" "%tofolder%" /mir /mt:80 /NJH /NJS /NS /NC /NP /MOV /MINAGE:1 >> %log%
	)

:FINISH
	IF NOT EXIST "%tofolder%" ECHO ��������ƥ��A�{���Y�N�����C>>%log% & EXIT

	attrib -s -a -h %tofolder% >> %log%
	SET "EndTime=!time!"
	>>%log% ECHO %EndTime% �ƥ������C

ENDLOCAL
CHOICE /C QP /M "3 ���۰ʵ���...." /T 3 /D Q
	IF ERRORLEVEL 2 TEIMEOUT -1
EXIT