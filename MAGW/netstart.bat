@ECHO OFF
	SET /A "now=0"
	SET "total=13"

:MAGW_AP
	ECHO STEP 1 - ����IIS
	IISRESET
	
	ECHO STEP 2 - �Ұ�BHU�t�ΪA�ȡG�@ %total% ��
	
	SET /A "now+=1"
	ECHO (%now%/%total%)
	NET START "EasyUse BHUltimate AppGetAll Service"

	SET /A "now+=1"
	ECHO (%now%/%total%)
	NET START "EasyUse BHUltimate AppToReceiver Service"

	SET /A "now+=1"
	ECHO (%now%/%total%)
	NET START "EasyUse BHUltimate CMD Scheduler Service"

	SET /A "now+=1"
	ECHO (%now%/%total%)
	NET START "EasyUse BHUltimate Dispatcher Service"

	SET /A "now+=1"
	ECHO (%now%/%total%)
	NET START "EasyUse BHUltimate Encoder Service"

	SET /A "now+=1"
	ECHO (%now%/%total%)
	NET START "EasyUse BHUltimate EncoderToApp Service"

	SET /A "now+=1"
	ECHO (%now%/%total%)
	NET START "EasyUse BHUltimate EncoderToSender Service"

	SET /A "now+=1"
	ECHO (%now%/%total%)
	NET START "EasyUse BHUltimate MainTrans Service"

	SET /A "now+=1"
	ECHO (%now%/%total%)
	NET START "EasyUse BHUltimate ProjectClose Service"

	SET /A "now+=1"
	ECHO (%now%/%total%)
	NET START "EasyUse BHUltimate ProjectTrigger Service"

	SET /A "now+=1"
	ECHO (%now%/%total%)
	NET START "EasyUse BHUltimate Reissue Service"

	SET /A "now+=1"
	ECHO (%now%/%total%)
	NET START "EasyUse BHUltimate SendNow Service"

	SET /A "now+=1"
	ECHO (%now%/%total%)
	NET START "EasyUse BHUltimate Socket Service"
::--------------------------------------------------
:END
	ECHO STEP 3 - �Ұʺʱ��A�ȡG�@ 1 ��
	NET START "MonitoringJob"
	CHOICE /C QP /M "3���N�۰ʵ���....����" /T 3 /D Q
		IF ERRORLEVEL 2 TIMEOUT -1
EXIT