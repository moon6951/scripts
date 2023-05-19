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
MacroID=80dfba41-5bb1-4188-b4dc-d3092ec9e1c7
Description=调用百度API1
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
//FilePath="D:\temp\captcha.jpg"
'vbscript将图片2进制信息转为base64字符，参数FilePath为图片文件物理路径
'@return：ImagesToBase64返回图片base64格式字符串，前缀为data:image/图片类型;base64,base64数据
Function ImagesToBase64(FilePath)
    Dim xml
    Dim root
    Dim fs
    Dim objStream
    Dim objXMLDoc
    Dim Base64
    Set objXMLDoc=CreateObject("msxml2.FreeThreadedDOMDocument")
    objXMLDoc.loadXML "<?xml version='1.0' ?><data></data>"
    Set fs = createObject("Scripting.FileSystemObject") ''FSO组件
    If fs.FileExists(FilePath) Then '判断File文件是否存在
    '用 stream 来读取数据
    Set objStream = CreateObject("ADODB.Stream")
    objStream.Type = 1
    objStream.Open
    objStream.LoadFromFile FilePath
    
    objXMLDoc.documentElement.dataType = "bin.base64"
    objXMLDoc.documentElement.nodeTypedvalue = objStream.Read

    '数据流读取结束.得到了值 objXMLDoc
    '创建XML文件
    Set xml = CreateObject("msxml2.FreeThreadedDOMDocument")
    xml.load objXMLDoc
    If xml.ReadyState>2 Then
    Set root=xml.getElementsByTagName("data")
    Base64 = root.Item(0).Text
    Base64 = Replace(Base64,vbLf,"") 
    //TracePrint "Base64=" & Base64
    else
    Base64=""
    End If
    Set xml=Nothing
    Set objStream=Nothing
    else
    Base64=""
    End If
    Set fs=Nothing
    Set objXMLDoc=Nothing
    ImagesToBase64 = Base64
End Function
Function URLEncode(strURL)
    Dim I
    Dim tempStr
    For I = 1 To Len(strURL)
        If Asc(Mid(strURL, I, 1)) < 0 Then
            tempStr = "%" & Right(CStr(Hex(Asc(Mid(strURL, I, 1)))), 2)
            tempStr = "%" & Left(CStr(Hex(Asc(Mid(strURL, I, 1)))), Len(CStr(Hex(Asc(Mid(strURL, I, 1))))) - 2) & tempStr
            URLEncode = URLEncode & tempStr
        ElseIf (Asc(Mid(strURL, I, 1)) >= 65 And Asc(Mid(strURL, I, 1)) <= 90) Or (Asc(Mid(strURL, I, 1)) >= 97 And Asc(Mid(strURL, I, 1)) <= 122) Or (Asc(Mid(strURL, I, 1)) >= 48 And Asc(Mid(strURL, I, 1)) <= 57) Then
            URLEncode = URLEncode & Mid(strURL, I, 1)
        Else
            URLEncode = URLEncode & "%" & Hex(Asc(Mid(strURL, I, 1)))
        End If
    Next
End Function

Function postBaiduOCR(Url)
    Set xmlHttp=CreateObject("Microsoft.XMLHTTP")
    xmlHttp.Open "POST", Url, False
    //答案选项列表图片base64
    //TracePrint Url
    base64str = ImagesToBase64("D:\temp\captcha.jpg")
    //图片base64后再urlencode
    tmp = URLEncode(base64str)
    //TracePrint "URLEncode=" & tmp
    xmlHttp.send "image="&tmp
    If xmlHttp.readyState=4 then 
        response = xmlHttp.ResponseText
    End If
    xmlHttp.Abort 
    Set xmlHttp = Nothing
    TracePrint "调用百度识别返回结果=" & response
    postBaiduOCR = response
    Set sc = CreateObject("MSScriptControl.ScriptControl")
    sc.Language = "JScript"
    sc.AddCode "var o = " & response & ";"
    //获取第i个words并去除两边空格，然后统一转成大写
    //word_str1 = UCase(Trim(sc.Eval("o.words_result[0].words")))
    //第一个答案
    //TracePrint word_str
    //word_str2 = UCase(Trim(sc.Eval("o.words_result[1].words")))
    //第二个答案
    //TracePrint word_str
    //word_str3 = UCase(Trim(sc.Eval("o.words_result[2].words")))
    //第三个答案
    //TracePrint word_str
    //word_str4 = UCase(Trim(sc.Eval("o.words_result[3].words")))
    //第四个答案
    //TracePrint word_str
End Function
api_url="https://aip.baidubce.com/rest/2.0/ocr/v1/accurate_basic?access_token=24.d0ca1cc1198225ca11c6324ae266b5c4.2592000.1566610363.282335-16874537"
postBaiduOCR (api_url)
//TracePrint word_str4
