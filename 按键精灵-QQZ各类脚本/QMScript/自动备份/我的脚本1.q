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
MacroID=a287412b-1f93-4905-ba11-a5e05b6a1cc1
Description=�ҵĽű�1
Enable=1
AutoRun=0
[Repeat]
Type=0
Number=1
[SetupUI]
Type=1
QUI=Form1
[Relative]
SetupOCXFile=
[Comment]

[Script]
//���Ȼ�ȡ��ǰ��Ϸ���������ͨ����Ϸ������ȡ��Ҳ����ֱ������ȡPlugin.Window.MousePoint��
Hwnd = Plugin.Window.Find("RCImageViewerFrame", 0) 
//������Į�������
set dm = createobject("dm.dmsoft")
//��̨ģʽ
dm_ret = dm.BindWindow(Hwnd, "dx2", "windows", "windows", 0)
//ǰ̨ģʽ
//dm_ret = dm.BindWindowEx(Hwnd, "dx2", "normal", "normal", "", 0)



//ע��Ҫ������ʹ�õĴ�Į�ֿ�
dm_ret = dm.SetDict(0, "D:\tools\qqz\shenyi.txt")
//Ȼ�����ֳɹ��ͻ᷵��intX��intY����
dm_ret = dm.FindStr(0, 0, 2000, 2000, "��ҽ", "ff0000-000000", 0.9, intX, intY)
If dm_ret = 0 And intX >0 And intY >0 Then 
    TracePrint "��ҽ����=" & intX & ":" & intY
End If

//ע��Ҫ�������ļ�����·��
dm_ret = dm.SetPath("D:\temp\ZYHXCaptcha")
//��֤���ͼ
dm_ret = dm.CaptureJpg(intX, intY + 60, intX + 160, intY + 170, "captcha.jpg", 100)
Delay 50
//��ѡ���ͼ
dm_ret = dm.CaptureJpg(intX+195, intY + 36, intX + 233, intY + 114, "answer.jpg", 65)
