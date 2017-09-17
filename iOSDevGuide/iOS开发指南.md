iOS开发指南.md

Chapter4  UIView与视图

  1-1: 常规实现
  
      Storyboard,IB（Interface Build）实现，Label,Button, TextField（单行）,TextView（多行）事件处理，键盘出现和消失（resignFirstResponder）
       
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
  
