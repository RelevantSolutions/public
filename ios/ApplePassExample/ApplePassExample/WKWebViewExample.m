//
//  ViewController.m
//  ApplePassExample
//
//  Created by justin imhoff on 10/13/16.
//  Copyright © 2016 Relevant Solutions. All rights reserved.
//

#import "WKWebViewExample.h"
#import <WebKit/WebKit.h>
#import <PassKit/PassKit.h>

@interface WKWebViewExample ()<WKNavigationDelegate>

@end

@implementation WKWebViewExample

- (void)viewDidLoad {
    [super viewDidLoad];
    WKWebViewConfiguration *theConfiguration = [[WKWebViewConfiguration alloc] init];
    WKWebView *webView = [[WKWebView alloc] initWithFrame:self.view.frame configuration:theConfiguration];
    webView.navigationDelegate = self;
    [self.view addSubview:webView];
    
    //Make sure to provide your API key and Latitude / Longitude if possible or remove paramaters
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://web.groupinterest.com/define?&apiKey=&latitude=0&longitude=-0"]]];
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
    if ([navigationResponse.response.MIMEType isEqualToString:@"application/vnd.apple.pkpass"]) {
        NSURLSessionDataTask *downloadTask = [[NSURLSession sharedSession] dataTaskWithURL:navigationResponse.response.URL completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            PKPass *pass = [[PKPass alloc] initWithData:data error:&error];
            if (error) {
                NSLog(@"Error: %@", error);
            } else {
                PKAddPassesViewController *apvc = [[PKAddPassesViewController alloc] initWithPass:pass];
                [self presentViewController:apvc animated:YES completion:nil];
            }
        }];
        [downloadTask resume];
        //Stop the loading because it will be a background task
        decisionHandler(WKNavigationResponsePolicyCancel);
    }else{
        //Continue with load
        decisionHandler(WKNavigationResponsePolicyAllow);
    }
}



@end
