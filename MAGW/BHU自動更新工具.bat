@ECHO OFF
	REM 2018-10-16 程式邏輯優化
::-------------------------------------------------------------
	SETLOCAL ENABLEDELAYEDEXPANSION
	SET today=%Date:~0,4%%Date:~5,2%%Date:~8,2%
	SET Log=D:\ChangeLog\UpdateLog-%today%.txt
	IF NOT EXIST "D:\ChangeLog" MKDIR "D:\ChangeLog"
	IF NOT EXIST "D:\update\%today%" MKDIR "D:\update\%today%"
::-------------------------------------------------------------	
ECHO 系統更新中....
	CD /d "D:\update\%today%"
	SET StartTime=!today! !time!

:_BHU
REM 檢查是否需更新 Billhunter 資料夾
IF EXIST ".\BillhunterUltimate" (
	ECHO 更新: D:\BillhunterUltimate
	
	REM 鏡像更新 Billhunter 資料夾
	ROBOCOPY ".\BillhunterUltimate" "D:\BillhunterUltimate" /e >> %Log%
	
	REM 更新DLL轉檔元件
	IF EXIST ".\BillhunterUltimate\PlugIn\Customer_Dll\Trans\範本.dll" (
		SET /A "icount=0"
		FOR /R "D:\BillhunterUltimate\PlugIn\Customer_Dll\Trans\" %%i IN (*.dll) DO (
			COPY ".\BillhunterUltimate\PlugIn\Customer_Dll\Trans\範本.dll" "%%i" >> %Log%
			SET /A "icount+=1"
		)
		ECHO 共更新 !icount! 筆 DLL 檔案^^!
		DEL /F /Q "D:\BillhunterUltimate\PlugIn\Customer_Dll\Trans\範本.dll"
	)
	
	ECHO Billhunter 更新完成^!
)

:_C
REM 檢查是否需更新 C 槽
IF EXIST ".\C" (
	ECHO 更新: C:\
	
	REM 鏡像更新 C 槽資料
	ROBOCOPY ".\C" "C:\ " /e >> %Log%
	
	ECHO C 槽更新完成^!
)

:END
	SET EndTime=!today! !time!
	ECHO --
	ECHO 開始時間: %StartTime%
	ECHO 結束時間: %EndTime%
	ECHO Log Path: %Log%
	ECHO --	
	ENDLOCAL
	
	CHOICE /C QP /M "3 秒後將自動結束...." /T 3 /D Q
		IF ERRORLEVEL 2 TIMEOUT -1
EXIT