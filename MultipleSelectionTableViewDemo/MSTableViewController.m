//
//  MSTableViewController.m
//  MultipleSelectionTableViewDemo
//
//  Created by Wei on 12-12-17.
//  Copyright (c) 2012年 Wei. All rights reserved.
//

#import "MSTableViewController.h"

@interface MSTableViewController ()

@end

@implementation MSTableViewController

@synthesize msDelegate = _msDelegate;
@synthesize msDataSource = _msDataSource;
@synthesize msBottomDelegate = _msBottomDelegate;
@synthesize msTableView = _msTableView;
@synthesize msBottomViewController = _msBottomViewController;

- (id)initWithFrame:(CGRect)frame
{
    self = [super init];
    if (self) {
        [self.view setFrame:frame];
        
        frame.size.height -= MS_BOTTOM_VIEW_HEIGHT;
        _msTableView = [[MSTableView alloc]initWithFrame:frame];
        [self.view addSubview:self.msTableView];
        self.msTableView.delegate = self;
        self.msTableView.dataSource = self;
        
        frame.origin.y += frame.size.height;
        frame.size.height = MS_BOTTOM_VIEW_HEIGHT;
        _msBottomViewController = [[MSBottomViewController alloc]initWithFrame:frame];
        _msBottomViewController.delegate = self;
        [self.view addSubview:self.msBottomViewController.view];
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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (_msDataSource && [_msDataSource respondsToSelector:@selector(numberOfSectionsInMSTableView:)]) {
        return [_msDataSource numberOfSectionsInMSTableView:(MSTableView *)tableView];
    } else {
        return 0;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_msDataSource && [_msDataSource respondsToSelector:@selector(msTableView:numberOfRowsInSection:)]) {
        return [_msDataSource msTableView:(MSTableView *)tableView numberOfRowsInSection:section];
    } else {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_msDataSource && [_msDataSource respondsToSelector:@selector(msTableView:cellForRowAtIndexPath:)]) {
        return [_msDataSource msTableView:(MSTableView *)tableView cellForRowAtIndexPath:indexPath];
    } else {
        return nil;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_msDataSource && [_msDataSource respondsToSelector:@selector(msTableView:heightForRowAtIndexPath:)]) {
        return [_msDataSource msTableView:(MSTableView *)tableView heightForRowAtIndexPath:indexPath];
    } else {
        return MS_TABLE_VIEW_CELL_HEIGHT;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (_msDataSource && [_msDataSource respondsToSelector:@selector(msTableView:titleForHeaderInSection:)]) {
        return [_msDataSource msTableView:(MSTableView *)tableView titleForHeaderInSection:section];
    } else {
        return nil;
    }
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    if (_msDataSource && [_msDataSource respondsToSelector:@selector(sectionIndexTitlesForMSTableView:)]) {
        return [_msDataSource sectionIndexTitlesForMSTableView:(MSTableView *)tableView];
    } else {
        return nil;
    }
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    if (_msDataSource && [_msDataSource respondsToSelector:@selector(msTableView:sectionForSectionIndexTitle:atIndex:)]) {
        return [_msDataSource msTableView:(MSTableView *)tableView sectionForSectionIndexTitle:title atIndex:index];
    } else {
        return index;
    }
}

//- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
//{
//    if (((MSTableView *)tableView).isSearching) {
//        return nil;
//    } else {
//        if (_msDataSource && [_msDataSource respondsToSelector:@selector(sectionIndexTitlesForTableView:)]) {
//            return [_msDataSource sectionIndexTitlesForMSTableView:(MSTableView *)tableView];
//        } else {
//            return nil;
//        }
//    }
//}

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
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (((MSTableView *)tableView).selectedCellIndexPathArray == nil) {
        NSLog(@"nil!!");
    }
    
    id object = [_msDataSource msTableView:(MSTableView *)tableView objectAtIndexPath:indexPath];
    
    if ([((MSTableView *)tableView).selectedCellIndexPathArray containsObject:indexPath]) {
        [((MSTableView *)tableView).selectedCellIndexPathArray removeObject:indexPath];
        //移除一个已选用户
        [_msBottomViewController removeUser:object];
    } else {
        [((MSTableView *)tableView).selectedCellIndexPathArray addObject:indexPath];
        //添加一个用户
        [_msBottomViewController addUser:object];
    }
    
    MSTableViewCell *cell = (MSTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    [cell setChecked:!cell.isChecked];
    
    [_msDelegate msTableView:(MSTableView *)tableView didSelectRowAtIndexPath:indexPath];
}

#pragma mark - MSBottomViewDelegate

- (UIImage *)MSBottomView:(UIView *)msBottomView imageForUser:(id)user
{
    if (_msBottomDelegate && [_msBottomDelegate respondsToSelector:@selector(MSBottomView:imageForUser:)]) {
        return [_msBottomDelegate MSBottomView:msBottomView imageForUser:user];
    } else {
        return nil;
    }
}

- (void)MSBottomView:(UIView *)msBottomView didRemoveUserAtIndex:(NSInteger)index
{
    NSIndexPath *indexPath = [_msTableView.selectedCellIndexPathArray objectAtIndex:index];
    MSTableViewCell *cell = (MSTableViewCell *)[_msTableView cellForRowAtIndexPath:indexPath];
    [cell setChecked:NO];
    [_msTableView.selectedCellIndexPathArray removeObjectAtIndex:index];
    if (_msBottomDelegate && [_msBottomDelegate respondsToSelector:@selector(MSBottomView:didRemoveUserAtIndex:)]) {
        [_msBottomDelegate MSBottomView:msBottomView didRemoveUserAtIndex:index];
    }
}

- (void)MSBottomView:(UIView *)msBottomView pressCommitButton:(UIButton *)button withSelectedUserArray:(NSArray *)selectedUserArray
{
    if (_msBottomDelegate && [_msBottomDelegate respondsToSelector:@selector(MSBottomView:pressCommitButton:withSelectedUserArray:)]) {
        [_msBottomDelegate MSBottomView:msBottomView pressCommitButton:button withSelectedUserArray:selectedUserArray];
    }
}

@end
