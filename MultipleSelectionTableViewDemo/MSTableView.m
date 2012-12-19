//
//  MSTableView.m
//  MultipleSelectionTableViewDemo
//
//  Created by Wei on 12-12-14.
//  Copyright (c) 2012年 Wei. All rights reserved.
//

#import "MSTableView.h"

@implementation MSTableView

@synthesize selectedCellIndexPathArray = _selectedCellIndexPathArray;
@synthesize isSearching = _isSearching;
@synthesize searchBar = _searchBar;
@synthesize searchDC = _searchDC;

- (id)initWithFrame:(CGRect)frame
{
    self = [self initWithFrame:frame style:UITableViewStylePlain];
    if (self) {
        _searchBar = [[[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, 320.f, 44.f)] autorelease];
        self.searchBar.delegate = self;
        self.searchBar.tintColor = [UIColor colorWithRed:0.8f green:0.8f blue:0.8f alpha:1.0f];
        self.searchBar.autocorrectionType = UITextAutocorrectionTypeNo;
        self.searchBar.autocapitalizationType = UITextAutocapitalizationTypeNone;
        self.searchBar.keyboardType = UIKeyboardTypeAlphabet;
        self.searchBar.hidden = NO;
        self.searchBar.placeholder = [NSString stringWithCString:"搜索"  encoding: NSUTF8StringEncoding];
        self.tableHeaderView = self.searchBar;
        
        
        _searchDC = [[[UISearchDisplayController alloc] initWithSearchBar:self.searchBar contentsController:(UIViewController *)[self nextResponder]] autorelease];
        self.searchDC.delegate = self;
        self.searchDC.searchResultsDataSource = self;
        self.searchDC.searchResultsDelegate = self;
        [self.searchDC setActive:NO];
        
        _selectedCellIndexPathArray = [[NSMutableArray alloc]initWithCapacity:0];
    }
    return self;
}

- (void)loadSearchTableBySearchText:(NSString *)searchText
{
    if (_searchTable) {
        //更新搜索array
        
        NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"SELF contains[cd] %@", searchText];
        
//        self.searchResults = [self.allItems filteredArrayUsingPredicate:resultPredicate];
        
        
        
        [_searchTable setHidden:NO];
        [_searchTable reloadData];
    } else {
        _searchTable = [[UITableView alloc]initWithFrame:_maskButton.frame style:UITableViewStylePlain];
        [self addSubview:_searchTable];
        //更新搜索array
    }
}

- (void)cancelSearching
{
    _searchBar.showsCancelButton = NO;
    _searchBar.text = @"";
    _isSearching = NO;
    //键盘消失
	[_searchBar resignFirstResponder];
    //蒙板消失
    [_maskButton setHidden:YES];
    [self reloadData];
    self.scrollEnabled = YES;
}

#pragma mark UISearchBarDelegate

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    _isSearching = YES;
    searchBar.showsCancelButton = YES;
    //修改cancel为取消
    for(id cc in [self.searchBar subviews])
    {
        if([cc isKindOfClass:[UIButton class]])
        {
            UIButton *btn = (UIButton *)cc;
            [btn setTitle:@"取消"  forState:UIControlStateNormal];
        }
    }
    if (_maskButton) {
        [_maskButton setHidden:NO];
    } else {
        _maskButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _maskButton.backgroundColor = [UIColor blackColor];
        _maskButton.alpha = 0.6;
        [_maskButton setFrame:CGRectMake(0, self.tableHeaderView.frame.size.height, 320.f, (self.frame.size.height - self.tableHeaderView.frame.size.height))];
        [self addSubview:_maskButton];
    }
    [self reloadData];
    self.scrollEnabled = NO;
    return YES;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if (searchText != @"" && searchText != nil && searchText.length > 0) {
        NSLog(@"搜索字段：%@", searchText);
        [self loadSearchTableBySearchText:searchText];
    } else {
        [self setHidden:NO];
        [_searchTable setHidden:YES];
    }
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    NSLog(@"点击了搜索的取消按钮！");
    [self cancelSearching];
}


#pragma mark UISearchDisplayDelegate



#pragma mark -----------------------

- (void)dealloc
{
    [_selectedCellIndexPathArray release];
    _selectedCellIndexPathArray = nil;
    [super dealloc];
}

@end
