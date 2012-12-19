//
//  MSBottomViewController.m
//  MultipleSelectionTableViewDemo
//
//  Created by Wei on 12-12-14.
//  Copyright (c) 2012年 Wei. All rights reserved.
//

#import "MSBottomViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface MSBottomViewController ()

@end

@implementation MSBottomViewController

@synthesize delegate = _delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super init];
    if (self) {
        _selectedUserArray = [[NSMutableArray alloc]initWithCapacity:0];
        _selectedUserImageButtonArray = [[NSMutableArray alloc]initWithCapacity:0];
        [self initViewWithFrame:frame];
    }
    return self;
}

- (void)initViewWithFrame:(CGRect)frame
{
//    UIView *view = [[UIView alloc]initWithFrame:frame];
    [self.view setFrame:frame];
    self.view.backgroundColor = [UIColor redColor];
    
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0.f, 0.f, 220.f, frame.size.height)];
    _scrollView.backgroundColor = [UIColor greenColor];
    [_scrollView setContentSize:CGSizeMake((10.f + ((_selectedUserArray.count + 1) * 40.f)), self.view.frame.size.height)];
    [self.view addSubview:_scrollView];
    
    _blankImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"dotted_box.png"]];
    [_blankImageView setFrame:CGRectMake(10, ((frame.size.height - 36.f)/2), 36.f, 36.f)];
    [_scrollView addSubview:_blankImageView];
    
    _commitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_commitButton setFrame:CGRectMake((frame.size.width - 80.f - 10.f), 10.f, 80.f, 40.f)];
    _commitButton.backgroundColor = [UIColor grayColor];
    [_commitButton setTitle:@"确定" forState:UIControlStateNormal];
    [_commitButton addTarget:self action:@selector(pressCommitButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_commitButton];
    
    return;
}

- (void)pressCommitButton:(id)sender
{
    NSLog(@"选择了%d个联系人。", _selectedUserArray.count);
    [_delegate MSBottomView:self.view pressCommitButton:(UIButton *)sender withSelectedUserArray:_selectedUserArray];
}

- (void)pressImageButton:(id)sender
{
    NSInteger index = [_selectedUserImageButtonArray indexOfObject:(UIButton *)sender];
    NSLog(@"点击了第%d个用户。", index);
    [self removeUserAtIndex:index];
    [_delegate MSBottomView:self.view didRemoveUserAtIndex:index];
}

- (CGRect)getFrameByIndex:(NSInteger)index
{
    CGRect frame = CGRectMake((10.f + index * 40.f), ((_scrollView.frame.size.height - 36.f)/2), 36.f, 36.f);
    return frame;
}

- (void)addUser:(id)user
{
    [_selectedUserArray addObject:user];
    
    UIImage *image = [_delegate MSBottomView:self.view imageForUser:user];
    UIButton *imageButton = [UIButton buttonWithType:UIButtonTypeCustom];
    imageButton.backgroundColor = [UIColor colorWithPatternImage:image];
    [imageButton setFrame:[self getFrameByIndex:(_selectedUserArray.count - 1)]];
    
    [imageButton addTarget:self action:@selector(pressImageButton:) forControlEvents:UIControlEventTouchUpInside];
    
    [_scrollView addSubview:imageButton];
    [_selectedUserImageButtonArray addObject:imageButton];
    
    [_scrollView setContentSize:CGSizeMake((10.f + ((_selectedUserArray.count + 1) * 40.f)), self.view.frame.size.height)];
    
//    [UIView beginAnimations:@"add" context:nil];
//    [UIView setAnimationDelay:0.3];
    [UIScrollView beginAnimations:@"add" context:nil];
    [UIScrollView setAnimationDelay:0.3];
    
    CGRect frame = _blankImageView.frame;
    frame.origin.x = 10.f + (_selectedUserArray.count * 40.f);
    [_blankImageView setFrame:frame];
    
    [UIScrollView commitAnimations];
//    [UIView commitAnimations];
    
//    // 准备动画
//    CATransition *animation = [CATransition animation];
//    //动画播放持续时间
//    [animation setDuration:0.5f];
//    //动画速度,何时快、慢
//    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
//    /*动画效果
//     kCATransitionFade      淡出
//     kCATransitionMoveIn    覆盖原图
//     kCATransitionPush      推出
//     kCATransitionReveal    底部显出来
//     */
//    [animation setType:kCATransitionFade];
//    [self.view.layer addAnimation:animation forKey:nil];
//    
//    //变更
//    
//    
//    // 结束动画
//    [UIView commitAnimations];
    
    [self resetCommitButtonTitle];
}

- (void)removeUserAtIndex:(NSInteger)index
{
    [_selectedUserArray removeObjectAtIndex:index];
    
    [[_selectedUserImageButtonArray objectAtIndex:index] removeFromSuperview];
    [_selectedUserImageButtonArray removeObjectAtIndex:index];
    
    [UIScrollView beginAnimations:@"remove" context:nil];
    [UIScrollView setAnimationDelay:0.3];
    
    CGRect frame = _blankImageView.frame;
    frame.origin.x = 10.f + (_selectedUserArray.count * 40.f);
    [_blankImageView setFrame:frame];
    
    [UIScrollView commitAnimations];
    
    [self resetCommitButtonTitle];
    [self reloadScrollView];
}

- (void)removeUser:(id)user
{
    NSInteger index = [_selectedUserArray indexOfObject:user];
    [self removeUserAtIndex:index];
}

- (void)reloadScrollView
{
    UIButton *imageButton;
    for (int i = 0; i < _selectedUserImageButtonArray.count; i++) {
        imageButton = [_selectedUserImageButtonArray objectAtIndex:i];
        [imageButton setFrame:[self getFrameByIndex:i]];
    }
}

- (void)resetCommitButtonTitle
{
    if (_selectedUserArray.count > 0) {
        _commitButton.backgroundColor = [UIColor blueColor];
        [_commitButton setTitle:[NSString stringWithFormat:@"确定(%d)", _selectedUserArray.count] forState:UIControlStateNormal];
    } else {
        _commitButton.backgroundColor = [UIColor grayColor];
        [_commitButton setTitle:@"确定" forState:UIControlStateNormal];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [_selectedUserArray release];
    _selectedUserArray = nil;
    [super dealloc];
}

@end
