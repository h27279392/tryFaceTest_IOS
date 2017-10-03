//
//  Every_Quest.h
//  face_TEST
//
//  Created by kf on 2016/4/14.
//  Copyright (c) 2016年 kf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YTPlayerView.h"
@interface Every_Quest : UIViewController
/*** 物件 ***/
@property IBOutlet UIView *Youtube;
@property(nonatomic, strong) IBOutlet YTPlayerView *playerView;
@property IBOutlet UIButton *btn_closeY,*btn_enter;
@property IBOutlet UINavigationItem *nbar;

/*** 變數 ***/
@property NSString *UserName,*UserUID,*UserSelectedJob;
@property NSMutableArray *QID,*Quest_Text,*Quest_Video,*Teach_Name,*isNew;

/*** Sub ***/
-(IBAction)btn_OnClick_Enter:(id)sender;
-(IBAction)btn_OnClick_Closer:(id)sender;
-(NSString *)UserQID;
@end
