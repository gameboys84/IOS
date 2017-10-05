//
//  TableViewController.m
//  Chapter8-1-6
//
//  Created by 倪庆峰 on 2017/10/5.
//  Copyright © 2017年 ni. All rights reserved.
//

#import "TableViewController.h"
#import "DetailViewController.h"

@interface TableViewController ()
@property (strong, nonatomic) NSDictionary *dictData;
@property (strong, nonatomic) NSArray *lstData;
@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"province_cities" ofType:@"plist"];
    self.dictData = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
    
    UINavigationController *naviCtrl = (UINavigationController*)self.parentViewController;
    NSString *selectProvince = naviCtrl.tabBarItem.title;
    
    NSLog(@"select:%@", selectProvince);
    
    bool isFind = false;
    if ([selectProvince isEqualToString:@"黑龙江"] || [selectProvince isEqualToString:@"吉林"]
        || [selectProvince isEqualToString:@"辽宁"])
        isFind = true;
    
    if (isFind)
    {
        self.lstData = self.dictData[selectProvince];
        self.navigationItem.title = [NSString stringWithFormat:@"%@省信息", selectProvince];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of rows
    return self.lstData.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellID" forIndexPath:indexPath];
    
    NSInteger selectedIdx = indexPath.row;
    NSDictionary *dict = self.lstData[selectedIdx];
    
    cell.textLabel.text = dict[@"name"];
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([segue.identifier isEqualToString:@"ShowDetail"])
    {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSInteger selectedIdx = indexPath.row;
        
        NSDictionary *dict = self.lstData[selectedIdx];
        DetailViewController *detailView = (DetailViewController*) segue.destinationViewController;
        
        detailView.url = dict[@"url"];
        detailView.title = dict[@"name"];
    }
}


@end
