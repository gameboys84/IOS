//
//  ViewController.m
//  Chapter4-1-9
//
//  Created by 倪庆峰 on 2017/10/1.
//  Copyright © 2017年 ni. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIBarButtonItem *naviSave;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *toolbarSave;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)onSave:(id)sender
{
    
    if (sender == self.naviSave)
    {
        NSLog(@"Navigation onSave");
        [self.naviSave setTitle:@"Done"];
        [self.naviSave setStyle:UIBarButtonItemStyleDone];
    }
    else if (sender == self.toolbarSave)
    {
        NSLog(@"Toolbar onSave");
        [self.toolbarSave setTitle:@"Done"];
        [self.toolbarSave setStyle:UIBarButtonItemStyleDone];
    }

}

-(IBAction)onOpen:(id)sender
{
    NSLog(@"onOpen");
}

-(IBAction)onAdd:(id)sender
{
    NSLog(@"onAdd");
}

@end
