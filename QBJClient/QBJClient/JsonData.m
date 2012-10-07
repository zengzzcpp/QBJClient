//
//  JsonData.m
//  QBJClient
//
//  Created by ZHOU GAOJIE on 12-9-26.
//  Copyright (c) 2012年 ZHOU GAOJIE. All rights reserved.
//

#import "JsonData.h"

@implementation DirectoryData

- (NSString *)getFieldValue:(int)index {
    return fieldString[index];
}

-(void)setFieldValue:(NSString *)value arrayIndex:(int)index {
    fieldString[index] = value;
}

- (id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

@end

@implementation JsonData

@synthesize arrayDirectory;
@synthesize webData;
@synthesize webDataSys;

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    NSLog(@"Start net connecting.");
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [webData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"Error with connection!");
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
//    NSLog(@"Finished");
//    NSString *responeString = [[NSString alloc] initWithBytes:webData.mutableBytes length:webData.length encoding:NSUTF8StringEncoding];
////    responeString = [responeString stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
////    responeString = [responeString stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
//    
//    NSRange range = NSMakeRange(0, [responeString length]);
//    NSRange first = [responeString rangeOfString:@"[" options:0 range:range];
//    NSRange last = [responeString rangeOfString:@"]" options:NSBackwardsSearch range:range];
//    NSRange jsonRange = NSMakeRange(first.location+1, last.location - first.location-1);
//    NSString *subString = [responeString substringWithRange:jsonRange];
//    
//    arrayDirectory = [self getDirectory:subString];
}

- (void)postSOAP: (NSString *)dirID {
    //封装soap请求消息
	NSString *soapMessage = [NSString stringWithFormat:
							 @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
							 "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
							 "<soap:Body>\n"
							 "<getDirectoryJson xmlns=\"http://zengzzcpp.3322.org/\">\n"
							 "<pid>%@</pid>\n"
							 "</getDirectoryJson>\n"
							 "</soap:Body>\n"
							 "</soap:Envelope>\n",dirID
							 ];
	//请求发送到的路径
	NSURL *url = [NSURL URLWithString:@"http://zengzzcpp.3322.org:8180/ipadsvr.asmx"];
	NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
	NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
	
	//以下对请求信息添加属性前四句是必有的，第五句是soap信息。
	[theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
	[theRequest addValue: @"http://zengzzcpp.3322.org/getDirectoryJson" forHTTPHeaderField:@"SOAPAction"];
	
	[theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
	[theRequest setHTTPMethod:@"POST"];
	[theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
    
//    NSURLConnection *theConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
//    if (theConnection) {
//        webData = [[NSMutableData alloc] init];
//    } else {
//        NSLog(@"the connection is NULL");
//    }
    NSHTTPURLResponse *response = nil;
    NSError *error = nil;
    webDataSys = [NSURLConnection sendSynchronousRequest:theRequest returningResponse:&response error:&error];
    NSLog(@"responseCode = %d", [response statusCode]);
    
    NSString *responeString = [[NSString alloc] initWithBytes:webData.mutableBytes length:webData.length encoding:NSUTF8StringEncoding];
    //    responeString = [responeString stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
    //    responeString = [responeString stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
    //if (responeString.length < 1) return;
    responeString = [[NSString alloc] initWithData:webDataSys encoding:NSUTF8StringEncoding];
    
    NSRange range = NSMakeRange(0, [responeString length]);
    NSRange first = [responeString rangeOfString:@"[" options:0 range:range];
    NSRange last = [responeString rangeOfString:@"]" options:NSBackwardsSearch range:range];
    NSRange jsonRange = NSMakeRange(first.location+1, last.location - first.location-1);
    NSString *subString = [responeString substringWithRange:jsonRange];

    arrayDirectory = [self getDirectory:subString];

}

- (void)postSOAP: (NSString *)soapAction pid:(NSString *)pID {
    //封装soap请求消息
	NSString *soapMessage = [NSString stringWithFormat:
							 @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
							 "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
							 "<soap:Body>\n"
							 "<%@ xmlns=\"http://zengzzcpp.3322.org/\">\n"
							 "<pid>%@</pid>\n"
							 "</%@>\n"
							 "</soap:Body>\n"
							 "</soap:Envelope>\n",soapAction, pID, soapAction
							 ];
	//请求发送到的路径
	NSURL *url = [NSURL URLWithString:@"http://zengzzcpp.3322.org:8180/ipadsvr.asmx"];
	NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
	NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
	
	//以下对请求信息添加属性前四句是必有的，第五句是soap信息。
	[theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    NSString *soap = [NSString stringWithFormat:@"http://zengzzcpp.3322.org/%@", soapAction];
	[theRequest addValue: soap forHTTPHeaderField:@"SOAPAction"];
	
	[theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
	[theRequest setHTTPMethod:@"POST"];
	[theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
    
    //    NSURLConnection *theConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
    //    if (theConnection) {
    //        webData = [[NSMutableData alloc] init];
    //    } else {
    //        NSLog(@"the connection is NULL");
    //    }
    NSHTTPURLResponse *response = nil;
    NSError *error = nil;
    webDataSys = [NSURLConnection sendSynchronousRequest:theRequest returningResponse:&response error:&error];
    NSLog(@"responseCode = %d", [response statusCode]);
    
    NSString *responeString = [[NSString alloc] initWithBytes:webData.mutableBytes length:webData.length encoding:NSUTF8StringEncoding];
    //    responeString = [responeString stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
    //    responeString = [responeString stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
    //if (responeString.length < 1) return;
    responeString = [[NSString alloc] initWithData:webDataSys encoding:NSUTF8StringEncoding];
    
    NSRange range = NSMakeRange(0, [responeString length]);
    NSRange first = [responeString rangeOfString:@"[" options:0 range:range];
    NSRange last = [responeString rangeOfString:@"]" options:NSBackwardsSearch range:range];
    NSRange jsonRange = NSMakeRange(first.location+1, last.location - first.location-1);
    NSString *subString = [responeString substringWithRange:jsonRange];
    
    arrayDirectory = [self getDirectory:subString];
    
}

- (NSMutableArray *)getDirectory: (NSString *)responesString {
    if (responesString.length <= 0) {
        return nil;
    }

    NSRange dataRange = NSMakeRange(0, responesString.length);
    NSRange firstRange = NSMakeRange(0, 0);
    NSRange lastRange = firstRange;
    int stringLength = responesString.length;
    
    NSMutableArray *resultArray = [[NSMutableArray alloc] init];
    while (lastRange.location < stringLength) {
        NSRange first = [responesString rangeOfString:@"[" options:0 range:dataRange];
        lastRange = [responesString rangeOfString:@"]" options:0 range:dataRange];
        int length = lastRange.location - first.location - 1;
        
        NSRange theRange = NSMakeRange(first.location + 1 + 1, length - 2);
        if (lastRange.location < stringLength) {
            NSString *data = [responesString substringWithRange:theRange];
            NSLog(@"\n%@", data);
            [resultArray addObject:data];
//    
//            NSArray *arr = [data componentsSeparatedByString:@"\",\""];
//            for (NSString *s in arr) {
//                NSLog(@"%@",s);
//            }
        }
        dataRange.location = lastRange.location + 1;
        dataRange.length = stringLength - dataRange.location;
    }

    return resultArray;
}
@end
