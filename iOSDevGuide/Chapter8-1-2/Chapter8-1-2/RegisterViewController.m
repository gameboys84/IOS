//
//  RegisterViewController.m
//  Chapter8-1-2
//
//  Created by 倪庆峰 on 2017/10/2.
//  Copyright © 2017年 ni. All rights reserved.
//

#import "RegisterViewController.h"

@interface RegisterViewController ()
@property (weak, nonatomic) IBOutlet UITextField *txtUserName;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)onBtnCancel:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:^{
        NSLog(@"关闭注册界面");
    }];
}

-(IBAction)onBtnSave:(id)sender
{
    NSDictionary* dict = [NSDictionary dictionaryWithObject:self.txtUserName.text forKey:@"username"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"RegisterDone" object:nil userInfo:dict];
    
    [self dismissViewControllerAnimated:YES completion:^{
        NSLog(@"RegisterDone Close");
    }];
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
