@ECHO OFF
	REM 2018-06-20 �����۹���|����,��^���������|�覡 (D:\update\yyyyMMdd)
	REM 2018-08-23 �s�WAGPL���󲾰��u��
	REM 2018-10-16 �R��AGPL���󲾰��u��,�վ�t�Χ�s�u��

:_MENU
	SET today=%Date:~0,4%%Date:~5,2%%Date:~8,2%
	IF NOT EXIST "D:\update\%today%" MKDIR "D:\update\%today%"
	CD /d "D:\update\%today%"
	CLS

::����r�]�p::
	ECHO A �M��.dm��Ƨ�+�Ѱ��ɮװ�Ū
	ECHO B ����BHU�A��
	ECHO C �t�γƥ�
	ECHO D �t�Χ�s
	ECHO E �Ұ�BHU�A��
	ECHO F �M������
	ECHO Q ���} 

::���\�����::
CHOICE /C ABCDEFQ /M "Choose an Option"
	IF ERRORLEVEL 7 GOTO ACT_Q
	IF ERRORLEVEL 6 GOTO ACT_CHK
	IF ERRORLEVEL 5 GOTO ACT_NSTART
	IF ERRORLEVEL 4 GOTO ACT_UPDT
	IF ERRORLEVEL 3 GOTO ACT_BAK
	IF ERRORLEVEL 2 GOTO ACT_NSTOP

:ACT_DM
	ECHO �M��.dm��Ƨ�....
	FOR /R ".\" %%i IN (.dm) DO IF EXIST "%%i" RD "%%i" /q /s
	
	ECHO �Ѱ��ɮװ�Ū�ݩ�....
	ATTRIB -R -S -H .\*.* /S /D
	
	ECHO ����^!
	TIMEOUT 1 > NUL & GOTO _MENU
	
:ACT_NSTOP
	ECHO ����BHU�A��....
	START /WAIT D:\schedule\netstop.bat
	ECHO ����^!
	TIMEOUT 1 > NUL & GOTO _MENU
	
:ACT_BAK
	ECHO �t�γƥ���....
	START /WAIT D:\schedule\BHU�۰ʳƥ��u��.bat
	ECHO ����^!
	TIMEOUT 1 > NUL & GOTO _MENU
	
:ACT_UPDT
	ECHO �t�Χ�s��....
	START /WAIT D:\schedule\BHU�۰ʧ�s�u��.bat
	ECHO ����^!
	TIMEOUT -1 & GOTO _MENU

:ACT_NSTART
	ECHO �Ұ�BHU�A��....
	START /WAIT D:\schedule\netstart.bat
	ECHO ����^!
	TIMEOUT 1 > NUL & GOTO _MENU
	
:ACT_CHK
	ECHO �}�l�M������....
	START /WAIT D:\schedule\SendMail.exe
	ECHO ����^!
	TIMEOUT 1 > NUL & GOTO _MENU
	
:ACT_Q
	EXIT
	
::�H�U�\��ȵL�ϥ�::
::-----------------------------------------------------::
:ACT_DLL
	ECHO �s�WDLL....
	START /WAIT D:\schedule\Copydll.bat
	ECHO ����^!
	TIMEOUT 1 > NUL & GOTO _MENU
::-----------------------------------------------------::