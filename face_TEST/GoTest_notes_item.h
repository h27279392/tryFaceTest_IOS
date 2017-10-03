//
//  GoTest_notes_item.h
//  face_TEST
//
//  Created by kf on 2016/4/17.
//  Copyright (c) 2016年 kf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GoTest_notes_item : UITableViewCell
@property IBOutlet UILabel *txt_RName,*txt_RText,*txt_Rtime;
@property IBOutlet UIImageView *img_Youtube;
+ (GoTest_notes_item *)item;
@end
