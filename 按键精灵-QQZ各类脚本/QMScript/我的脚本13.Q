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
MacroID=1bb78420-fbdc-4163-aef7-161d448ffc64
Description=获取窗口坐标
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
//Hwnd = Plugin.Window.MousePoint()
Hwnd = Plugin.Window.Find("RCImageViewerFrame", 0)
Rect = Plugin.Window.GetClientRect(Hwnd)
Dim MyArray
MyArray=Split(Rect,"|")
Ux = CLng(MyArray(0))
Uy = Clng(MyArray(1))
TracePrint Ux
TracePrint Uy
