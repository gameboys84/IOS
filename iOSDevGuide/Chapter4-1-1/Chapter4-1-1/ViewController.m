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
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property UIView* activeField;
@property CGFloat keyboardHeight;
@property CGFloat scrollViewHeight;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapTouched:)];
    tapGesture.numberOfTapsRequired = 1;
    
    // 必须为当前view开启交互，默认是关闭的
    [self.view setUserInteractionEnabled:true];
    [self.view addGestureRecognizer:tapGesture];
    
    //self.scrollView = (UIScrollView*)self.view;
    self.scrollViewHeight = [UIScreen mainScreen].bounds.size.height;
    NSLog(@"height: viewHeight=%@", NSStringFromCGRect(self.view.frame));
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onClick:(id)sender forEvent:(UIEvent *)event {
    //NSLog(@"sender:%@, event%:ld", [sender name], (long)[event type]);
    
    self.label.text = [NSString stringWithFormat:@"%d Hello World!", rand()];
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.activeField = textField;
    [self updateScorllView:YES];
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    self.activeField = NULL;
}

-(void)textViewDidBeginEditing:(UITextView *)textView
{
    self.activeField = textView;
    [self updateScorllView:YES];
}

-(void)textViewDidEndEditing:(UITextView *)textView
{
    self.activeField = NULL;
}

- (void)onTapTouched:(UITapGestureRecognizer*)sender
{
    //NSLog(@"onTapTouched:%ld", sender.state);
    
    [self.view endEditing:true];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    //NSLog(@"txt:%@", text);
    
//    if ([text isEqualToString:@"\n"])
//    //if ([text isEqualToString:UIKeyInputEscape])
//    {
//        //NSLog(@"return input");
//        [textView resignFirstResponder];
//        return NO;
//    }
    
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

- (void)updateScorllView:(BOOL)openKeyboard {
    if (openKeyboard)
    {
        UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, self.keyboardHeight, 0.0);
        [self.scrollView setContentInset:contentInsets];
        [self.scrollView setScrollIndicatorInsets:contentInsets];
        
        CGRect aRect = self.view.frame;
        aRect.size.height -= self.keyboardHeight;
        // 需要滚动时才会滚动
        if (!CGRectContainsPoint(aRect, self.activeField.frame.origin))
            [self.scrollView setContentOffset:CGPointMake(0, self.keyboardHeight) animated:YES];
    }
    else
    {
        UIEdgeInsets contentInsets = UIEdgeInsetsZero;
        self.scrollView.contentInset = contentInsets;
        self.scrollView.scrollIndicatorInsets = contentInsets;
        [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    }
}

-(void)keyboardDidShow:(NSNotification*) notify
{
    //NSLog(@"keyboard show");
    CGSize sizeKeyboardBegin = [[notify.userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    CGSize sizeKeyboardEnd = [[notify.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    NSLog(@"size: begin=%@, end=%@", NSStringFromCGSize(sizeKeyboardBegin), NSStringFromCGSize(sizeKeyboardEnd));
    
    self.keyboardHeight = sizeKeyboardEnd.height; // 271

    [self updateScorllView:true];
    
    NSLog(@"SHOW viewHeight:%@, scorllHeight:%@, keyboard:%.2f", NSStringFromCGRect(self.scrollView.frame), NSStringFromCGRect(self.view.frame), self.keyboardHeight);
}

-(void)keyboardDidHide:(NSNotification*) notify
{
    //NSLog(@"keyboard hide");

    [self updateScorllView:NO];

    NSLog(@"HIDE viewHeight:%@, scorllHeight:%@, keyboard:%.2f", NSStringFromCGRect(self.scrollView.frame), NSStringFromCGRect(self.view.frame), self.keyboardHeight);
}

@end
