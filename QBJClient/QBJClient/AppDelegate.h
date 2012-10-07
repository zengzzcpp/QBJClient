//
//  AppDelegate.h
//  QBJClient
//
//  Created by ZHOU GAOJIE on 12-9-26.
//  Copyright (c) 2012年 ZHOU GAOJIE. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MainDirViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate> {
    UINavigationController *navController;
}

@property (strong, nonatomic) UIWindow *window;
//@property (strong, nonatomic) MainDirViewController *mainView;
@property (strong, nonatomic) UINavigationController *navController;

@end
