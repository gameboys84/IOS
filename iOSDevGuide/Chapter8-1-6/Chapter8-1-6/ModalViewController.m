//
//  ModalViewController.m
//  Chapter8-1-6
//
//  Created by 倪庆峰 on 2017/10/5.
//  Copyright © 2017年 ni. All rights reserved.
//

#import "ModalViewController.h"

@interface ModalViewController ()

@end

@implementation ModalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

-(IBAction)cancel:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:^{
        NSLog(@"cancel");
    }];
}

@end
