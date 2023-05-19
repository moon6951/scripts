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
Description=云打码
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
// 云打码按键精灵（普通模式）示例
// 技术ＱＱ：4008588180
// 官方网站：http://www.yundama.com
// 
//////////////////////////////////////////////////////////////////////////////

If Plugin.File.IsFileExit("plugin/yundama.dll") = false
    msgbox "云打码插件文件不存在，请下载 yundama.dll 放置 plugin 文件夹后重新运行该脚本", 16, "错误"
    ExitScript
End If 

// 注意这里是普通会员账号，不是开发者账号，注册地址 http://www.yundama.com/index/reg/user
// 开发者可以联系客服领取免费调试题分

云打码用户 = "lianzhongt456 "						// 【测试前先更改】云打码用户名
云打码密码 = "lianzhongt456"						// 【测试前先更改】云打码密码

//////////////////////////////////////////////////////////////////////////////

// 1. http://www.yundama.com/index/reg/developer 注册开发者账号
// 2. http://www.yundama.com/developer/myapp 添加新软件
// 3. 使用添加的软件ID和密钥进行开发，享受丰厚分成

软件ID = 8409										// 【测试前先更改】软件ＩＤ，开发者分成必要参数。登录开发者后台【我的软件】获得！
软件密钥 = "bdbd6b159f4432739f07b63ab930ec7b"	// 【测试前先更改】软件密钥，开发者分成必要参数。登录开发者后台【我的软件】获得！

//////////////////////////////////////////////////////////////////////////////

图片路径 = "D:\temp\captcha.jpg"						// 【测试前先更改】识别图片路径

// 错误代码请查询 http://www.yundama.com/apidoc/YDM_ErrorCode.html
错误提示 = chr(10) + chr(13) + chr(10) + chr(13) + ">>> 错误代码含义在此查询" + chr(10) + chr(13) + ">>> " + "http://www.yundama.com/apidoc/YDM_ErrorCode.html"

//////////////////////////////////////////////////////////////////////////////

初始成功 = Plugin.yundama.SetAppInfo(软件ID, 软件密钥)			// 初始云打码，只需初始一次即可

登陆返回 = Plugin.yundama.Login(云打码用户, 云打码密码)			// 登陆云打码，只需登陆一次即可

If 登陆返回 > 0 Then 
	
	// 取剩余题分，按需获取剩余题分，可以不调用
	剩余题分 = Plugin.yundama.GetBalance(云打码用户, 云打码密码)

	// 例：1004表示4位字母数字，不同类型收费不同。请准确填写，否则影响识别率
	// 在此查询所有类型 http://www.yundama.com/price.html
	验证码类型 = 1003
	
	// 设置识别超时时间，单位：秒
	超时时间 = 60

	// 开始识别图片
	识别结果 = Plugin.yundama.DecodeByPath(图片路径, 验证码类型, 验证码ID)
	
	// 是否识别成功
	If 验证码ID > 0 Then 

		是否错误 = MsgBox("当前图片识别结果为：" + 识别结果 + chr(10) + chr(13) + "识别正确选是，错误选否", VbYesNo + VbInformation, "识别结果是否正确？")

		// ############# 验证码报错 #############

		If 是否错误 = vbNo Then 
		
			// 验证码识别错误请调用此函数进行报错，以便返还题分
			// 恶意报错会导致开发者账号被封或不予结算！
			
			报错返回 = Plugin.yundama.Report(验证码ID)
			
			If 报错返回 = 0 Then 
				MsgBox "图片识别错误，已经成功报错", VbInformation
			Else 
				MsgBox "汇报错误失败，返回代码：" + Cstr(报错返回) + 错误提示, VbCritical, "报错失败"
			End If
		Else 
			MsgBox "图片识别正确，无需汇报错误", VbInformation
		End If
		// ############# 验证码报错 #############

	Else 
		MsgBox "识别失败，错误代码：" + Cstr(验证码ID) + 错误提示, VbCritical, "识别失败" 	// 错误代码请查询 http://www.yundama.com/apidoc/YDM_ErrorCode.html
	End If
	
Else

	MsgBox "登陆失败，错误代码：" + Cstr(登陆返回) + 错误提示, VbCritical, "登陆失败"	// 错误代码请查询 http://www.yundama.com/apidoc/YDM_ErrorCode.html
	
End If

// ####################### 其他函数 #######################

// 调用下面函数前需要先初始化
// 初始成功 = Plugin.yundama.SetAppInfo(软件ID, 软件密钥)

// ####################### 卡号充值 #######################

// 云打码用户 = "testuser"
// 云打码密码 = "testpass"
// 云打码卡号 = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
// 充值返回 = Plugin.yundama.Pay(云打码用户, 云打码密码, 云打码卡号)	// 返回 0 成功

// ####################### 注册账号 #######################

// 注册用户 = "testuser"
// 注册密码 = "testpass"
// 注册邮箱 = "test@qq.com"
// 注册手机 = "13000000000"
// 注册QQ = "10000"
// 注册返回 = Plugin.yundama.Reg(云打码用户, 云打码密码, 注册邮箱, 注册手机, 注册QQ)	// 返回 0 成功

// #######################################################
