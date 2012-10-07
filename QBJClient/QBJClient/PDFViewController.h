//
//  PDFViewController.h
//  QBJClient
//
//  Created by ZHOU GAOJIE on 12-9-28.
//  Copyright (c) 2012年 ZHOU GAOJIE. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PDFViewController : UIViewController {
    NSUInteger textFontSize;
}

@property (copy, nonatomic) NSString *message;
@property (strong, nonatomic) IBOutlet UIWebView *webView;

@end
