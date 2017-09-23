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
  
