//
//  JsonData.h
//  QBJClient
//
//  Created by ZHOU GAOJIE on 12-9-26.
//  Copyright (c) 2012年 ZHOU GAOJIE. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JsonData : NSObject

@property NSArray *arrayDirectory;
@property NSMutableData *webData;
@property NSData *webDataSys;

- (NSMutableArray *)getDirectory: (NSString *)webDatas;
- (void)postSOAP: (NSString *)dirID;
- (void)postSOAP:(NSString *)dirID pid:(NSString*)pID;

@end

@interface DirectoryData : NSObject {
    NSString *fieldString[6];
}

- (NSString *)getFieldValue:(int)index;
- (void)setFieldValue: (NSString *)value arrayIndex:(int)index;

@end
