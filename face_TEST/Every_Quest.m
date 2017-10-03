//
//  Every_Quest.m
//  face_TEST
//
//  Created by kf on 2016/4/14.
//  Copyright (c) 2016年 kf. All rights reserved.
//

#import "ViewController.h"
#import "Class_job.h"
#import "Every_Quest_item.h"

#import "Every_Quest.h"
#import "DBConnecter.h"
#import "Next_Page.h"


@interface Every_Quest ()

@end

@implementation Every_Quest

@synthesize UserName,UserUID,UserSelectedJob;
@synthesize QID,Quest_Text,Quest_Video,Teach_Name,isNew;
@synthesize btn_closeY,btn_enter,Youtube;
Every_Quest_item *cell;
int Previous_Selected=-100;
static NSString *UserQID;
-(void)viewDidAppear:(BOOL)animated
{
    Previous_Selected=-100;
}
-(void)viewDidDisappear:(BOOL)animated
{
    Previous_Selected=-100;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    btn_closeY.layer.borderColor=[UIColor colorWithRed:0.2 green:0.4 blue:0.7 alpha:1].CGColor;
    btn_closeY.layer.borderWidth=2;
    btn_closeY.layer.cornerRadius=5;
    btn_enter.layer.borderColor=[UIColor colorWithRed:0.2 green:0.4 blue:0.7 alpha:1].CGColor;
    btn_enter.layer.borderWidth=2;
    btn_enter.layer.cornerRadius=5;
    
    
    UserUID=[[ViewController alloc] UserUID];
    UserName=[[ViewController alloc] UserName];
    UserSelectedJob=[[Class_job alloc] Selected_Job];
    _nbar.title=[Class_job isjobname];
    NSString *Query_Quest=
[
  [
    [
    @"select name,QID,issue_text,issue_video,is_new FROM member,test_quest LEFT JOIN (select r_quest,count(r_who) as is_new from reply where r_who!=r_name AND pig_read=0 AND r_who=" stringByAppendingString:UserUID
    ]
    stringByAppendingString:
    [
     @" group by r_quest)as new1 ON r_quest=QID  where UID=who AND belong=" stringByAppendingString:UserSelectedJob
    ]
   
  ]
 stringByAppendingString:@" ORDER BY QID ASC"
];
  //  NSLog(@"%@",db_result);
    
    NSArray *db_result= [[DBConnecter alloc] QueryForSQL:Query_Quest];
        QID = [NSMutableArray arrayWithCapacity:[db_result count]];
        Quest_Text = [NSMutableArray arrayWithCapacity:[db_result count]];
        Quest_Video = [NSMutableArray arrayWithCapacity:[db_result count]];
        Teach_Name = [NSMutableArray arrayWithCapacity:[db_result count]];
        isNew = [NSMutableArray arrayWithCapacity:[db_result count]];
    [db_result enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop){
        NSDictionary* result = [db_result objectAtIndex:idx];
        
        [QID addObject:[result valueForKey:@"QID"]];
        [Quest_Text addObject:[result valueForKey:@"issue_text"]];
        [Quest_Video addObject:[result valueForKey:@"issue_video"]];
        [Teach_Name addObject:[result valueForKey:@"name"]];
        [isNew addObject:[result valueForKey:@"is_new"]];
    }];
    [self.playerView loadWithVideoId:@"4OrCA1OInoo"];
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
    return QID.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell = [Every_Quest_item cell];
    
    
    cell.txt_Quest.text=[[NSString alloc] initWithFormat:@"%d.    %@",indexPath.section+1,[Quest_Text objectAtIndex:indexPath.section]];
    cell.txt_TeachName.text=[Teach_Name objectAtIndex:indexPath.section];
    cell.backgroundColor=[UIColor colorWithRed:1 green:1 blue:1 alpha:0.75];
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
    cell.selectedBackgroundView.layer.cornerRadius=10;
    cell.selectedBackgroundView.backgroundColor = [UIColor colorWithRed:0.2 green:0.8 blue:1 alpha:0.3];
    cell.layer.cornerRadius=10;
    //cell.Every_Quest_cell.layer.cornerRadius=10;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UserQID=[QID objectAtIndex:indexPath.section];
    Youtube.hidden=false;
    if(indexPath.section==Previous_Selected)
    {
        
    }
    else
    {
        if([[Quest_Video objectAtIndex:indexPath.section] isEqualToString:@""])
            self.playerView.hidden=true;
        else
        {
            self.playerView.hidden=false;
            [self.playerView loadWithVideoId:[Quest_Video objectAtIndex:indexPath.section]];
            Previous_Selected=indexPath.section;
        }
    }
    
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat h=100;
    
    int lines = [[DBConnecter alloc] getlines:cell.txt_Quest];
    
    if(lines>3)
    {
        h+=(lines-3)*20;
        
    }
    return h;
}
-(void)btn_OnClick_Enter:(id)sender{
    [[Next_Page alloc] thisStoryBoard:@"Main" _GoTo:@"Go_Test" _thisPage:self];
}
-(void)btn_OnClick_Closer:(id)sender{
    Youtube.hidden=true;
}
-(NSString *)UserQID
{
    return UserQID;
}
-(IBAction)btn_OnClick_back:(id)sender
{
    [self dismissViewControllerAnimated:true completion:nil];
}
@end
