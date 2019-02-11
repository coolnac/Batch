@echo off
set tmp=D:\schedule\temp.txt
cd "C:\Program Files\CA\AccessControl\bin"
FOR /F "tokens=*" %%i IN ('acpwd -get -account "MAGW_FTP" -ep "AD" -eptype "Windows Agentless" -container "Accounts" -nologo') DO (
	set pwd=%%i
)
echo open 10.88.21.18 > %tmp%
echo MAGW_FTP >> %tmp%
echo %pwd% >> %tmp%
echo prompt >> %tmp%
echo cd WMS_FTP >> %tmp%
echo cd DOWNLOAD >> %tmp%
echo cd MAGW >> %tmp%
echo ls >> %tmp%
echo bye >> %tmp%

ftp -s:%tmp%
del /f /q %tmp%
pause