//
//  DetailViewController.m
//  Chapter8-1-6
//
//  Created by 倪庆峰 on 2017/10/5.
//  Copyright © 2017年 ni. All rights reserved.
//

#import "DetailViewController.h"
#import <WebKit/WebKit.h>

@interface DetailViewController ()  <WKNavigationDelegate>
@property (strong, nonatomic) WKWebView *wkWebView;

//@interface DetailViewController () <UIWebViewDelegate>
//@property (strong, nonatomic) UIWebView *uiWebView;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //self.url = @"https://baike.baidu.com/item/哈尔滨/177863/";
    //self.url = @"https://www.baidu.com/";
    
    
    NSString* urlPrefix;
    NSString* urlPath;
    // 需要先转义
    if ([self.url hasPrefix:@"http://"])
    {
        urlPrefix = @"http://";
    }
    else if ([self.url hasPrefix:@"https://"])
    {
        urlPrefix = @"https://";
    }
    urlPath = [self.url substringFromIndex:[urlPrefix length]];
    
    NSString* newUrl = [NSString stringWithFormat:@"%@%@", urlPrefix, [urlPath stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLPathAllowedCharacterSet]]];
    NSLog(@"open url:%@, \nnewUrl:%@", self.url, newUrl);

    
    // WKWebView
    self.wkWebView = [[WKWebView alloc] initWithFrame:self.view.bounds];
    self.wkWebView.navigationDelegate = self;
    [self.view addSubview:self.wkWebView];

    NSURL *url = [NSURL URLWithString:newUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.wkWebView loadRequest:request];
    
    
    // UIWebView
//    self.uiWebView = [[UIWebView alloc] initWithFrame:self.view.bounds];
//    self.uiWebView.delegate = self;
//    [self.view addSubview:self.uiWebView];
//
//    NSURL *url = [NSURL URLWithString:newUrl];
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];
//    [self.uiWebView loadRequest:request];

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

// 11.在发送请求之前，决定是否跳转的代理  页面跳转代理
-(void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
    NSLog(@"1 发送请求之前，决定是否跳转");
    decisionHandler(WKNavigationActionPolicyAllow);
}

// 1.准备加载页面 加载状态回调
-(void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation
{
    NSLog(@"2 页面开始加载时调用");
}

// 12.接收到服务器跳转请求的代理  页面跳转代理
-(void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation
{
    NSLog(@"3 接收到服务器跳转请求之后调用");
}

-(void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential * _Nullable))completionHandler
{
    NSLog(@"4 服务器验证");
    
    completionHandler(NSURLSessionAuthChallengePerformDefaultHandling, nil);
}

// 13.在收到响应后，决定是否跳转的代理  页面跳转代理
-(void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler
{
    NSLog(@"11 收到响应后，决定是否跳转和发送请求之前允许配套使用");
    
    decisionHandler(WKNavigationResponsePolicyAllow);
}

// 2.内容开始加载
-(void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation
{
    NSLog(@"12 内容开始返回了...");
}

// 3.页面加载完成
-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    NSLog(@"13 页面加载完成之后调用");
}

// 4.页面加载失败
-(void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error
{
    NSLog(@"XX 页面加载失败:%@", error.description);
}

- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error
{
    NSLog(@"failed when open url:%@", error.description);
}




-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSLog(@"UIWebView 准备加载页面");
    return YES;
}

-(void)webViewDidStartLoad:(UIWebView *)webView
{
    NSLog(@"UIWebView 开始加载内容");
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSLog(@"UIWebView 加载完成");
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"UIWebView 加载失败:%@", error.description);
}

@end
