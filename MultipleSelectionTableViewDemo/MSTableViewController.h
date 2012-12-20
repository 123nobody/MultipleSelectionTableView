//
//  MSTableViewController.h
//  MultipleSelectionTableViewDemo
//
//  Created by Wei on 12-12-17.
//  Copyright (c) 2012年 Wei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MSTableView.h"
#import "MSBottomViewController.h"
@class MSTableViewController;

#define MS_BOTTOM_VIEW_HEIGHT 60.f

@protocol MSTableViewControllerDataSource <NSObject>
@optional
- (NSInteger)numberOfSectionsInMSTableView:(MSTableView *)msTableView;
- (NSInteger)msTableView:(MSTableView *)msTableView numberOfRowsInSection:(NSInteger)section;
- (MSTableViewCell *)msTableViewController:(MSTableViewController *)msTableViewController cellForRowAtIndexPath:(NSIndexPath *)indexPath;
- (NSString *)msTableView:(MSTableView *)msTableView titleForHeaderInSection:(NSInteger)section;
- (NSArray *)sectionIndexTitlesForMSTableView:(MSTableView *)msTableView;
- (CGFloat)msTableView:(MSTableView *)msTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
- (NSInteger)msTableView:(MSTableView *)msTableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index;
- (id)msTableView:(MSTableView *)msTableView objectAtIndexPath:(NSIndexPath *)indexPath;
- (NSString *)nameForUser:(id)user;
- (UIImage *)imageForUser:(id)user;
- (NSArray *)searchList;
@end

@protocol MSTableViewControllerDelegate <NSObject>
@optional
- (void)msTableView:(MSTableView *)msTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
@end

@protocol MSBottomViewControllerDelegate <NSObject>
@optional
- (void)MSBottomView:(UIView *)msBottomView didRemoveUserAtIndex:(NSInteger)index;
- (void)MSBottomView:(UIView *)msBottomView pressCommitButton:(UIButton *)button withSelectedUserArray:(NSArray *)selectedUserArray;

@end

@interface MSTableViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, MSBottomViewDelegate, UISearchBarDelegate, UISearchDisplayDelegate>
{
    id<MSTableViewControllerDataSource> _msDataSource;
    id<MSTableViewControllerDelegate> _msDelegate;
    id<MSBottomViewControllerDelegate> _msBottomDelegate;
    
    MSTableView *_msTableView;
    MSBottomViewController *_msBottomViewController;
    
    UISearchBar *_searchBar;
    UISearchDisplayController *_searchDC;
    NSMutableArray *_filteredListContent;
    
    NSMutableArray *_selectedUsers;
}

@property (nonatomic, assign) id<MSTableViewControllerDataSource> msDataSource;
@property (nonatomic, assign) id<MSTableViewControllerDelegate> msDelegate;
@property (nonatomic, assign) id<MSBottomViewControllerDelegate> msBottomDelegate;

@property (nonatomic, strong) MSTableView *msTableView;
@property (nonatomic, strong) MSBottomViewController *msBottomViewController;

@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) UISearchDisplayController *searchDC;
@property (nonatomic, strong) NSMutableArray *filteredListContent;

@property (nonatomic, strong) NSMutableArray *selectedUsers;

- (id)initWithFrame:(CGRect)frame;
- (void)removeAllSelectedUsers;

@end
