//
//  MSTableViewCell.m
//  MultipleSelectionTableViewDemo
//
//  Created by Wei on 12-12-14.
//  Copyright (c) 2012年 Wei. All rights reserved.
//

#import "MSTableViewCell.h"

@implementation MSTableViewCell

@synthesize checkImageView = _checkImageView;
@synthesize photoImageView = _photoImageView;
@synthesize nameLabel = _nameLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        CGRect frame;
        
        _checkImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Unselected.png"]];
        frame = CGRectMake(10, (MS_TABLE_VIEW_CELL_HEIGHT - 29.f)/2, 29.f, 29.f);
        [_checkImageView setFrame:frame];
        [self addSubview:_checkImageView];
        
        
        _photoImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"user.png"]];
        frame.origin.x += frame.size.width + 10;
        frame.origin.y = (MS_TABLE_VIEW_CELL_HEIGHT - 48.f)/2;
        frame.size = CGSizeMake(48.f, 48.f);
        [_photoImageView setFrame:frame];
        [self addSubview:_photoImageView];
        
        
        frame.origin.x += frame.size.width + 10;
        frame.origin.y = (MS_TABLE_VIEW_CELL_HEIGHT - 20.f)/2;
        frame.size = CGSizeMake(200.f, 20.f);
        _nameLabel = [[UILabel alloc]initWithFrame:frame];
        _nameLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:_nameLabel];
    }
    return self;
}

- (void) setChecked:(BOOL)checked
{
	_isChecked = checked;
    
	if (_isChecked){
		_checkImageView.image = [UIImage imageNamed:@"Selected.png"];
	} else {
		_checkImageView.image = [UIImage imageNamed:@"Unselected.png"];
	}
}

- (void)dealloc
{
	[_checkImageView release];
	_checkImageView = nil;
	[_photoImageView release];
	_photoImageView = nil;
	[_nameLabel release];
	_nameLabel = nil;
    [super dealloc];
}

@end
