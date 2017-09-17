//
//  RootViewController.m
//  Chapter4-1-3
//
//  Created by 倪庆峰 on 2017/9/17.
//  Copyright © 2017年 ni. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGRect rtSceen = [[UIScreen mainScreen] bounds];
    
    CGRect rtLabel = CGRectMake(10, 50, rtSceen.size.width-20, 50);
    UILabel* label = [[UILabel alloc] initWithFrame:rtLabel];
    label.text = @"纯代码初始化界面";
    label.textAlignment = NSTextAlignmentLeft;
    label.font = [UIFont systemFontOfSize:30];
    [self.view addSubview:label];
    
    NSLog(@"label Created %@, rt:%.2f, %.2f", label, rtLabel.origin.x, rtLabel.origin.y);
    
    
    CGRect rtButton = CGRectMake((rtSceen.size.width - 200)/2, 100, 200, 50);
    UIButton* button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = rtButton;
    [button setTitle:@"Switch Label" forState:UIControlStateNormal];
    //button.titleLabel.text = @"Switch Label";
    button.titleLabel.font = [UIFont systemFontOfSize:20];
    [button addTarget:self action:@selector(onClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    NSLog(@"button Created %@, rt:%.2f, %.2f", button, rtButton.origin.x, rtButton.origin.y);
}

-(void)onClicked:(NSNotification*) notify
{
    NSLog(@"Button Clicked!!!");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
