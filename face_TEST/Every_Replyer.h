//
//  Every_Replyer.h
//  face_TEST
//
//  Created by kf on 2016/5/1.
//  Copyright (c) 2016年 kf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Every_Replyer : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property IBOutlet UINavigationItem *nbar;
-(NSString *)getReply_who;
-(NSString *)getReply_QID;
@end
