//
//  PDFViewController.m
//  QBJClient
//
//  Created by ZHOU GAOJIE on 12-9-28.
//  Copyright (c) 2012年 ZHOU GAOJIE. All rights reserved.
//

#import "PDFViewController.h"

@implementation PDFViewController

@synthesize message;

- (void)viewWillAppear:(BOOL)animated {
    NSString *urlString = [NSString stringWithFormat:@"http://zengzzcpp.3322.org:8180/pdfviw.aspx?acsid=%@",message];
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    _webView.scalesPageToFit = YES;
    [_webView loadRequest:request];
//    [_webView.]

    [super viewWillAppear:animated];
}
//
//- (void)viewDidLoad {
//    _webView.multipleTouchEnabled = true;
//}

- (IBAction)changeTextFontSize:(id)sender
{
    switch ([sender tag]) {
        case 1: // A-
            textFontSize = (textFontSize > 50) ? textFontSize -5 : textFontSize;
            break;
        case 2: // A+
            textFontSize = (textFontSize < 160) ? textFontSize +5 : textFontSize;
            break;
    }
    
    NSString *jsString = [[NSString alloc] initWithFormat:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '%d",
                          textFontSize];
    [_webView stringByEvaluatingJavaScriptFromString:jsString];
}
@end
