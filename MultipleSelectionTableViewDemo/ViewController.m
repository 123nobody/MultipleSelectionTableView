//
//  ViewController.m
//  MultipleSelectionTableViewDemo
//
//  Created by Wei on 12-12-14.
//  Copyright (c) 2012年 Wei. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize dic = _dic;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSArray *array_A = [[NSArray alloc]initWithObjects:@"aaa", @"aab", @"abb", nil];
    NSArray *array_B = [[NSArray alloc]initWithObjects:@"bbb", @"bwer", @"bob", nil];
    NSArray *array_Y = [[NSArray alloc]initWithObjects:@"yyy", @"ytre", @"yui", nil];
    NSArray *array_Z = [[NSArray alloc]initWithObjects:@"zzz", @"zxx", @"zapo", nil];
    
    NSArray *arrays = [[NSArray alloc]initWithObjects:array_A, array_B, array_Y, array_Z, nil];
    NSArray *keys = [[NSArray alloc]initWithObjects:@"A", @"B", @"Y", @"Z", nil];
    
    self.dic = [[NSDictionary alloc]initWithObjects:arrays forKeys:keys];
    
    [array_A release];
    [array_B release];
    [array_Y release];
    [array_Z release];
    [arrays release];
    
    _msTable = [[MSTableView alloc]initWithFrame:CGRectMake(0, 0, 320, 400)];
    _msTable.delegate = self;
    _msTable.dataSource  = self;
    [self.view addSubview:_msTable];
    
    _bottomViewController = [[MSBottomViewController alloc]initWithFrame:CGRectMake(0, 400, 320, 60)];
    _bottomViewController.delegate = self;
    _bottomViewController.view.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:_bottomViewController.view];
}

#pragma mark UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    MSTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[MSTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    if ([((MSTableView *)tableView).selectedCellIndexPathArray containsObject:indexPath]) {
        [cell setChecked:YES];
    } else {
        [cell setChecked:NO];
    }
    
    NSString *key = [[self.dic allSortedKeys] objectAtIndex:indexPath.section];
    NSArray *objectArray = [self.dic objectForKey:key];
    NSString *name = [objectArray objectAtIndex:indexPath.row];
    cell.nameLabel.text = name;
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSString *key = [[self.dic allSortedKeys] objectAtIndex:section];
    NSArray *objectArray = [self.dic objectForKey:key];
    
    return objectArray.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.dic allKeys].count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return MS_TABLE_VIEW_CELL_HEIGHT;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [[self.dic allSortedKeys] objectAtIndex:section];
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    return index;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return [self.dic allSortedKeys];
}

#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (((MSTableView *)tableView).selectedCellIndexPathArray == nil) {
        NSLog(@"nil!!");
    }
    
    NSString *key = [[self.dic allSortedKeys] objectAtIndex:indexPath.section];
    NSArray *objectArray = [self.dic objectForKey:key];
    NSString *name = [objectArray objectAtIndex:indexPath.row];
    
    if ([((MSTableView *)tableView).selectedCellIndexPathArray containsObject:indexPath]) {
        [((MSTableView *)tableView).selectedCellIndexPathArray removeObject:indexPath];
        //移除一个已选用户
        [_bottomViewController removeUser:name];
    } else {
        [((MSTableView *)tableView).selectedCellIndexPathArray addObject:indexPath];
        //添加一个用户
        [_bottomViewController addUser:name];
    }
    
    MSTableViewCell *cell = (MSTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    [cell setChecked:!cell.isChecked];
    
}

#pragma mark MSBottomViewDelegate

- (UIImage *)MSBottomView:(UIView *)msBottomView imageForUser:(id)user
{
    UIImage *image = [UIImage imageNamed:@"user.png"];
    return image;
}

- (void)MSBottomView:(UIView *)msBottomView didRemoveUserAtIndex:(NSInteger)index
{
    NSIndexPath *indexPath = [_msTable.selectedCellIndexPathArray objectAtIndex:index];
    MSTableViewCell *cell = (MSTableViewCell *)[_msTable cellForRowAtIndexPath:indexPath];
    [cell setChecked:NO];
    [_msTable.selectedCellIndexPathArray removeObjectAtIndex:index];
}

#pragma mark ----------------------

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [_dic release];
    _dic = nil;
    [super dealloc];
}

@end
