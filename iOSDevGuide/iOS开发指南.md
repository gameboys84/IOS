iOS开发指南.md
==============

Chapter4  UIView与视图
---------------------

###1-1: 常规实现

* Storyboard
* IB（Interface Build）实现
* UILabel
* UIButton
* UITextField（单行）
* UITextView（多行）
* 事件处理，键盘出现和消失

		resignFirstResponder
	
* UIScrollView
实现键盘出现时，如果虚拟键盘会遮挡输入控件，会自动向下滚动键盘高度的距离，如果不遮挡，这不会滚动。
		
		updateScorllView
       
---

###1-2: xib实现RootViewController加载
  
	(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil;
       
---
       
###1-3: 纯代码实现RootViewController加载
  
	// 初始化界面
	self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
      
	// 当创建了xib时，使用initWithNibName初始化
	self.window.rootViewController = [[UIViewController alloc] initWithNibName:@"RootViewController" bundle:nil];
      
	// 加载指定的Controller
	self.window.rootViewController = [[RootViewController alloc] init];
      
	[self.window makeKeyAndVisible];

---

###1-4: 控件Label、UIButton、Switch、Segment、Slider

	// 消息响应
	(IBAction)onValueChanged:(id)sender;
   
---
      
###1-5:

---
  
###1-6: UIWebView的替换控件： WKWebView
      
* 1.使用3种页面加载方法;

		loadFileURL:allowingReadAccessToURL:
		// Navigates to the requested file URL on the filesystem
          
		loadData:MIMEType:characterEncodingName:baseURL:
		//Sets the webpage contents and base URL.
          
		loadRequest:
		//Navigates to a requested URL.
          
* 2.将自定义资源打包到Bundle中，然后加载;

		NSBundle *main = [NSBundle mainBundle];
		NSString *resourcePath = [main pathForResource:@"main" ofType:@"html"];
          
* 3.iOS9引入新特性ATS（App Transport Security），即要求应用程序访问网络资源必须使用HTTPS协议，如何关闭特性，使用HTTP协议。

		修改Info.plist
		添加App Transport Security Settings键，Add Row，添加Allow Arbitrary Load键，值为YES。

---
  
###1-7: 消息框的两种表现形式 UIAlertController， 活动指示器和进度条 UIActivityIndicatorView、UIProgressView
  
* 1. UIAlertController可以分为警告框和操作表两种表现形式

	* 警告框：  UIAlertControllerStyleAlert
	
			可以带TextFiled，
			可以通过这样获取文本内容： alert.textFields.firstObject.text
			
	* 操作表： UIAlertControllerStyleActionSheet

			不可以带TextField
			都有三种按钮样式： 
				1.UIAlertActionStyleDefault
				2.UIAlertActionStyleCancel
				3.UIAlertActionStyleDestructive
          
* 2. 活动指示器：UIActivityIndicatorView
仅仅用于指示状态为 进行中或已停止
	* 开启动画

			[self.indicator startAnimating]
			
	* 结束动画

			[self.indicator stopAnimating]
              
* 3. 进度条：UIProgressView
通过定时器控制进度变化：
	* 创建定时器

			self.timer = [NSTimer scheduledTimerWithTimeInterval:0.2 repeats:YES block:^(NSTimer * _Nonnull timer) {...}
	
	* 终止定时器
          
			[self.timer invalidate];
  
---


