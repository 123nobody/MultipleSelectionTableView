//
//  MSTableViewCell.h
//  MultipleSelectionTableViewDemo
//
//  Created by Wei on 12-12-14.
//  Copyright (c) 2012年 Wei. All rights reserved.
//

#import <UIKit/UIKit.h>

#define MS_TABLE_VIEW_CELL_HEIGHT 70.f

@interface MSTableViewCell : UITableViewCell
{
	BOOL _isChecked;
    UIImageView *_checkImageView;
    UIImageView *_photoImageView;
    UILabel *_nameLabel;
}

@property (nonatomic, readonly) BOOL isChecked;
@property (nonatomic, strong) UIImageView *checkImageView;
@property (nonatomic, strong) UIImageView *photoImageView;
@property (nonatomic, strong) UILabel *nameLabel;

- (void) setChecked:(BOOL)checked;

@end
