//
//  GoTest_notes_item.m
//  face_TEST
//
//  Created by kf on 2016/4/17.
//  Copyright (c) 2016年 kf. All rights reserved.
//

#import "GoTest_notes_item.h"

@implementation GoTest_notes_item

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+(GoTest_notes_item *)item
{
    
    NSArray *items = [[NSBundle mainBundle] loadNibNamed:@"GoTest_notes_item" owner:nil options:nil];
    
    return items.lastObject;
}
@end
