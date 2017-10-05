//
//  ViewController.m
//  Chapter8-1-4
//
//  Created by 倪庆峰 on 2017/10/4.
//  Copyright © 2017年 ni. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIPageViewControllerDataSource, UIPageViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UIPageControl *pageCtrl;

@property (strong, nonatomic) UIPageViewController *pageViewCtrl;
@property (strong, nonatomic) NSArray *viewCtrls;


@end

@implementation ViewController

int pageIdx; // 当前页数
bool isPageForword; // 向后翻页

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIViewController *page1 = [[UIViewController alloc] init];
    UIViewController *page2 = [[UIViewController alloc] init];
    UIViewController *page3 = [[UIViewController alloc] init];
    
    self.viewCtrls = @[page1,page2,page3];
    
    // 每个UIImageView对应一个Controller
    UIImageView* image1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"img1"]];
    image1.frame = self.view.frame;
    [page1.view addSubview:image1];
    
    UIImageView* image2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"img2"]];
    image2.frame = self.view.frame;
    [page2.view addSubview:image2];

    UIImageView* image3 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"img3"]];
    image3.frame = self.view.frame;
    [page3.view addSubview:image3];
    
    self.pageViewCtrl = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStylePageCurl navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    self.pageViewCtrl.delegate = self;
    self.pageViewCtrl.dataSource = self;
    [self.pageViewCtrl setViewControllers:@[page1] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    
    [self.view addSubview:self.pageViewCtrl.view];
   
    self.pageCtrl.numberOfPages = self.viewCtrls.count;
    isPageForword = YES;
    pageIdx = 0;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


// In terms of navigation direction. For example, for 'UIPageViewControllerNavigationOrientationHorizontal', view controllers coming 'before' would be to the left of the argument view controller, those coming 'after' would be to the right.
// Return 'nil' to indicate that no more progress can be made in the given direction.
// For gesture-initiated transitions, the page view controller obtains view controllers via these methods, so use of setViewControllers:direction:animated:completion: is not required.
-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    pageIdx--;
    if (pageIdx < 0)
    {
        pageIdx = 0;
        return nil;
    }
    
    self.pageCtrl.currentPage = pageIdx;
    isPageForword = false;
    return self.viewCtrls[pageIdx];
}

-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    pageIdx++;
    if (pageIdx >= self.viewCtrls.count)
    {
        pageIdx = (int)self.viewCtrls.count - 1;
        return nil;
    }
    
    self.pageCtrl.currentPage = pageIdx;
    isPageForword = true;
    return self.viewCtrls[pageIdx];
}

// 在屏幕旋转后，再翻页时会报这2个错误 ：待查
// 1. Unbalanced calls to begin/end appearance transitions
// 2. [App] if we're in the real pre-commit handler we can't actually add any new fences due to CA restriction

// Delegate may specify a different spine location for after the interface orientation change. Only sent for transition style 'UIPageViewControllerTransitionStylePageCurl'.
// Delegate may set new view controllers or update double-sided state within this method's implementation as well.
-(UIPageViewControllerSpineLocation)pageViewController:(UIPageViewController *)pageViewController spineLocationForInterfaceOrientation:(UIInterfaceOrientation)orientation
{
    NSLog(@"ori:%d, page:%d", (int)orientation, pageIdx);
    
    /*switch (orientation) {
        case UIInterfaceOrientationPortrait:
        case UIInterfaceOrientationPortraitUpsideDown:
            self.pageCtrl.doubleSided = FALSE;
            return UIPageViewControllerSpineLocationMin;
            
        case UIInterfaceOrientationLandscapeLeft:
        case UIInterfaceOrientationLandscapeRight:
            self.pageCtrl.doubleSided = YES;
            return UIPageViewControllerSpineLocationMid;
            
        default:
            return UIPageViewControllerSpineLocationMin;
    }*/

    self.pageViewCtrl.doubleSided = FALSE;
    return UIPageViewControllerSpineLocationMin;
}

-(void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed
{
    if (!completed)
    {
        // 翻页未完成，所以恢复上一次的页数
        if (isPageForword)
            pageIdx--;
        else
            pageIdx++;
        
        //pageIdx = MIN(MAX(0, pageIdx), self.viewCtrls.count-1);
    }
    
    self.pageCtrl.currentPage = pageIdx;
    NSLog(@"page:%d completed:%@", pageIdx, completed ? @"TRUE" : @"FALSE");
}

-(IBAction)onPageChanged:(id)sender
{
    self.pageCtrl.currentPage = pageIdx;
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.pageViewCtrl beginAppearanceTransition:YES animated:animated];
}

-(void)viewDidAppear:(BOOL)animated
{
    [self.pageViewCtrl endAppearanceTransition];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [self.pageViewCtrl beginAppearanceTransition:NO animated:animated];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [self.pageViewCtrl endAppearanceTransition];
}


@end
