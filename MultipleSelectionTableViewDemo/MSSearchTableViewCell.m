//
//  MSSearchTableViewCell.m
//  MultipleSelectionTableViewDemo
//
//  Created by Wei on 12-12-19.
//  Copyright (c) 2012年 Wei. All rights reserved.
//

#import "MSSearchTableViewCell.h"

@implementation MSSearchTableViewCell

@synthesize photoImageView = _photoImageView;
@synthesize nameLabel = _nameLabel;
@synthesize checkLabel = _checkLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        CGRect frame = CGRectMake(10.f, ((MS_SEARCH_TABLE_VIEW_CELL_HEIGHT - 48.f)/2), 48, 48);
        
        _photoImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"user.png"]];
        [_photoImageView setFrame:frame];
        [self addSubview:_photoImageView];
        
        
        frame.origin.x += frame.size.width + 10;
        frame.origin.y = (MS_SEARCH_TABLE_VIEW_CELL_HEIGHT - 20.f)/2;
        frame.size = CGSizeMake(200.f, 20.f);
        _nameLabel = [[UILabel alloc]initWithFrame:frame];
        _nameLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:_nameLabel];
        
        frame.origin.x = 320 - 50 - 10;
        frame.origin.y = (MS_SEARCH_TABLE_VIEW_CELL_HEIGHT - 20.f)/2;
        frame.size = CGSizeMake(50.f, 20.f);
        _checkLabel = [[UILabel alloc]initWithFrame:frame];
        _checkLabel.font = [UIFont systemFontOfSize:12];
        _checkLabel.textColor = [UIColor grayColor];
        _checkLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:_checkLabel];
        
        
    }
    return self;
}

@end
