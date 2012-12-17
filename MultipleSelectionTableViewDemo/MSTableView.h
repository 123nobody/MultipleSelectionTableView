//
//  MSTableView.h
//  MultipleSelectionTableViewDemo
//
//  Created by Wei on 12-12-14.
//  Copyright (c) 2012年 Wei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MSTableViewCell.h"
#import "NSDictionary+NSDictionary_AllSortedKeys.h"

@interface MSTableView : UITableView <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UISearchDisplayDelegate>
{
    NSMutableArray *_selectedCellIndexPathArray;
    
    UIButton *_maskButton;
    UITableView *_searchTable;
    UISearchBar *_searchBar;
    UISearchDisplayController *_searchDC;
}

@property (nonatomic, strong) NSMutableArray *selectedCellIndexPathArray;

@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) UISearchDisplayController *searchDC;

@end
