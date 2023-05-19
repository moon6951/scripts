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
MacroID=09d84eb0-02b9-4f89-bc19-0e72e3134d6e
Description=字符串处理
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
Function compare(find, word_str1, word_str2, word_str3, word_str4)
If find = word_str1 Then 
	TracePrint "第一个验证码"
	//MoveTo intX + 177, intY + 47
	//LeftClick 1
	Delay 3000
	RestartScript
	ElseIf find = word_str2 Then
	TracePrint "第二个验证码"
	//MoveTo intX + 179, intY + 69
	//LeftClick 1
	Delay 3000
	RestartScript
	ElseIf find = word_str3 Then
	TracePrint "第三个验证码"
	//MoveTo intX + 180, intY + 87
	//LeftClick 1
	Delay 3000
	RestartScript
	ElseIf find = word_str4 Then
	TracePrint "第四个验证码"
	//MoveTo intX + 177, intY + 108
	//LeftClick 1
	Delay 3000
	RestartScript
	Else TracePrint "没找到"
End If	
End Function
word_str1="5L2"
word_str2="EL2"
word_str3="592"
word_str4="5L9"
find = "519"
compare find, word_str1, word_str2, word_str3, word_str4
b = InStr(find, "1")
If b > 0 Then 
	a11 = Replace(find, "1", "L")
	compare a11,word_str1,word_str2,word_str3,word_str4
	a12 = Replace(find, "1", "I")
	compare a12,word_str1,word_str2,word_str3,word_str4
End If
b = InStr(find, "N")
If b > 0 Then 
	a11 = Replace(find, "N", "W")
	compare a11,word_str1,word_str2,word_str3,word_str4
End If
b = InStr(find, "M")
If b > 0 Then 
	a11 = Replace(find, "M", "W")
	compare a11,word_str1,word_str2,word_str3,word_str4
End If
b = InStr(find, "N")
If b > 0 Then 
	a11 = Replace(find, "N", "M")
	compare a11,word_str1,word_str2,word_str3,word_str4
End If
b = InStr(find, "H")
If b > 0 Then 
	a11 = Replace(find, "H", "M")
	compare a11,word_str1,word_str2,word_str3,word_str4
End If
b = InStr(find, "V")
If b > 0 Then 
	a11 = Replace(find, "V", "Y")
	compare a11,word_str1,word_str2,word_str3,word_str4
End If
//全部执行完还没找到就选第三个
    MoveTo intX + 180, intY + 87
	LeftClick 1
	Delay 3000
	RestartScript
