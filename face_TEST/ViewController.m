//
//  ViewController.m
//  face_TEST
//
//  Created by kf on 2016/3/28.
//  Copyright (c) 2016年 kf. All rights reserved.
//

#import "ViewController.h"
#import "DBConnecter.h"
#import "UIView+Toast.h"
#import "Next_Page.h"
@interface ViewController ()



@end

@implementation ViewController
@synthesize edt_id,edt_pw;
static NSString *UserName,*UserUID,*UserCosplay;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor colorWithPatternImage: [UIImage imageNamed:@"bg_hello.png"] ];
    [[DBConnecter alloc] getServer_time];
    _btn_login.layer.borderColor=[UIColor colorWithRed:1 green:1 blue:1 alpha:1].CGColor;
    _btn_login.layer.borderWidth=1;
    _btn_login.layer.cornerRadius=10;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -物件事件
-(void)Btn_OnClick_login:(id)sender
{
    [self login];
}

#pragma mark -判斷登入
-(void)login
{
    
UserUID=nil;
UserName=nil;
UserCosplay=nil;

    if([edt_id.text isEqualToString:@""] || [edt_pw.text isEqualToString:@""])
    {
        [self.view makeToast:@"     帳號or密碼不能為空     "];
    }
      else
            {
                NSString *Query_idpw=
                            [
                                [@"select UID,Name,cosplay from member where id='" stringByAppendingString:edt_id.text]
                                      stringByAppendingString:
                                [[@"' and pwd='" stringByAppendingString:edt_pw.text] stringByAppendingString:@"'"]
                            ];
                NSArray *db_result= [[DBConnecter alloc] QueryForSQL:Query_idpw];
                if(![db_result isKindOfClass:[NSNull class]])
                {
                    [db_result enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop){
                        NSDictionary* result = [db_result objectAtIndex:idx];
                        UserUID=[result valueForKey:@"UID"];
                        UserName=[result valueForKey:@"Name"];
                        UserCosplay=[result valueForKey:@"cosplay"];
                    }];
    
               
                    if(UserCosplay==nil)
                    {
                        [self.view makeToast:@"     帳號或密碼輸入錯誤 ！     "];
                    }
                    else
                    {
                    [self change_storyboard];
                    }
                }
            }
}

#pragma mark-跳轉頁面
-(void)change_storyboard
{
    if([UserCosplay isEqualToString:@"學生"])
        {
    [[Next_Page alloc] thisStoryBoard:@"Main" _GoTo:@"Class_job" _thisPage:self];
    //[next_board.view makeToast:[[@"     " stringByAppendingString:UserName] stringByAppendingString:@" ,歡迎登入 ！    "]];
        }
    if([UserCosplay isEqualToString:@"老師"])
        {
    [[Next_Page alloc] thisStoryBoard:@"Main" _GoTo:@"Teach_showQ" _thisPage:self];
    //[self.view makeToast:[[@"     " stringByAppendingString:UserName] stringByAppendingString:@" ,歡迎登入 ！    "]];
        }
    
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if (![edt_id isExclusiveTouch]) {
        [edt_id resignFirstResponder];
    }
    if (![edt_pw isExclusiveTouch]) {
        [edt_pw resignFirstResponder];
    }
}

#pragma mark-靜態變數
-(NSString *)UserUID
{
    return UserUID;
}
-(NSString *)UserName
{
    return UserName;
}
-(NSString *)UserCosplay
{
    return UserCosplay;
}
@end
