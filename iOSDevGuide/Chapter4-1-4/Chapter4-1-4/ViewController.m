//
//  ViewController.m
//  Chapter4-1-4
//
//  Created by 倪庆峰 on 2017/9/19.
//  Copyright © 2017年 ni. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITextFieldDelegate, UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *lblSwitch;
@property (weak, nonatomic) IBOutlet UILabel *lblSegment;
@property (weak, nonatomic) IBOutlet UILabel *lblSlider;

@property (weak, nonatomic) IBOutlet UISwitch *Switch;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segment;
@property (weak, nonatomic) IBOutlet UISlider *slider;

- (IBAction)onValueChanged:(id)sender;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    CGRect rtScreen = [[UIScreen mainScreen] bounds];
    
    CGRect rtCaption = CGRectMake(10, 50, rtScreen.size.width-20, 50);
    UILabel* label = [[UILabel alloc] initWithFrame:rtCaption];
    label.text = @"控件Label、UIButton、Switch、Segment、Slider";
    label.textAlignment = NSTextAlignmentLeft;
    [label setAdjustsFontSizeToFitWidth:YES];
    label.font = [UIFont systemFontOfSize:30];
    [self.view addSubview:label];
    
    //NSLog(@"label Created %@, rt:%.2f, %.2f", label, rtLabel.origin.x, rtLabel.origin.y);

    
    CGRect rtButton = CGRectMake(0, 0, 100, 20);
    UIButton* btnOverlay = [UIButton buttonWithType:UIButtonTypeSystem];
    [btnOverlay addTarget:self action:@selector(onClickBtn:forEvent:) forControlEvents:UIControlEventTouchUpInside];
    [btnOverlay setTitle:@"Click!" forState:UIControlStateNormal];
    //btnOverlay.titleLabel.text = @"Clicked!";
    btnOverlay.titleLabel.font = [UIFont systemFontOfSize:20 weight:600];
    btnOverlay.frame = rtButton;
    
    UITextField* textField = [[UITextField alloc] initWithFrame:CGRectMake(10, 150, rtScreen.size.width-20, 20)];
    textField.text = @"edit";
    textField.leftView = btnOverlay;
    textField.leftViewMode = UITextFieldViewModeAlways;
    textField.clearButtonMode = UITextFieldViewModeAlways;
    textField.delegate = self;
    [self.view addSubview:textField];
    //[self.view addSubview:btnOverlay];
    
    
    UITextView* textView = [[UITextView alloc] initWithFrame:CGRectMake(10, 200, rtScreen.size.width-20, 100)];
    textView.text = @"input here\nLine 2";
    textView.keyboardType = UIKeyboardTypeAlphabet;
    textView.returnKeyType = UIReturnKeyDone;
    textView.delegate = self;
    [self.view addSubview:textView];

    
    [self updateText:self.Switch];
    [self updateText:self.segment];
    [self updateText:self.slider];
}

- (void)onClickBtn:(id)sender forEvent:(UIEvent*) event
{
    NSLog(@"===onClickBtn:%@, %@", sender, event);
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    NSLog(@"textFieldDidBeginEditing");
    [textField becomeFirstResponder];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSLog(@"textFieldShouldReturn");
    [textField resignFirstResponder];
    return YES;
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"])
    {
        [textView resignFirstResponder];
        return NO;
    }
    
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)onValueChanged:(id)sender {
    [self updateText:sender];
}

-(void)updateText:(id) sender
{
    if ([sender isKindOfClass:[UISwitch class]])
    {
        UISwitch* Switch = (UISwitch*)sender;
        NSString* status = Switch.isOn ? @"YES" : @"NO";
        NSLog(@"Switch Status: %@", status);
        self.lblSwitch.text = [NSString stringWithFormat:@"开关状态：%@", status];
    }
    else if ([sender isKindOfClass:[UISegmentedControl class]])
    {
        UISegmentedControl* segment = (UISegmentedControl*)sender;
        NSString* status = [segment titleForSegmentAtIndex:segment.selectedSegmentIndex];
        NSLog(@"Segment Title: %@", status);
        self.lblSegment.text = [NSString stringWithFormat:@"分段开头：%@", status];
    }
    else if ([sender isKindOfClass:[UISlider class]])
    {
        UISlider* slider = (UISlider*)sender;
        NSString* status = [NSString stringWithFormat:@"%.2f", slider.value];
        //NSLog(@"Slider Value: %@", status);
        self.lblSlider.text = [NSString stringWithFormat:@"Slider进度：%@", status];
    }
}
@end
