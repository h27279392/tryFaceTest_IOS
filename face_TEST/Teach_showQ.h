//
//  Teach_showQ.h
//  face_TEST
//
//  Created by kf on 2016/5/1.
//  Copyright (c) 2016年 kf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Teach_showQ : UIViewController<UITableViewDelegate,UITableViewDataSource>

//物件
@property IBOutlet UINavigationItem *nbar;

//變數


//方法
-(IBAction)btn_OnClick_back1:(id)sender;
-(NSString *)getQid;
-(NSString *)getQtext;
@end
