[General]
SyntaxVersion=2
BeginHotkey=121
BeginHotkeyMod=0
PauseHotkey=0
PauseHotkeyMod=0
StopHotkey=123
StopHotkeyMod=0
RunOnce=1
EnableWindow=
MacroID=99b77105-df65-4218-aeee-b3c1e1adc1e2
Description=�ƴ���
Enable=1
AutoRun=0
[Repeat]
Type=0
Number=1
[SetupUI]
Type=2
QUI=
[Relative]
SetupOCXFile=
[Comment]

[Script]
//
// �ƴ��밴�����飨��ͨģʽ��ʾ��
// �����ѣѣ�4008588180
// �ٷ���վ��http://www.yundama.com
// 
//////////////////////////////////////////////////////////////////////////////

If Plugin.File.IsFileExit("plugin/yundama.dll") = false
    msgbox "�ƴ������ļ������ڣ������� yundama.dll ���� plugin �ļ��к��������иýű�", 16, "����"
    ExitScript
End If 

// ע����������ͨ��Ա�˺ţ����ǿ������˺ţ�ע���ַ http://www.yundama.com/index/reg/user
// �����߿�����ϵ�ͷ���ȡ��ѵ������

�ƴ����û� = "lianzhongt456 "						// ������ǰ�ȸ��ġ��ƴ����û���
�ƴ������� = "lianzhongt456"						// ������ǰ�ȸ��ġ��ƴ�������

//////////////////////////////////////////////////////////////////////////////

// 1. http://www.yundama.com/index/reg/developer ע�Ὺ�����˺�
// 2. http://www.yundama.com/developer/myapp ��������
// 3. ʹ����ӵ����ID����Կ���п��������ܷ��ֳ�

���ID = 8409										// ������ǰ�ȸ��ġ�����ɣģ������߷ֳɱ�Ҫ��������¼�����ߺ�̨���ҵ��������ã�
�����Կ = "bdbd6b159f4432739f07b63ab930ec7b"	// ������ǰ�ȸ��ġ������Կ�������߷ֳɱ�Ҫ��������¼�����ߺ�̨���ҵ��������ã�

//////////////////////////////////////////////////////////////////////////////

ͼƬ·�� = "D:\temp\captcha.jpg"						// ������ǰ�ȸ��ġ�ʶ��ͼƬ·��

// ����������ѯ http://www.yundama.com/apidoc/YDM_ErrorCode.html
������ʾ = chr(10) + chr(13) + chr(10) + chr(13) + ">>> ������뺬���ڴ˲�ѯ" + chr(10) + chr(13) + ">>> " + "http://www.yundama.com/apidoc/YDM_ErrorCode.html"

//////////////////////////////////////////////////////////////////////////////

��ʼ�ɹ� = Plugin.yundama.SetAppInfo(���ID, �����Կ)			// ��ʼ�ƴ��룬ֻ���ʼһ�μ���

��½���� = Plugin.yundama.Login(�ƴ����û�, �ƴ�������)			// ��½�ƴ��룬ֻ���½һ�μ���

If ��½���� > 0 Then 
	
	// ȡʣ����֣������ȡʣ����֣����Բ�����
	ʣ����� = Plugin.yundama.GetBalance(�ƴ����û�, �ƴ�������)

	// ����1004��ʾ4λ��ĸ���֣���ͬ�����շѲ�ͬ����׼ȷ��д������Ӱ��ʶ����
	// �ڴ˲�ѯ�������� http://www.yundama.com/price.html
	��֤������ = 1003
	
	// ����ʶ��ʱʱ�䣬��λ����
	��ʱʱ�� = 60

	// ��ʼʶ��ͼƬ
	ʶ���� = Plugin.yundama.DecodeByPath(ͼƬ·��, ��֤������, ��֤��ID)
	
	// �Ƿ�ʶ��ɹ�
	If ��֤��ID > 0 Then 

		�Ƿ���� = MsgBox("��ǰͼƬʶ����Ϊ��" + ʶ���� + chr(10) + chr(13) + "ʶ����ȷѡ�ǣ�����ѡ��", VbYesNo + VbInformation, "ʶ�����Ƿ���ȷ��")

		// ############# ��֤�뱨�� #############

		If �Ƿ���� = vbNo Then 
		
			// ��֤��ʶ���������ô˺������б����Ա㷵�����
			// ���ⱨ��ᵼ�¿������˺ű��������㣡
			
			������ = Plugin.yundama.Report(��֤��ID)
			
			If ������ = 0 Then 
				MsgBox "ͼƬʶ������Ѿ��ɹ�����", VbInformation
			Else 
				MsgBox "�㱨����ʧ�ܣ����ش��룺" + Cstr(������) + ������ʾ, VbCritical, "����ʧ��"
			End If
		Else 
			MsgBox "ͼƬʶ����ȷ������㱨����", VbInformation
		End If
		// ############# ��֤�뱨�� #############

	Else 
		MsgBox "ʶ��ʧ�ܣ�������룺" + Cstr(��֤��ID) + ������ʾ, VbCritical, "ʶ��ʧ��" 	// ����������ѯ http://www.yundama.com/apidoc/YDM_ErrorCode.html
	End If
	
Else

	MsgBox "��½ʧ�ܣ�������룺" + Cstr(��½����) + ������ʾ, VbCritical, "��½ʧ��"	// ����������ѯ http://www.yundama.com/apidoc/YDM_ErrorCode.html
	
End If

// ####################### �������� #######################

// �������溯��ǰ��Ҫ�ȳ�ʼ��
// ��ʼ�ɹ� = Plugin.yundama.SetAppInfo(���ID, �����Կ)

// ####################### ���ų�ֵ #######################

// �ƴ����û� = "testuser"
// �ƴ������� = "testpass"
// �ƴ��뿨�� = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
// ��ֵ���� = Plugin.yundama.Pay(�ƴ����û�, �ƴ�������, �ƴ��뿨��)	// ���� 0 �ɹ�

// ####################### ע���˺� #######################

// ע���û� = "testuser"
// ע������ = "testpass"
// ע������ = "test@qq.com"
// ע���ֻ� = "13000000000"
// ע��QQ = "10000"
// ע�᷵�� = Plugin.yundama.Reg(�ƴ����û�, �ƴ�������, ע������, ע���ֻ�, ע��QQ)	// ���� 0 �ɹ�

// #######################################################
