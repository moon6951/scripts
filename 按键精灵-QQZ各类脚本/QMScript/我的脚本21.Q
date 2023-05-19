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
MacroID=d75a13de-b22b-4566-8b85-74718aa657cf
Description=自由幻想血黄自动吃药（需窗口置顶）
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
 

// 这个need_ver作为本脚本需要使用的插件版本. 如果要换插件时，记得更改这个值.

need_ver = "3.1233"

 

// 插件需要用到atl系统库,有些XP精简系统会把atl.dll精简掉. 为了防止注册失败，这里手动注册一下atl.dll

set ws=createobject("Wscript.Shell")
ws.run "regsvr32 atl.dll /s"
set ws=nothing

// 释放附件>>>>>>>>>>>>>>>>>>>

// 这里选择c盘的test-_game作为插件的基本目录 也就是SetPath对应的目录。所以所有资源都释放在此目录.

PutAttachment "d:\test_game","*.*"

// 这里要用到RegDll来注册插件，所以必须释放到Plugin. 但是切记不能把dm.dll释放到Plugin.那会导致插件失效.

PutAttachment ".\Plugin" ,"RegDll.dll"

 

// 插件注册开始>>>>>>>>>>>>>>>>>>>

// 下面开始注册插件,先尝试用RegDll来注册.这里必须使用绝对路径。以免有别人把dm.dll释放在系统目录.造成版本错误.

Call Plugin.RegDll.Reg("d:\test_game\dm.dll") 

 

// 这里判断是否注册成功

set dm = createobject("dm.dmsoft")

ver = dm.Ver()

if ver <> need_ver then

// 先释放先前创建的dm

set dm = nothing

   // 再尝试用regsvr32 来注册. 这里必须使用绝对路径。以免有别人把dm.dll释放在系统目录.造成版本错误.

set ws=createobject("Wscript.Shell")
ws.run "regsvr32 d:\test_game\dm.dll /s"
set ws=nothing
Delay 1500  

 

// 再判断插件是否注册成功

set dm = createobject("dm.dmsoft")

ver = dm.Ver()

if ver <> need_ver then

// 这时，已经确认插件注册失败了。 弹出一些调试信息，以供分析.

messagebox "插件版本错误,当前使用的版本是:"&ver&",插件所在目录是:"&dm.GetBasePath()

messagebox "请关闭程序,重新打开本程序再尝试"

    endscript

  End If


End If

//首先获取当前游戏句柄（这里通过游戏类名获取，也可以直接鼠标获取Plugin.Window.MousePoint）
Hwnd = Plugin.Window.Find("QQSwordWinClass", 0)

//创建大漠插件对象
Set dm = createobject("dm.dmsoft") 
do
//dm.GetCursorPos x,y
//MessageBox x&","&y
color = dm.GetColor(490,151)
//MessageBox color
//If color = 1 Then
If color <> "33d455" Then 
//	MessageBox "不相等"
 
KeyDown "Alt", 1
Delay 206
KeyDown "1", 1
Delay 7
Delay 176
KeyUp "Alt", 1
Delay 6
KeyUp "1", 1
Delay 5100
Else 
//MessageBox "相等"
Delay 5100
End If
loop

