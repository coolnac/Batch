@ECHO OFF
	REM 2018-10-16 �{���޿��u��
::-------------------------------------------------------------
	SETLOCAL ENABLEDELAYEDEXPANSION
	SET today=%Date:~0,4%%Date:~5,2%%Date:~8,2%
	SET Log=D:\ChangeLog\UpdateLog-%today%.txt
	IF NOT EXIST "D:\ChangeLog" MKDIR "D:\ChangeLog"
	IF NOT EXIST "D:\update\%today%" MKDIR "D:\update\%today%"
::-------------------------------------------------------------	
ECHO �t�Χ�s��....
	CD /d "D:\update\%today%"
	SET StartTime=!today! !time!

:_BHU
REM �ˬd�O�_�ݧ�s Billhunter ��Ƨ�
IF EXIST ".\BillhunterUltimate" (
	ECHO ��s: D:\BillhunterUltimate
	
	REM �蹳��s Billhunter ��Ƨ�
	ROBOCOPY ".\BillhunterUltimate" "D:\BillhunterUltimate" /e >> %Log%
	
	REM ��sDLL���ɤ���
	IF EXIST ".\BillhunterUltimate\PlugIn\Customer_Dll\Trans\�d��.dll" (
		SET /A "icount=0"
		FOR /R "D:\BillhunterUltimate\PlugIn\Customer_Dll\Trans\" %%i IN (*.dll) DO (
			COPY ".\BillhunterUltimate\PlugIn\Customer_Dll\Trans\�d��.dll" "%%i" >> %Log%
			SET /A "icount+=1"
		)
		ECHO �@��s !icount! �� DLL �ɮ�^^!
		DEL /F /Q "D:\BillhunterUltimate\PlugIn\Customer_Dll\Trans\�d��.dll"
	)
	
	ECHO Billhunter ��s����^!
)

:_C
REM �ˬd�O�_�ݧ�s C ��
IF EXIST ".\C" (
	ECHO ��s: C:\
	
	REM �蹳��s C �Ѹ��
	ROBOCOPY ".\C" "C:\ " /e >> %Log%
	
	ECHO C �ѧ�s����^!
)

:END
	SET EndTime=!today! !time!
	ECHO --
	ECHO �}�l�ɶ�: %StartTime%
	ECHO �����ɶ�: %EndTime%
	ECHO Log Path: %Log%
	ECHO --	
	ENDLOCAL
	
	CHOICE /C QP /M "3 ���N�۰ʵ���...." /T 3 /D Q
		IF ERRORLEVEL 2 TIMEOUT -1
EXIT