//
//  MainDirectoryViewController.m
//  QBJClient
//
//  Created by ZHOU GAOJIE on 12-9-28.
//  Copyright (c) 2012年 ZHOU GAOJIE. All rights reserved.
//

#import "MainDirectoryViewController.h"
#import "SubDirectoryButtonController.h"
#import "JsonData.h"

@implementation MainDirectoryViewController
@synthesize controllers;
@synthesize arrayDirectory;

- (void)viewDidLoad {
    [super viewDidLoad];
    JsonData *json = [[JsonData alloc] init];
    [json postSOAP:@"0"];
       
    
    self.title = @"主目录";
    NSMutableArray *array = [[NSMutableArray alloc] init];
//    [array addObject:movieViewController];
    self.controllers = array;
    NSArray *theData = json.arrayDirectory;// [[NSArray alloc] initWithObjects:@"20120728102451,97\",\"采矿业\",\"0\",\"\",\"34\",\"1", @"20120728102515,98\",\"制造业\",\"0\",\"\",\"34\",\"1", nil];
    
    for (NSString *str in theData) {
        NSRange r = [str rangeOfString:@"\",\""];
        [array addObject:[str substringToIndex:r.location]];
        NSRange r2 = [str rangeOfString:@"\",\"" options:0 range:NSMakeRange(r.location + 3, [str length] - r.location - 3)];
        [array addObject:[str substringWithRange:NSMakeRange(r.location + 3, r2.location - r.location - 3)]];
    }
    self.controllers = array;
//    self.controllers = [[NSArray alloc] initWithObjects:@"123", @"456", nil];
}

#pragma mark -
#pragma mark Table Data Source Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.controllers count] / 2;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *MainDirectoryCell = @"MainDirectory";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MainDirectoryCell];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MainDirectoryCell];
    }
    NSUInteger row = [indexPath row];
//    SubDirectoryViewController *controller = [controllers objectAtIndex:row];
//    cell.textLabel.text = controller.title;
//    cell.imageView.image = controller.rowImage;
    cell.imageView.image = [UIImage imageNamed:@"floder.png"];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    cell.textLabel.text = controllers[row * 2 + 1];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSUInteger row = [indexPath row];
    SubDirectoryButtonController *nextController = [[SubDirectoryButtonController alloc] init];// [self.controllers objectAtIndex:row];
    nextController.title = controllers[row * 2 + 1];
    nextController.dicID = controllers[row * 2];
    [self.navigationController pushViewController:nextController animated:YES];
}
@end
