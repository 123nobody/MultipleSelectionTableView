//
//  MSSearchTableViewCell.h
//  MultipleSelectionTableViewDemo
//
//  Created by Wei on 12-12-19.
//  Copyright (c) 2012年 Wei. All rights reserved.
//

#import <UIKit/UIKit.h>

#define MS_SEARCH_TABLE_VIEW_CELL_HEIGHT 50.f

@interface MSSearchTableViewCell : UITableViewCell
{
	BOOL _isChecked;
    UIImageView *_photoImageView;
    UILabel *_nameLabel;
    UILabel *_checkLabel;
}

@property (nonatomic, readonly) BOOL isChecked;
@property (nonatomic, strong) UIImageView *photoImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *checkLabel;

@end
