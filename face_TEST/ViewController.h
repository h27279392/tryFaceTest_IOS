//
//  ViewController.h
//  face_TEST
//
//  Created by kf on 2016/3/28.
//  Copyright (c) 2016年 kf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property IBOutlet UITextField *edt_id,*edt_pw;
@property IBOutlet UIButton *btn_login;

- (IBAction)Btn_OnClick_login:(id)sender;
- (void)login;
- (void)change_storyboard;

-(NSString *)UserName;
-(NSString *)UserUID;
-(NSString *)UserCosplay;
@end

