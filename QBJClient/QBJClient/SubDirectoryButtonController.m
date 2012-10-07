//
//  SubDirectoryButtonController.m
//  QBJClient
//
//  Created by ZHOU GAOJIE on 12-9-28.
//  Copyright (c) 2012年 ZHOU GAOJIE. All rights reserved.
//

#import "SubDirectoryButtonController.h"
#import "AppDelegate.h"
#import "PDFViewController.h"
#import "JsonData.h"
#import "SubDirectoryButtonController.h"

@interface SubDirectoryButtonController ()
@property (strong, nonatomic) PDFViewController *childController;
@end

@implementation SubDirectoryButtonController
@synthesize list;
@synthesize childController;
@synthesize dicID;
@synthesize controllers;

- (void)viewDidLoad {
    [super viewDidLoad];
    JsonData *json = [[JsonData alloc] init];
    [json postSOAP:dicID];
    NSMutableArray *array = [[NSMutableArray alloc] initWithArray:json.arrayDirectory];
    dirCount = array.count;
    
    [json postSOAP:@"getPDFFileListJson" pid:dicID];
    list = json.arrayDirectory;
    [array addObjectsFromArray:list];
    
    NSMutableArray *arrayDir = [[NSMutableArray alloc] init];
    for (NSString *str in array) {
        NSRange r = [str rangeOfString:@"\",\""];
        [arrayDir addObject:[str substringToIndex:r.location]];
        NSRange r2 = [str rangeOfString:@"\",\"" options:0 range:NSMakeRange(r.location + 3, [str length] - r.location - 3)];
        [arrayDir addObject:[str substringWithRange:NSMakeRange(r.location + 3, r2.location - r.location - 3)]];
    }
    self.controllers = arrayDir;
}

#pragma mark -
#pragma mark Table Data Source Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.controllers.count / 2;
}
- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
    if (childController == nil) {
        childController = [[PDFViewController alloc] initWithNibName:@"PDFView" bundle:nil];
    }
//    childController.title = @"PDF View";
    NSUInteger row = [indexPath row] * 2;
    NSString *selectedPdf = [controllers objectAtIndex:row + 1];
    NSString *pdfMessage = [controllers objectAtIndex:row];
    childController.message = pdfMessage;
    childController.title = selectedPdf;
    [self.navigationController pushViewController:childController animated:YES];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSUInteger row = [indexPath row];
    if (row >= dirCount) return;
    SubDirectoryButtonController *nextController = [[SubDirectoryButtonController alloc] init];// [self.controllers objectAtIndex:row];
    nextController.title = controllers[row * 2 + 1];
    nextController.dicID = controllers[row * 2];
    [self.navigationController pushViewController:nextController animated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *SubDirectoryButtonCell = @"SubDirectoryButtonCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SubDirectoryButtonCell];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:SubDirectoryButtonCell];
    }
    NSUInteger row = [indexPath row];
//    NSString *rowString = [list objectAtIndex:row];
    cell.textLabel.text = controllers[row * 2 + 1];
//    NSArray *arrayInfo = [str componentsSeparatedByString:@"\",\""];

    if (row < dirCount) {
        cell.imageView.image = [UIImage imageNamed:@"floder.png"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    } else {
        cell.imageView.image = [UIImage imageNamed:@"pdf.png"];
        cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
        cell.detailTextLabel.text = [list objectAtIndex:row];
    }
    // UITableViewCellAccessoryDetailDisclosureButton;
    
    return cell;
}
@end
