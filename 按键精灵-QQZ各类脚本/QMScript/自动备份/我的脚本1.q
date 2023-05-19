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
Description=我的脚本1
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
//首先获取当前游戏句柄（这里通过游戏类名获取，也可以直接鼠标获取Plugin.Window.MousePoint）
Hwnd = Plugin.Window.Find("RCImageViewerFrame", 0) 
//创建大漠插件对象
set dm = createobject("dm.dmsoft")
//后台模式
dm_ret = dm.BindWindow(Hwnd, "dx2", "windows", "windows", 0)
//前台模式
//dm_ret = dm.BindWindowEx(Hwnd, "dx2", "normal", "normal", "", 0)



//注意要先设置使用的大漠字库
dm_ret = dm.SetDict(0, "D:\tools\qqz\shenyi.txt")
//然后找字成功就会返回intX、intY坐标
dm_ret = dm.FindStr(0, 0, 2000, 2000, "神医", "ff0000-000000", 0.9, intX, intY)
If dm_ret = 0 And intX >0 And intY >0 Then 
    TracePrint "神医坐标=" & intX & ":" & intY
End If

//注意要先设置文件保存路径
dm_ret = dm.SetPath("D:\temp\ZYHXCaptcha")
//验证码截图
dm_ret = dm.CaptureJpg(intX, intY + 60, intX + 160, intY + 170, "captcha.jpg", 100)
Delay 50
//答案选项截图
dm_ret = dm.CaptureJpg(intX+195, intY + 36, intX + 233, intY + 114, "answer.jpg", 65)
