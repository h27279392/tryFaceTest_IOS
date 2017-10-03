//
//  Teach_showQ.m
//  face_TEST
//
//  Created by kf on 2016/5/1.
//  Copyright (c) 2016年 kf. All rights reserved.
//

#import "Teach_showQ.h"
#import "ViewController.h"
#import "DBConnecter.h"
#import "Next_Page.h"
#import "YTPlayerView.h"

@interface Teach_showQ ()
@property IBOutlet YTPlayerView* ytview;
@property IBOutlet UIView *youtube;
@end

@implementation Teach_showQ

NSMutableArray *QID,*Q_text,*Q_video;
NSString *Selected_QID,*Selected_Q_text;
NSInteger *previous_Selected=-100;
-(void)viewDidDisappear:(BOOL)animated
{
    previous_Selected=-100;
}
-(void)viewDidAppear:(BOOL)animated
{
    previous_Selected=-100;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.ytview loadWithVideoId:@"XyzaMpAVm3s"];
    NSString *Query_TeachQ=[[NSString alloc] initWithFormat:
                            @"SELECT * FROM test_quest where who=%@ Order by(QID)"
                            ,[[ViewController alloc] UserUID]];
    _nbar.title=[[[ViewController alloc] UserName] stringByAppendingString:@"的題庫"];
    
    
    NSArray *db_result= [[DBConnecter alloc] QueryForSQL:Query_TeachQ];
    QID = [NSMutableArray arrayWithCapacity:[db_result count]];
    Q_text = [NSMutableArray arrayWithCapacity:[db_result count]];
    Q_video = [NSMutableArray arrayWithCapacity:[db_result count]];
    [db_result enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop){
        NSDictionary* result = [db_result objectAtIndex:idx];
        
        [QID addObject:[result valueForKey:@"QID"]];
        [Q_text addObject:[result valueForKey:@"issue_text"]];
        [Q_video addObject:[result valueForKey:@"issue_video"]];
        
    }];

    NSLog(@"ans:%@",db_result);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return QID.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{//返回一行的视图
    NSUInteger row=indexPath.section;
    NSString * tableIdentifier=@"Simple table";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:tableIdentifier];
    //当一行上滚在屏幕消失时，另一行从屏幕底部滚到屏幕上，如果新行可以直接使用已经滚出屏幕的那行，系统可以避免重新创建和释放视图，同一个TableView,所有的行都是可以复用的，tableIdentifier是用来区别是否属于同一TableView
    
    if(cell==nil)
    {
        //当没有可复用的空闲的cell资源时(第一次载入,没翻页)
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableIdentifier];
        //UITableViewCellStyleDefault 只能显示一张图片，一个字符串，即本例样式
        //UITableViewCellStyleSubtitle 可以显示一张图片，两个字符串，上面黑色，下面的灰色
        //UITableViewCellStyleValue1 可以显示一张图片，两个字符串，左边的黑色，右边的灰色
        //UITableViewCellStyleValue2 可以显示两个字符串，左边的灰色，右边的黑色
    }
    cell.textLabel.numberOfLines=0;
    cell.textLabel.text=[Q_text objectAtIndex:row];//设置文字
    UIImage *image=[[DBConnecter alloc] urlString_getImage:[Q_video objectAtIndex:row]];//读取图片,无需扩展名
    cell.imageView.image=image;//文字左边的图片
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame] ;
    cell.selectedBackgroundView.backgroundColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:0.5];
    //    cell.detailTextLabel.text=@"详细描述"; 适用于Subtitle，Value1，Value2样式
    //    cell.imageView.highlightedImage=image; 可以定义被选中后显示的图片
    return cell;
}

#pragma mark -item_OnClick
- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*//被选中前执行
     if ([indexPath row]==0) {
     //第一项不可选
     return nil;
     }*/
    return indexPath;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{//被选中后执行
    Selected_QID=[QID objectAtIndex:[indexPath row]];
    Selected_Q_text=[Q_text objectAtIndex:[indexPath row]];
    
    _youtube.hidden=false;
    if(indexPath.section==previous_Selected)
    {
        
    }
    else
    {
        if([[Q_video objectAtIndex:indexPath.section] isEqualToString:@""])
            self.ytview.hidden=true;
        else
        {
            self.ytview.hidden=false;
            [self.ytview loadWithVideoId:[Q_video objectAtIndex:indexPath.section]];
            previous_Selected=indexPath.section;
        }
    }

}

#pragma mark -item高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //返回每行的高度
    //CGFloat就是float
    /*
     其他可能常用的方法：
     - (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
     - (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
     以上分别返回table头和尾的高度
     
     - (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section;
     - (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section;
     上面两方法可以自定义table头和尾
     */
    return 100.0;
}


-(IBAction)btn_closer:(id)sender;
{
    _youtube.hidden=true;
}
-(IBAction)btn_go:(id)sender;
{
    [[Next_Page alloc] thisStoryBoard:@"Main" _GoTo:@"Every_Replyer" _thisPage:self];
}
-(void)btn_OnClick_back1:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(NSString *)getQid
{
    return Selected_QID;
}
-(NSString *)getQtext
{
    return Selected_Q_text;
}
@end
