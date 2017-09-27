//
//  ViewController.m
//  Chapter4-1-7
//
//  Created by 倪庆峰 on 2017/9/27.
//  Copyright © 2017年 ni. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicator;
@property (weak, nonatomic) IBOutlet UIProgressView *progress;
@property (strong, nonatomic) NSTimer* timer;
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

-(IBAction)onClickAlertView:(id)sender
{
    NSLog(@"onClickAlertView");
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Alert Title" message:@"this is a ALERT!" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"Cancel!" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"Cancel Clicked 1:%@", alert.textFields.firstObject.text);
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"Default!" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"Default Clicked 1:%@", alert.textFields.firstObject.text);
    }]];
    [alert addAction: [UIAlertAction actionWithTitle:@"Destructive!" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"Destructive Clicked 1:%@", alert.textFields.firstObject.text);
    }]];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"input here!";
    }];
    
    [self presentViewController:alert animated:YES completion:nil];
}

-(IBAction)onClickActionSheet:(id)sender
{
    NSLog(@"onClickActionSheet");
    
    UIAlertController* sheet = [UIAlertController alertControllerWithTitle:@"Sheet Title" message:@"this is a SHEET!" preferredStyle:UIAlertControllerStyleActionSheet];
    [sheet addAction:[UIAlertAction actionWithTitle:@"Cancel!" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"Cancel Clicked 2");
    }]];
    [sheet addAction:[UIAlertAction actionWithTitle:@"Default!" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"Default Clicked 2");
    }]];
    [sheet addAction: [UIAlertAction actionWithTitle:@"Destructive!" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"Destructive Clicked 2");
    }]];
    
    [self presentViewController:sheet animated:YES completion:nil];
}

-(IBAction)onClickStartIndicator:(id)sender
{
    UIButton* btn = (UIButton*)sender;
    if (btn.tag == 1)
    {
        if ([self.indicator isAnimating])
        {
            [self.indicator stopAnimating];
            [btn setTitle:@"start" forState:UIControlStateNormal];
        }
        else
        {
            [self.indicator startAnimating];
            [btn setTitle:@"stop" forState:UIControlStateNormal];
        }
    }
    else if (btn.tag == 2)
    {
//        if (self._prog >= 1)
//            self._prog = 0;
//        else
//            self._prog += 0.1;
//        [self.progress setProgress:self._prog animated:YES];
        
        if (self.timer == NULL)
        {
            if (self.progress.progress == 1.0)
                self.progress.progress = 0;
            [self.indicator startAnimating];
                
            [btn setTitle:@"pause" forState:UIControlStateNormal];
            self.timer = [NSTimer scheduledTimerWithTimeInterval:0.2 repeats:YES block:^(NSTimer * _Nonnull timer) {
                self.progress.progress += (rand() % 10) * 0.01;
                
                if (self.progress.progress == 1.0)
                {
                    [self.timer invalidate];
                    [self.indicator stopAnimating];
                    self.timer = NULL;
                    NSLog(@"download finished!");
                    [btn setTitle:@"start" forState:UIControlStateNormal];
                }
            }];
        }
        else
        {
            [self.timer invalidate];
            [self.indicator stopAnimating];
            self.timer = NULL;
            NSLog(@"download pause!");
            [btn setTitle:@"resume" forState:UIControlStateNormal];
        }
    }
}

@end
