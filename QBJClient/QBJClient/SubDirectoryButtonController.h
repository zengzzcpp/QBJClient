//
//  SubDirectoryButtonController.h
//  QBJClient
//
//  Created by ZHOU GAOJIE on 12-9-28.
//  Copyright (c) 2012年 ZHOU GAOJIE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SubDirectoryViewController.h"
@class PDFViewController;

@interface SubDirectoryButtonController : SubDirectoryViewController {
    NSArray *list;
    int dirCount;
//    PDFViewController *childController;
}
@property (strong, nonatomic) NSArray *list;
@property (strong, nonatomic) NSString *dicID;
@property (strong, nonatomic) NSArray *controllers;

@end
