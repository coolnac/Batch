@ECHO OFF
	SET /A "now=0"
	SET "total=13"

:MAGW_AP
	ECHO STEP 1 - ����ʱ��A�ȡG�@ 1 ��
	NET STOP "MonitoringJob"
	
	ECHO STEP 2 - ����BHU�t�ΪA�ȡG�@ %total% ��
	
	SET /A "now+=1"
	ECHO (%now%/%total%)
	NET STOP "EasyUse BHUltimate AppGetAll Service"

	SET /A "now+=1"
	ECHO (%now%/%total%)
	NET STOP "EasyUse BHUltimate AppToReceiver Service"

	SET /A "now+=1"
	ECHO (%now%/%total%)
	NET STOP "EasyUse BHUltimate CMD Scheduler Service"

	SET /A "now+=1"
	ECHO (%now%/%total%)
	NET STOP "EasyUse BHUltimate Dispatcher Service"

	SET /A "now+=1"
	ECHO (%now%/%total%)
	NET STOP "EasyUse BHUltimate Encoder Service"

	SET /A "now+=1"
	ECHO (%now%/%total%)
	NET STOP "EasyUse BHUltimate EncoderToApp Service"

	SET /A "now+=1"
	ECHO (%now%/%total%)
	NET STOP "EasyUse BHUltimate EncoderToSender Service"

	SET /A "now+=1"
	ECHO (%now%/%total%)
	NET STOP "EasyUse BHUltimate MainTrans Service"

	SET /A "now+=1"
	ECHO (%now%/%total%)
	NET STOP "EasyUse BHUltimate ProjectClose Service"

	SET /A "now+=1"
	ECHO (%now%/%total%)
	NET STOP "EasyUse BHUltimate ProjectTrigger Service"

	SET /A "now+=1"
	ECHO (%now%/%total%)
	NET STOP "EasyUse BHUltimate Reissue Service"

	SET /A "now+=1"
	ECHO (%now%/%total%)
	NET STOP "EasyUse BHUltimate SendNow Service"

	SET /A "now+=1"
	ECHO (%now%/%total%)
	NET STOP "EasyUse BHUltimate Socket Service"
::--------------------------------------------------
:END
CHOICE /C QP /M "3���N�۰ʵ���....(P)����" /T 3 /D Q
	IF ERRORLEVEL 2 TIMEOUT -1
EXIT