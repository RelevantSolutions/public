//
//  UIWebViewExample.m
//  ApplePassExample
//
//  Created by justin imhoff on 10/14/16.
//  Copyright © 2016 Relevant Solutions. All rights reserved.
//

#import "UIWebViewExample.h"
#import <PassKit/PassKit.h>

@interface UIWebViewExample ()<UIWebViewDelegate>

@property (nonatomic,retain)NSURLRequest  *lastRequest;

@end

@implementation UIWebViewExample

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.frame];
    webView.delegate = self;
    [self.view addSubview:webView];
    
    //Make sure to provide your API key and Latitude / Longitude if possible or remove paramaters
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://web.groupinterest.com/define?&apiKey=&latitude=0&longitude=-0"]]];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    _lastRequest = request;
    return YES;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    NSURLSessionDataTask *downloadTask = [[NSURLSession sharedSession] dataTaskWithURL:[_lastRequest URL] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if ([response.MIMEType isEqualToString:@"application/vnd.apple.pkpass"]) {
            PKPass *pass = [[PKPass alloc] initWithData:data error:&error];
            if (error) {
                NSLog(@"Error: %@", error);
            } else {
                PKAddPassesViewController *apvc = [[PKAddPassesViewController alloc] initWithPass:pass];
                [self presentViewController:apvc animated:YES completion:nil];
            }
        }
    }];
    [downloadTask resume];
}

@end
