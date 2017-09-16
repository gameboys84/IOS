//
//  ViewController.m
//  Chapter4-1-1
//
//  Created by 倪庆峰 on 2017/9/16.
//  Copyright © 2017年 ni. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITextFieldDelegate, UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *label;

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

- (IBAction)onClick:(id)sender forEvent:(UIEvent *)event {
    //NSLog(@"sender:%@, event%:ld", [sender name], (long)[event type]);
    
    self.label.text = [NSString stringWithFormat:@"%d Hello World!", rand()];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    NSLog(@"txt:%@", text);
    
    if ([text isEqualToString:@"\n"])
    //if ([text isEqualToString:UIKeyInputEscape])
    {
        //NSLog(@"return input");
        [textView resignFirstResponder];
        return NO;
    }
    
    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSLog(@"should return NO!");
    [textField resignFirstResponder];
    return NO;
}

-(void)viewWillAppear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidHideNotification object:nil];
}

-(void)keyboardDidShow:(NSNotification*) notify
{
    NSLog(@"keyboard show");
    //self.view.frame.origin.y =  216;
}

-(void)keyboardDidHide:(NSNotification*) notify
{
    NSLog(@"keyboard hide");
    
}

@end
