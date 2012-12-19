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

#define MS_BOTTOM_VIEW_HEIGHT 60.f

@protocol MSTableViewControllerDataSource <NSObject>
@optional
- (NSInteger)numberOfSectionsInMSTableView:(MSTableView *)msTableView;
- (NSInteger)msTableView:(MSTableView *)msTableView numberOfRowsInSection:(NSInteger)section;
- (MSTableViewCell *)msTableView:(MSTableView *)msTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
- (NSString *)msTableView:(MSTableView *)msTableView titleForHeaderInSection:(NSInteger)section;
- (NSArray *)sectionIndexTitlesForMSTableView:(MSTableView *)msTableView;
- (CGFloat)msTableView:(MSTableView *)msTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
- (NSInteger)msTableView:(MSTableView *)msTableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index;
- (id)msTableView:(MSTableView *)msTableView objectAtIndexPath:(NSIndexPath *)indexPath;
@end

@protocol MSTableViewControllerDelegate <NSObject>
@optional
- (void)msTableView:(MSTableView *)msTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
@end

@protocol MSBottomViewControllerDelegate <NSObject>
@optional
- (UIImage *)MSBottomView:(UIView *)msBottomView imageForUser:(id)user;
- (void)MSBottomView:(UIView *)msBottomView didRemoveUserAtIndex:(NSInteger)index;
- (void)MSBottomView:(UIView *)msBottomView pressCommitButton:(UIButton *)button withSelectedUserArray:(NSArray *)selectedUserArray;

@end

@interface MSTableViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, MSBottomViewDelegate>
{
    id<MSTableViewControllerDataSource> _msDataSource;
    id<MSTableViewControllerDelegate> _msDelegate;
    id<MSBottomViewControllerDelegate> _msBottomDelegate;
    
    MSTableView *_msTableView;
    MSBottomViewController *_msBottomViewController;
}

@property (nonatomic, assign) id<MSTableViewControllerDataSource> msDataSource;
@property (nonatomic, assign) id<MSTableViewControllerDelegate> msDelegate;
@property (nonatomic, assign) id<MSBottomViewControllerDelegate> msBottomDelegate;

@property (nonatomic, strong) MSTableView *msTableView;
@property (nonatomic, strong) MSBottomViewController *msBottomViewController;

- (id)initWithFrame:(CGRect)frame;

@end
