@ECHO OFF
	REM 2018-06-20 取消相對路徑執行,改回原先絕對路徑方式 (D:\update\yyyyMMdd)
	REM 2018-08-23 新增AGPL元件移除工具
	REM 2018-10-16 刪除AGPL元件移除工具,調整系統更新工具

:_MENU
	SET today=%Date:~0,4%%Date:~5,2%%Date:~8,2%
	IF NOT EXIST "D:\update\%today%" MKDIR "D:\update\%today%"
	CD /d "D:\update\%today%"
	CLS

::選單文字設計::
	ECHO A 清除.dm資料夾+解除檔案唯讀
	ECHO B 停止BHU服務
	ECHO C 系統備份
	ECHO D 系統更新
	ECHO E 啟動BHU服務
	ECHO F 專案驗證
	ECHO Q 離開 

::選單功能對應::
CHOICE /C ABCDEFQ /M "Choose an Option"
	IF ERRORLEVEL 7 GOTO ACT_Q
	IF ERRORLEVEL 6 GOTO ACT_CHK
	IF ERRORLEVEL 5 GOTO ACT_NSTART
	IF ERRORLEVEL 4 GOTO ACT_UPDT
	IF ERRORLEVEL 3 GOTO ACT_BAK
	IF ERRORLEVEL 2 GOTO ACT_NSTOP

:ACT_DM
	ECHO 清除.dm資料夾....
	FOR /R ".\" %%i IN (.dm) DO IF EXIST "%%i" RD "%%i" /q /s
	
	ECHO 解除檔案唯讀屬性....
	ATTRIB -R -S -H .\*.* /S /D
	
	ECHO 完成^!
	TIMEOUT 1 > NUL & GOTO _MENU
	
:ACT_NSTOP
	ECHO 停止BHU服務....
	START /WAIT D:\schedule\netstop.bat
	ECHO 完成^!
	TIMEOUT 1 > NUL & GOTO _MENU
	
:ACT_BAK
	ECHO 系統備份中....
	START /WAIT D:\schedule\BHU自動備份工具.bat
	ECHO 完成^!
	TIMEOUT 1 > NUL & GOTO _MENU
	
:ACT_UPDT
	ECHO 系統更新中....
	START /WAIT D:\schedule\BHU自動更新工具.bat
	ECHO 完成^!
	TIMEOUT -1 & GOTO _MENU

:ACT_NSTART
	ECHO 啟動BHU服務....
	START /WAIT D:\schedule\netstart.bat
	ECHO 完成^!
	TIMEOUT 1 > NUL & GOTO _MENU
	
:ACT_CHK
	ECHO 開始專案驗證....
	START /WAIT D:\schedule\SendMail.exe
	ECHO 完成^!
	TIMEOUT 1 > NUL & GOTO _MENU
	
:ACT_Q
	EXIT
	
::以下功能暫無使用::
::-----------------------------------------------------::
:ACT_DLL
	ECHO 新增DLL....
	START /WAIT D:\schedule\Copydll.bat
	ECHO 完成^!
	TIMEOUT 1 > NUL & GOTO _MENU
::-----------------------------------------------------::