//
//  GPWebViewController.m
//  GPVision
//
//  Created by wangtao on 2017/1/6.
//  Copyright © 2017年 wangtao. All rights reserved.
//

#import "GPWebViewController.h"

@interface GPWebViewController ()<UIWebViewDelegate>
@property (nonatomic, strong) UIWebView *webView;
@end

@implementation GPWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.webView = [[UIWebView alloc]initWithFrame:self.view.bounds];
    self.webView.delegate = self;
    NSURL *url = [NSURL URLWithString:@"http://m.zngirls.com/gallery"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
    [self.view addSubview:self.webView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {

}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSLog(@"%@",[NSHTTPCookieStorage sharedHTTPCookieStorage].cookies);
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {

}
@end
