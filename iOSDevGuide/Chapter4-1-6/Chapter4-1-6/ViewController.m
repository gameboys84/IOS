//
//  ViewController.m
//  Chapter4-1-6
//
//  Created by 倪庆峰 on 2017/9/24.
//  Copyright © 2017年 ni. All rights reserved.
//

#import "ViewController.h"
#import "WebKit/WebKit.h"

@interface ViewController () <WKNavigationDelegate>
@property (strong, nonatomic) UIButton* btnLoadHTTPString;
@property (strong, nonatomic) UIButton* btnLoadData;
@property (strong, nonatomic) UIButton* btnLoadRequest;

@property (strong, nonatomic) WKWebView* webView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    CGRect rtScreen = self.view.frame;
    UIView* viewContainer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, rtScreen.size.width, 60)];
    [self.view addSubview:viewContainer];
    
    
    CGFloat width = MIN(100,rtScreen.size.width/3);
    CGFloat height = 40;
    self.btnLoadHTTPString = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.btnLoadHTTPString setTitle:@"LoadHTTPString" forState:UIControlStateNormal];
    [self.btnLoadHTTPString setFrame:CGRectMake(10, 10, width, height)];
    //[self.btnLoadHTTPString setBackgroundColor:kColor]
    [self.btnLoadHTTPString addTarget:self action:@selector(onBtnHTTPStringClicked:) forControlEvents:UIControlEventTouchUpInside];
    [viewContainer addSubview:self.btnLoadHTTPString];
    
    self.btnLoadData = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.btnLoadData setTitle:@"LoadData" forState:UIControlStateNormal];
    [self.btnLoadData setFrame:CGRectMake((rtScreen.size.width-width)/2, 10, width, height)];
    [self.btnLoadData addTarget:self action:@selector(onBtnDataClicked:) forControlEvents:UIControlEventTouchUpInside];
    [viewContainer addSubview:self.btnLoadData];
    
    self.btnLoadRequest = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.btnLoadRequest setTitle:@"LoadRequest" forState:UIControlStateNormal];
    [self.btnLoadRequest setFrame:CGRectMake(rtScreen.size.width-width-10, 10, width, height)];
    [self.btnLoadRequest addTarget:self action:@selector(onBtnRequestClicked:) forControlEvents:UIControlEventTouchUpInside];
    [viewContainer addSubview:self.btnLoadRequest];

    
    self.webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, viewContainer.frame.size.height, rtScreen.size.width, rtScreen.size.height-viewContainer.frame.size.height)];
    [self.view addSubview:self.webView];

}

- (void)onBtnHTTPStringClicked:(id) sender
{
	NSLog(@"===onBtnHTTPStringClicked");
    
    NSString* htmlPath = [[NSBundle mainBundle] pathForResource:@"main" ofType:@"html"];
    NSURL* url = [NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]];
    NSError* error = nil;
    
    NSString* html = [[NSString alloc] initWithContentsOfFile:htmlPath encoding:NSUTF8StringEncoding error:&error];
    if (error == nil)
        [self.webView loadHTMLString:html baseURL:url];
}

- (void)onBtnDataClicked:(id) sender
{
    NSLog(@"===onBtnDataClicked");
    NSString* htmlPath = [[NSBundle mainBundle] pathForResource:@"main" ofType:@"html"];
    NSURL* url = [NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]];
    NSData* data = [[NSData alloc] initWithContentsOfFile:htmlPath];
    [self.webView loadData:data MIMEType:@"text/html" characterEncodingName:@"UTF-8" baseURL:url];
}

- (void)onBtnRequestClicked:(id) sender
{
    NSLog(@"===onBtnRequestClicked");
    NSURL* url = [NSURL URLWithString:@"https://www.baidu.com"];
    NSURLRequest* request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
    self.webView.navigationDelegate = self;
}

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation
{
    NSLog(@"begins to load in a web view");
}

- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation
{
    NSLog(@"begins to receive web content");
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    NSLog(@"navigation is complete");
}

//-(void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error
//{
//    NSLog(@"error occurs during navigatioin:\n%@", error.description);
//}

-(void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error
{
    NSLog(@"error occurs while web view loading content:\n%@", error.description);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
