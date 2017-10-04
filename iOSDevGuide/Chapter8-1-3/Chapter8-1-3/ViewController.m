//
//  ViewController.m
//  Chapter8-1-3
//
//  Created by 倪庆峰 on 2017/10/4.
//  Copyright © 2017年 ni. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageCtrl;

@property (strong, nonatomic) UIImageView *img1;
@property (strong, nonatomic) UIImageView *img2;
@property (strong, nonatomic) UIImageView *img3;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.scrollView.delegate = self;
    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width*3, self.view.frame.size.height);
    self.scrollView.frame = self.view.frame;
    
    // 所有的UIImageView共用一个ScrollView
    self.img1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"img1.png"]];
    self.img1.frame = self.view.frame;
    [self.scrollView addSubview:self.img1];
    
    self.img2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"img2.png"]];
    self.img2.frame = CGRectMake(self.view.frame.size.width, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height);
    [self.scrollView addSubview:self.img2];
    
    self.img3 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"img3.png"]];
    self.img3.frame = CGRectMake(self.view.frame.size.width*2, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height);
    [self.scrollView addSubview:self.img3];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint ptOffset = scrollView.contentOffset;
    self.pageCtrl.currentPage = ptOffset.x / self.scrollView.frame.size.width;
    
    NSLog(@"onPageChanged 1:%ld", (long)self.pageCtrl.currentPage);
}

-(IBAction)onPageChanged:(id)sender
{
    NSLog(@"onPageChanged 2:%ld", (long)self.pageCtrl.currentPage);
    
    [UIView animateWithDuration:0.3f animations:^{
        self.scrollView.contentOffset = CGPointMake(self.pageCtrl.currentPage * self.scrollView.frame.size.width, 0);
    }];
}

@end
