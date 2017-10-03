//
//  Every_Replyer.m
//  face_TEST
//
//  Created by kf on 2016/5/1.
//  Copyright (c) 2016年 kf. All rights reserved.
//

#import "Every_Replyer.h"
#import "DBConnecter.h"
#import "Next_Page.h"
#import "Teach_showQ.h"

@interface Every_Replyer ()

@end

@implementation Every_Replyer

NSMutableArray *Reply_item,*Reply_QID,*Reply_who1;
NSString *Select_Replyer,*Select_Reply_QID;

- (void)viewDidLoad {
    [super viewDidLoad];
   
    NSString *Query_Replyer=[[NSString alloc] initWithFormat:
@"select *,count(UID) from test_quest,reply,member where r_quest=QID AND r_name=UID AND r_name=r_who AND QID=%@ GROUP BY UID",[[Teach_showQ alloc] getQid]];
    _nbar.title=[[NSString alloc] initWithFormat:@"%@. %@"
                 ,[[Teach_showQ alloc] getQid],[[Teach_showQ alloc] getQtext]];
    
  
    
    NSArray *db_result= [[DBConnecter alloc] QueryForSQL:Query_Replyer];
    Reply_item = [NSMutableArray arrayWithCapacity:[db_result count]];
    Reply_QID = [NSMutableArray arrayWithCapacity:[db_result count]];
    Reply_who1 = [NSMutableArray arrayWithCapacity:[db_result count]];
    [db_result enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop){
        NSDictionary* result = [db_result objectAtIndex:idx];
        
        [Reply_item addObject:[[NSString alloc] initWithFormat:
                    @"%@  (%@)",[result valueForKey:@"name"],[result valueForKey:@"count(UID)"]]];
        [Reply_QID addObject:[result valueForKey:@"QID"]];
        [Reply_who1 addObject:[result valueForKey:@"r_name"]];
        
    }];
    

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

//下面都是实现UITableViewDelegate,UITableViewDataSource两个协议中定义的方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //返回行数
    return [Reply_item count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{//返回一行的视图
    NSUInteger row=[indexPath row];
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
    cell.textLabel.text=[Reply_item objectAtIndex:row];//设置文字
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
    Select_Reply_QID=[Reply_QID objectAtIndex:[indexPath row]];
    Select_Replyer=[Reply_who1 objectAtIndex:[indexPath row]];
    //取出被选中项的文字
    /* UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:string delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
     [alert show];*/
    [[Next_Page alloc] thisStoryBoard:@"Main" _GoTo:@"Go_Test" _thisPage:self];
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
    return 70.0;
}
-(IBAction)btn_back:(id)sender
{
    [self dismissViewControllerAnimated:true completion:nil];
}
-(NSString *)getReply_QID
{
    return Select_Reply_QID;
}
-(NSString *)getReply_who
{
    return Select_Replyer;
}
@end
