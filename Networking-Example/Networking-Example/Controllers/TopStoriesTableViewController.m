//
//  TopStoriesTableViewController.m
//  Networking-Example
//
//  Created by Saleh AlDhobaie on 4/24/16.
//  Copyright © 2016 Saleh AlDhobaie. All rights reserved.
//

#import "TopStoriesTableViewController.h"
#import "NSDictionary+objectForKeyOrNil.h"
#import "HackerNewsManager.h"

@interface TopStoriesTableViewController ()

@property (nonnull, nonatomic, strong) NSMutableArray *tableViewData;


@end

@implementation TopStoriesTableViewController


#pragma mark - Lazy init

- (NSMutableArray *)tableViewData {
    if (!_tableViewData) {
        _tableViewData = [NSMutableArray array];
    }
    return _tableViewData;
}


#pragma mark - LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 44.f;
    
    [self fetchTopStories];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Fetch Web Service

- (void)fetchTopStories {
    
    [[HackerNewsManager sharedManager]topStories:^(id  _Nonnull results, NSURLSessionDataTask * _Nonnull successTask) {
        
        
        for (NSNumber *number in results) {
            [self fetchStoryDetils:number];
        }
        
        
        
    } failure:^(NSError * _Nonnull error, NSURLSessionDataTask * _Nonnull task) {
        
        NSLog(@"%@", error);
    }];
    
    
    
}


- (void)fetchStoryDetils:(NSNumber * _Nonnull)identifier {
    
    
    [[HackerNewsManager sharedManager]storyDetailsWithIdentifier:identifier success:^(id  _Nonnull results, NSURLSessionDataTask * _Nonnull successTask) {
        
        
        [self.tableViewData addObject:results];
        [self.tableView reloadData];
        
    } failure:^(NSError * _Nonnull error, NSURLSessionDataTask * _Nonnull task) {
        NSLog(@"%@", error);

    }];
    
    
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.tableViewData.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    NSDictionary * item = [self.tableViewData objectAtIndex:indexPath.row];

    cell.textLabel.text = [item objectForKeyOrNil:@"title"];
    cell.detailTextLabel.text = [item objectForKeyOrNil:@"by"];
    
    
    // Configure the cell...
    
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
