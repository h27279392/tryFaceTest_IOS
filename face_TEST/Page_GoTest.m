//
//  Page_GoTest.m
//  face_TEST
//
//  Created by kf on 2016/4/17.
//  Copyright (c) 2016年 kf. All rights reserved.
//

#import "Page_GoTest.h"
#import "Go_Test.h"
#import "GoTest_notes_item.h"
#import "ViewController.h"
#import "Every_Quest.h"
#import "DBConnecter.h"
#import "Next_Page.h"
#import "Every_Replyer.h"

@interface Page_GoTest ()

@property (strong) YouTubeHelper *youtubeHelper;

@end

@implementation Page_GoTest

NSString *Query_Reply,*Query_read;
GoTest_notes_item *item;
NSInteger Previous_Select=-100;
NSArray *temp_ans;
NSTimer *timer;
NSString *reply_who;


-(void)viewDidAppear:(BOOL)animated
{
     timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(updateTime:) userInfo:nil repeats:YES];
    Previous_Select=-100;
}
-(void)viewWillDisappear:(BOOL)animated
{
    [timer invalidate];
    timer = nil;
}
- (void)viewDidLoad {
    [super viewDidLoad];


    _UserUID=[[ViewController alloc] UserUID];
    _UserName=[[ViewController alloc] UserName];
    
    if([[[ViewController alloc] UserCosplay] isEqualToString:@"學生"])
    {
        reply_who=_UserUID;
        _UserQID=[[Every_Quest alloc] UserQID];
    }
    else
    {
        reply_who=[[Every_Replyer alloc] getReply_who];
        _UserQID=[[Every_Replyer alloc] getReply_QID];
        
    }
    Query_Reply=
    [
            [@"select name,issue_text,issue_video,r_text,r_video,r_time,r_name,pig_read from test_quest,reply,member where QID=r_quest AND r_name=UID AND QID=\"" stringByAppendingString:_UserQID
            ]
    stringByAppendingString:
        [
            [
             @"\" AND r_who=\"" stringByAppendingString:reply_who
            ]
     stringByAppendingString:@"\"  order by(r_time)"
         ]
     ];
  
    NSArray *db_result= [[DBConnecter alloc] QueryForSQL:Query_Reply];
    temp_ans=db_result;
    //NSLog(@"%@",db_result);
    
    _Reply_Name = [NSMutableArray arrayWithCapacity:[db_result count]];
    _Reply_Text = [NSMutableArray arrayWithCapacity:[db_result count]];
    _Reply_Video = [NSMutableArray arrayWithCapacity:[db_result count]];
    _ReplyFor_Name = [NSMutableArray arrayWithCapacity:[db_result count]];
    _Reply_time = [NSMutableArray arrayWithCapacity:[db_result count]];
    _isNew = [NSMutableArray arrayWithCapacity:[db_result count]];
    _imgArr=[NSMutableArray arrayWithCapacity:[db_result count]];
    [db_result enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop){
        NSDictionary* result = [db_result objectAtIndex:idx];
        
        [_Reply_Name addObject:[result valueForKey:@"name"]];
        [_Reply_Text addObject:[result valueForKey:@"r_text"]];
        [_Reply_Video addObject:[result valueForKey:@"r_video"]];
        [_ReplyFor_Name addObject:[result valueForKey:@"r_name"]];
        [_Reply_time addObject:[result valueForKey:@"r_time"]];
        [_isNew addObject:[result valueForKey:@"pig_read"]];
        if([[result valueForKey:@"r_video"] isKindOfClass:[NSNull class]])
        {
            [_imgArr addObject:@"9"];
        }else
        {
            [_imgArr addObject:[[DBConnecter alloc] urlString_getImage:[result valueForKey:@"r_video"]]];
        }

   // NSLog(@"%@,%@,%@,%@,%@",[result valueForKey:@"name"],[result valueForKey:@"r_text"],[result valueForKey:@"r_video"],[result valueForKey:@"r_name"],[result valueForKey:@"pig_read"]);
    }];

   
}


