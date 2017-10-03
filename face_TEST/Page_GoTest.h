//
//  Page_GoTest.h
//  face_TEST
//
//  Created by kf on 2016/4/17.
//  Copyright (c) 2016年 kf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YTPlayerView.h"
#import "YouTubeHelper.h"
@interface Page_GoTest : UIViewController<UITableViewDelegate,UITableViewDataSource,YouTubeHelperDelegate,UIAlertViewDelegate>

@property (assign, nonatomic) NSInteger index;
/*** 物件 ***/
@property IBOutlet UIView *Youtube;
@property(nonatomic, strong) IBOutlet YTPlayerView *playerView;
@property IBOutlet UIButton *btn_closeY,*btn_camera;
@property IBOutlet UITableView *table_notes;

/*** 變數 ***/
@property NSString *UserName,*UserUID,*UserQID;
@property NSMutableArray *Reply_Name,*Reply_Text,*Reply_Video,*ReplyFor_Name,*isNew,*Reply_time,*imgArr;

/*** Sub ***/
-(IBAction)btn_OnClick_Closer:(id)sender;
-(IBAction)img_OnClick_Opener:(id)sender;


/************  Page2  *********************/

/*** 物件 ***/


/*** 變數 ***/


/*** Sub ***/
-(IBAction)btn_Auth:(id)sender;


@end
