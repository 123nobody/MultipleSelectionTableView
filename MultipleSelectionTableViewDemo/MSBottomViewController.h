//
//  MSBottomViewController.h
//  MultipleSelectionTableViewDemo
//
//  Created by Wei on 12-12-14.
//  Copyright (c) 2012年 Wei. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MSBottomViewDelegate <NSObject>

@optional
- (UIImage *)MSBottomView:(UIView *)msBottomView imageForUser:(id)user;
- (NSString *)MSBottomView:(UIView *)msBottomView nameForUser:(id)user;
- (void)MSBottomView:(UIView *)msBottomView didAddUserAtIndex:(NSInteger)index;
- (void)MSBottomView:(UIView *)msBottomView didRemoveUserAtIndex:(NSInteger)index;
- (void)MSBottomView:(UIView *)msBottomView pressCommitButton:(UIButton *)button withSelectedUserArray:(NSArray *)selectedUserArray;
@end

@interface MSBottomViewController : UIViewController
{
    id<MSBottomViewDelegate> _delegate;
    
    UIScrollView *_scrollView;
    NSMutableArray *_selectedUserImages;
    UIButton *_commitButton;
    NSMutableArray *_selectedUserArray;
    UIImageView *_blankImageView;
}

@property (nonatomic, assign) id<MSBottomViewDelegate> delegate;
@property (nonatomic, strong) NSMutableArray *selectedUserArray;

- (id)initWithFrame:(CGRect)frame;
- (void)addUser:(id)user;
- (void)removeUser:(id)user;
- (void)removeUserAtIndex:(NSInteger)index;
- (void)reloadScrollView;


@end