-(void)updateTime:(NSTimer *)timer
{
    NSLog(@"time is run...%@",[DBConnecter isRun]? @"Y":@"N");
    
if([DBConnecter isRun])
{}
    else
{
    NSArray *db_result= [[DBConnecter alloc] QueryForSQL:Query_Reply];


  if([temp_ans isEqualToArray:db_result])
  {
     // NSLog(@"沒心資料");
  }
  else
  {
    _Reply_Name = [NSMutableArray arrayWithCapacity:[db_result count]];
    _Reply_Text = [NSMutableArray arrayWithCapacity:[db_result count]];
    _Reply_Video = [NSMutableArray arrayWithCapacity:[db_result count]];
    _ReplyFor_Name = [NSMutableArray arrayWithCapacity:[db_result count]];
    _Reply_time = [NSMutableArray arrayWithCapacity:[db_result count]];
    _isNew = [NSMutableArray arrayWithCapacity:[db_result count]];
    _imgArr=[NSMutableArray arrayWithCapacity:[db_result count]];
      
    [db_result enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop){
        NSDictionary* result = [db_result objectAtIndex:idx];
        
        [_Reply_Name addObject:[result valueForKey:@"name"]];
        [_Reply_Text addObject:[result valueForKey:@"r_text"]];
        [_Reply_Video addObject:[result valueForKey:@"r_video"]];
        [_ReplyFor_Name addObject:[result valueForKey:@"r_name"]];
        [_Reply_time addObject:[result valueForKey:@"r_time"]];
        [_isNew addObject:[result valueForKey:@"pig_read"]];
        
        if([[result valueForKey:@"r_video"] isKindOfClass:[NSNull class]])
        {
            [_imgArr addObject:@"9"];
        }else
        {
            UIImage *img=[[DBConnecter alloc] urlString_getImage:[result valueForKey:@"r_video"]];
            if(img!=nil)
            [_imgArr addObject:img];
            else
                [_imgArr addObject:@"等YT"];
        }
        // NSLog(@"%@,%@,%@,%@,%@",[result valueForKey:@"name"],[result valueForKey:@"r_text"],[result valueForKey:@"r_video"],[result valueForKey:@"r_name"],[result valueForKey:@"pig_read"]);
    }];
      
      [self.table_notes reloadData];
      temp_ans=db_result;
      //NSLog(@"有新資料");
      
  }
}
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - TableView Delegate Methods
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _Reply_Name.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    item = [GoTest_notes_item item];
    
    item.txt_RName.text=[_Reply_Name objectAtIndex:indexPath.section];
    item.txt_RText.text=[_Reply_Text objectAtIndex:indexPath.section];
    item.txt_Rtime.text=[_Reply_time objectAtIndex:indexPath.section];
   // item.img_Youtube.image=[[DBConnecter alloc] urlString_getImage:@"4OrCA1OInoo"];
if([[_imgArr objectAtIndex:indexPath.section] isEqual:@"9"])
{}else
{
    if([[_imgArr objectAtIndex:indexPath.section] isEqual:@"等YT"])
    {
        item.img_Youtube.image=[[DBConnecter alloc] urlString_getImage:[_Reply_Video objectAtIndex:indexPath.section]];
    }else
    item.img_Youtube.image=[_imgArr objectAtIndex:indexPath.section];
}
    
       item.img_Youtube.contentMode=UIViewContentModeScaleAspectFit;
    item.backgroundColor=[UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:0.49];
    item.selectedBackgroundView = [[UIView alloc] initWithFrame:item.frame];
    item.selectedBackgroundView.layer.cornerRadius=10;
    item.selectedBackgroundView.backgroundColor = [UIColor colorWithRed:0.2 green:0.8 blue:1 alpha:0.3];
    item.layer.cornerRadius=10;
    //cell.Every_Quest_cell.layer.cornerRadius=10;
    
    return item;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([[_Reply_Video objectAtIndex:indexPath.section] isKindOfClass:[NSNull class]])
    {}
    else
    {
        if(item.img_Youtube.image==nil)
        {
            item.img_Youtube.image=[[DBConnecter alloc] urlString_getImage:[_Reply_Video objectAtIndex:indexPath.section]];
            NSLog(@"gegetgetgetget");
        }
        
        _Youtube.hidden=false;
        if(indexPath.section==Previous_Select)
        {}
        else
        {
            self.playerView.hidden=false;
            [self.playerView loadWithVideoId:[_Reply_Video objectAtIndex:indexPath.section]];
            Previous_Select=indexPath.section;
            NSLog(@"youtube已準備好");
        }
        
    }
    
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat h=150;
         /*
     if(lines>5)
     {
     h+=(lines-5)*20;
     
     }*/
    return h;
}


-(void)btn_OnClick_Closer:(id)sender
{
    _Youtube.hidden=true;
}
-(IBAction)call_camera:(id)sender
{
    [[Next_Page alloc] thisStoryBoard:@"Google_Auth" _GoTo:@"Google_Auth" _thisPage:self];
    }
-(IBAction)delete:(id)sender
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@""
                                                        message:@"確定要刪除此紀錄？"
                                                       delegate:self
                                              cancelButtonTitle:@"No"
                                              otherButtonTitles:@"Yes",nil];
    [alertView show];

}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
            break;
            case 1:
            
            
            NSLog(@"okoko");
            break;
            
        default:
            break;
    }
}

@end
