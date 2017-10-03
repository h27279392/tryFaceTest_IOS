//
//  Every_Quest_item.m
//  Ctable
//
//  Created by kf on 2016/4/15.
//  Copyright (c) 2016年 kf. All rights reserved.
//

#import "Every_Quest_item.h"

@implementation Every_Quest_item

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
+(Every_Quest_item *)cell
{
    
    NSArray *items = [[NSBundle mainBundle] loadNibNamed:@"Every_Quest_item" owner:nil options:nil];
   
    return items.lastObject;
}
@end
