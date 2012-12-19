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
    
    [self initDic];
    
    MSTableViewController *msTableVC = [[MSTableViewController alloc]initWithFrame:CGRectMake(0, 0, 320, 460)];
    msTableVC.msDelegate = self;
    msTableVC.msDataSource = self;
    msTableVC.msBottomDelegate = self;
    
    [self.view addSubview:msTableVC.view];
}

- (void)initDic
{
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
    [keys release];
}

#pragma mark MSTableViewControllerDataSource

- (MSTableViewCell *)msTableView:(MSTableView *)msTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    MSTableViewCell *cell = [msTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[MSTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    if ([msTableView.selectedCellIndexPathArray containsObject:indexPath]) {
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

- (NSInteger)msTableView:(MSTableView *)msTableView numberOfRowsInSection:(NSInteger)section
{
    NSString *key = [[self.dic allSortedKeys] objectAtIndex:section];
    NSArray *objectArray = [self.dic objectForKey:key];
    
    return objectArray.count;
}

- (NSInteger)numberOfSectionsInMSTableView:(MSTableView *)msTableView
{
    return [self.dic allKeys].count;
}

- (NSString *)msTableView:(MSTableView *)msTableView titleForHeaderInSection:(NSInteger)section
{
    return [[self.dic allSortedKeys] objectAtIndex:section];
}

- (NSArray *)sectionIndexTitlesForMSTableView:(MSTableView *)msTableView
{
    if (msTableView.isSearching) {
        return nil;
    } else {
        return [self.dic allSortedKeys];
    }
}

- (id)msTableView:(MSTableView *)msTableView objectAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *key = [[self.dic allSortedKeys] objectAtIndex:indexPath.section];
    NSArray *objectArray = [self.dic objectForKey:key];
    return [objectArray objectAtIndex:indexPath.row];
}

#pragma mark MSTableViewControllerDelegate
- (void)msTableView:(MSTableView *)msTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"在msTableView中点击了第%d组，第%d个用户。", indexPath.section, indexPath.row);
}

#pragma mark MSBottomViewControllerDelegate

- (UIImage *)MSBottomView:(UIView *)msBottomView imageForUser:(id)user
{
    //通过user对象得到头像
    UIImage *image = [UIImage imageNamed:@"user.png"];
    return image;
}

- (void)MSBottomView:(UIView *)msBottomView didRemoveUserAtIndex:(NSInteger)index
{
    NSLog(@"取消了第%d个用户。", index);
}

- (void)MSBottomView:(UIView *)msBottomView pressCommitButton:(UIButton *)button withSelectedUserArray:(NSArray *)selectedUserArray
{
    NSLog(@"选择了%d个用户：\n%@", selectedUserArray.count, selectedUserArray);
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
