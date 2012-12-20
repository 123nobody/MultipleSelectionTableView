//
//  MSTableViewController.m
//  MultipleSelectionTableViewDemo
//
//  Created by Wei on 12-12-17.
//  Copyright (c) 2012年 Wei. All rights reserved.
//

#import "MSTableViewController.h"
#import "MSSearchTableViewCell.h"

@interface MSTableViewController ()

@end

@implementation MSTableViewController

@synthesize msDelegate = _msDelegate;
@synthesize msDataSource = _msDataSource;
@synthesize msBottomDelegate = _msBottomDelegate;
@synthesize msTableView = _msTableView;
@synthesize msBottomViewController = _msBottomViewController;

@synthesize searchBar = _searchBar;
@synthesize searchDC = _searchDC;
@synthesize filteredListContent = _filteredListContent;
@synthesize selectedUsers = _selectedUsers;

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
        _selectedUsers = [[NSMutableArray alloc]initWithCapacity:0];
        
        frame.origin.y += frame.size.height;
        frame.size.height = MS_BOTTOM_VIEW_HEIGHT;
        _msBottomViewController = [[MSBottomViewController alloc]initWithFrame:frame];
        _msBottomViewController.delegate = self;
        [self.view addSubview:self.msBottomViewController.view];
        
        
        _searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, 320.f, 44.f)];
        self.searchBar.delegate = self;
        self.searchBar.tintColor = [UIColor colorWithRed:0.8f green:0.8f blue:0.8f alpha:1.0f];
        self.searchBar.autocorrectionType = UITextAutocorrectionTypeNo;
        self.searchBar.autocapitalizationType = UITextAutocapitalizationTypeNone;
        self.searchBar.keyboardType = UIKeyboardTypeAlphabet;
        self.searchBar.hidden = NO;
        self.searchBar.placeholder = [NSString stringWithCString:"搜索"  encoding: NSUTF8StringEncoding];
        self.msTableView.tableHeaderView = self.searchBar;
        
        
        _searchDC = [[UISearchDisplayController alloc] initWithSearchBar:self.searchBar contentsController:self];
        self.searchDC.delegate = self;
        self.searchDC.searchResultsDataSource = self;
        self.searchDC.searchResultsDelegate = self;
        [self.searchDC setActive:NO];
        
        _filteredListContent = [[NSMutableArray alloc]initWithCapacity:0];
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

- (void)removeAllSelectedUsers
{
    [self.selectedUsers removeAllObjects];
    [_msTableView reloadData];
    [_msBottomViewController reloadScrollView];
}

#pragma mark Content Filtering

- (void)filterContentForSearchText:(NSString*)searchText
{
    NSLog(@"guolv");
	[self.filteredListContent removeAllObjects];
    
    NSArray *searchList = [_msDataSource searchList];
	for (id user in searchList)
	{
        NSString *name = [_msDataSource nameForUser:user];
        NSComparisonResult result = [name compare:searchText options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch) range:NSMakeRange(0, [searchText length])];
        if (result == NSOrderedSame)
        {
            [self.filteredListContent addObject:user];
        }
	}
}

#pragma mark UISearchBarDelegate

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    //修改cancel为取消
    for(id cc in [self.searchBar subviews])
    {
        if([cc isKindOfClass:[UIButton class]])
        {
            UIButton *btn = (UIButton *)cc;
            [btn setTitle:@"取消"  forState:UIControlStateNormal];
        }
    }
    return YES;
}

#pragma mark UISearchDisplayDelegate

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString];
    
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}


- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption
{
    [self filterContentForSearchText:[self.searchDC.searchBar text]];
    
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView == self.searchDisplayController.searchResultsTableView)
	{
        return 1;
    }
	else
	{
        if (_msDataSource && [_msDataSource respondsToSelector:@selector(numberOfSectionsInMSTableView:)]) {
            return [_msDataSource numberOfSectionsInMSTableView:(MSTableView *)tableView];
        } else {
            return 0;
        }
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.searchDisplayController.searchResultsTableView)
	{
        return [self.filteredListContent count];
    }
	else
	{
        if (_msDataSource && [_msDataSource respondsToSelector:@selector(msTableView:numberOfRowsInSection:)]) {
            return [_msDataSource msTableView:(MSTableView *)tableView numberOfRowsInSection:section];
        } else {
            return 0;
        }
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.searchDisplayController.searchResultsTableView)
	{
        static NSString *CellIdentifier = @"SearchCell";
        MSSearchTableViewCell *cell = (MSSearchTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            cell = [[MSSearchTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        
        id user = [_filteredListContent objectAtIndex:indexPath.row];
        
        BOOL isCheck = [_msBottomViewController.selectedUserArray containsObject:user];
        
        [cell.photoImageView setImage:[_msDataSource imageForUser:user]];
        cell.nameLabel.text = [_msDataSource nameForUser:user];
        cell.checkLabel.text = isCheck ? @"已添加" : @"";
        
        return cell;
    }
	else
	{
        if (_msDataSource && [_msDataSource respondsToSelector:@selector(msTableViewController:cellForRowAtIndexPath:)]) {
            return [_msDataSource msTableViewController:self cellForRowAtIndexPath:indexPath];
        } else {
            return nil;
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.searchDisplayController.searchResultsTableView)
    {
        return 50.f;//搜索结果cell高度
    } else {
        if (_msDataSource && [_msDataSource respondsToSelector:@selector(msTableView:heightForRowAtIndexPath:)]) {
            return [_msDataSource msTableView:(MSTableView *)tableView heightForRowAtIndexPath:indexPath];
        } else {
            return MS_TABLE_VIEW_CELL_HEIGHT;
        }
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (tableView == self.searchDisplayController.searchResultsTableView){
        return nil;
    }
    if (_msDataSource && [_msDataSource respondsToSelector:@selector(msTableView:titleForHeaderInSection:)]) {
        return [_msDataSource msTableView:(MSTableView *)tableView titleForHeaderInSection:section];
    } else {
        return nil;
    }
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    if (tableView == self.searchDisplayController.searchResultsTableView){
        return nil;
    }
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
    
    if (tableView == self.searchDisplayController.searchResultsTableView)
	{
        id user = [_filteredListContent objectAtIndex:indexPath.row];
        if (![_selectedUsers containsObject:user]) {
            [_selectedUsers addObject:user];
            [_msBottomViewController addUser:user];
        }
        
        [self.searchDisplayController setActive:NO animated:YES];
        [_msTableView reloadData];
    }
	else
	{
//        if (((MSTableView *)tableView).selectedCellIndexPathArray == nil) {
//            NSLog(@"nil!!");
//        }
        
        id user = [_msDataSource msTableView:(MSTableView *)tableView objectAtIndexPath:indexPath];
        if ([_selectedUsers containsObject:user]) {
            //移除一个已选用户
            [_selectedUsers removeObject:user];
            [_msBottomViewController removeUser:user];
        } else {
            //添加一个用户
            [_selectedUsers addObject:user];
            [_msBottomViewController addUser:user];
        }
        [_msDelegate msTableView:(MSTableView *)tableView didSelectRowAtIndexPath:indexPath];
        [_msTableView reloadData];
        
//        if ([((MSTableView *)tableView).selectedCellIndexPathArray containsObject:indexPath]) {
//            [((MSTableView *)tableView).selectedCellIndexPathArray removeObject:indexPath];
//            //移除一个已选用户
//            [_msBottomViewController removeUser:object];
//            [_selectedUsers removeObject:object];
//        } else {
//            [((MSTableView *)tableView).selectedCellIndexPathArray addObject:indexPath];
//            //添加一个用户
//            [_msBottomViewController addUser:object];
//            [_selectedUsers addObject:object];
//        }
        
//        MSTableViewCell *cell = (MSTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
//        [cell setChecked:!cell.isChecked];
        
    }
}

#pragma mark - MSBottomViewDelegate

- (NSString *)MSBottomView:(UIView *)msBottomView nameForUser:(id)user
{
    if (_msDataSource && [_msDataSource respondsToSelector:@selector(nameForUser:)]) {
        return [_msDataSource nameForUser:user];
    } else {
        return nil;
    }
}

- (UIImage *)MSBottomView:(UIView *)msBottomView imageForUser:(id)user
{
    if (_msDataSource && [_msDataSource respondsToSelector:@selector(imageForUser:)]) {
        return [_msDataSource imageForUser:user];
    } else {
        return nil;
    }
}

- (void)MSBottomView:(UIView *)msBottomView didRemoveUserAtIndex:(NSInteger)index
{
//    NSIndexPath *indexPath = [_msTableView.selectedCellIndexPathArray objectAtIndex:index];
//    id user = [_selectedUsers objectAtIndex:index];
//    NSIndexPath *indexPath = _msDataSource ind
    
    [_selectedUsers removeObjectAtIndex:index];
    [_msTableView reloadData];
    
//    MSTableViewCell *cell = (MSTableViewCell *)[_msTableView cellForRowAtIndexPath:indexPath];
//    [cell setChecked:NO];
//    [_msTableView.selectedCellIndexPathArray removeObjectAtIndex:index];
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

- (void)dealloc
{
    [_msTableView release];
    _msTableView = nil;
    [_msBottomViewController release];
    _msBottomViewController = nil;
    [_selectedUsers release];
    _selectedUsers = nil;
    [_searchBar release];
    _searchBar = nil;
    [_searchDC release];
    _searchDC = nil;
    [_filteredListContent release];
    _filteredListContent = nil;
    [super dealloc];
}

@end
