//
//  ViewController.m
//  Chapter8-1-2
//
//  Created by 倪庆峰 on 2017/10/2.
//  Copyright © 2017年 ni. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *txtUserName;
@property (weak, nonatomic) IBOutlet UITextField *txtPassword;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onRegisterDone:) name:@"RegisterDone" object:nil];
}

-(void)onRegisterDone:(NSNotification*)notify
{
    NSDictionary* dict = [notify userInfo];
    NSString* username = [dict objectForKey:@"username"];
    NSLog(@"RegisterDone UserName:%@", username);
    
    self.txtUserName.text = username;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
