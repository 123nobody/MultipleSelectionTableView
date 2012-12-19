//
//  ViewController.h
//  MultipleSelectionTableViewDemo
//
//  Created by Wei on 12-12-14.
//  Copyright (c) 2012年 Wei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MSTableViewController.h"

@interface ViewController : UIViewController <MSTableViewControllerDataSource, MSTableViewControllerDelegate, MSBottomViewControllerDelegate>
{
    NSDictionary *_dic;
//    MSBottomViewController *_bottomViewController;
//    MSTableView *_msTable;
}

@property (nonatomic, strong) NSDictionary *dic;

@end
