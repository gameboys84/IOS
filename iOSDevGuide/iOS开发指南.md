iOS开发指南.md

Chapter4  UIView与视图

  1-1: 常规实现
  
      Storyboard,IB（Interface Build）实现，Label,Button, TextField（单行）,TextView（多行）事件处理，键盘出现和消失（resignFirstResponder）
      加入UIScrollView，实现键盘出现时，如果虚拟键盘会遮挡输入控件，会自动向下滚动键盘高度的距离，如果不遮挡，这不会滚动。（updateScorllView）
       
  1-2: xib实现RootViewController加载
  
       - (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil;
       
  1-3: 纯代码实现RootViewController加载
  
      // 初始化界面
      self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
      
      // 当创建了xib时，使用initWithNibName初始化
      self.window.rootViewController = [[UIViewController alloc] initWithNibName:@"RootViewController" bundle:nil];
      
      // 加载指定的Controller
      self.window.rootViewController = [[RootViewController alloc] init];
      
      [self.window makeKeyAndVisible];

  1-4: 控件Label、UIButton、Switch、Segment、Slider

      // 消息响应
      - (IBAction)onValueChanged:(id)sender;
      
  1-5:
  
  1-6: UIWebView的替换控件： WKWebView
      
      1.使用3种页面加载方法;
          -loadFileURL:allowingReadAccessToURL:
          Navigates to the requested file URL on the filesystem
          
          -loadData:MIMEType:characterEncodingName:baseURL:
          Sets the webpage contents and base URL.
          
          -loadRequest:
          Navigates to a requested URL.
          
      2.将自定义资源打包到Bundle中，然后加载;
          NSBundle *main = [NSBundle mainBundle];
          NSString *resourcePath = [main pathForResource:@"main" ofType:@"html"];
          
      3.iOS9引入新特性ATS（App Transport Security），即要求应用程序访问网络资源必须使用HTTPS协议，如何关闭特性，使用HTTP协议。
          修改Info.plist
          添加App Transport Security Settings键，Add Row，添加Allow Arbitrary Load键，值为YES。
  
  
