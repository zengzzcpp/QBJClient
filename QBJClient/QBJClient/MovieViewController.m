//
//  MovieViewController.m
//  QBJClient
//
//  Created by ZHOU GAOJIE on 12-9-28.
//  Copyright (c) 2012年 ZHOU GAOJIE. All rights reserved.
//

#import "MovieViewController.h"
#import "PDFViewController.h"
#import "AppDelegate.h"

@interface MovieViewController ()
@property (strong, nonatomic) PDFViewController *childContorller;
@end

@implementation MovieViewController

@synthesize movieList;
@synthesize childContorller;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    NSArray *array = [[NSArray alloc] initWithObjects:@"肖申克的救赎", @"教父", @"教父：II",
                      @"低俗小说", @"黄金三镖客", @"十二怒汉", @"辛德勒名单",
                      @"蝙蝠侠前传2：黑暗骑士", @"指环王：王者归来", @"飞越疯人院",
                      @"星球大战Ⅴ：帝国反击战", @"搏击俱乐部", @"盗梦空间", @"七武士",
                      @"指环王：护戒使者", @"好家伙", @"星球大战IV：新希望", @"上帝之城",
                      @"卡萨布兰卡", @"黑客帝国", @"西部往事", @"后窗", @"夺宝奇兵",
                      @"沉默的羔羊", @"非常嫌疑犯", @"七宗罪", @"指环王：双塔奇兵", @"阿甘正传",
                      @"惊魂记", @"美好人生", nil];
    self.movieList = array;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return movieList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MovieTableViewCell = @"MovieTableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MovieTableViewCell forIndexPath:indexPath];
    
    // Configure the cell...
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MovieTableViewCell];
    }
    
    NSUInteger row = [indexPath row];
    NSString *movieTitle = [movieList objectAtIndex:row];
    cell.textLabel.text = movieTitle;
    cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
    if (childContorller == nil) {
        childContorller = [[PDFViewController alloc] initWithNibName:@"PDFView" bundle:nil];
    }
    NSUInteger row = [indexPath row];
    NSString *selectedMovie = [movieList objectAtIndex:row];
    NSString *pdfMessage = [[NSString alloc] initWithFormat:@"you have select %@",selectedMovie];
    childContorller.title = selectedMovie;
    [self.navigationController pushViewController:childContorller animated:YES];
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
