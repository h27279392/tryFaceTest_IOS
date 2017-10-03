//
//  Every_Quest_item.h
//  Ctable
//
//  Created by kf on 2016/4/15.
//  Copyright (c) 2016年 kf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Every_Quest_item : UITableViewCell
@property IBOutlet UILabel *txt_Quest;
@property IBOutlet UILabel * txt_TeachName;
@property IBOutlet UIView *Every_Quest_cell;
+ (Every_Quest_item *)cell;
@end
