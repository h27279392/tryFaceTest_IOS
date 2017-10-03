//
//  Class_job.m
//  face_TEST
//
//  Created by kf on 2016/3/28.
//  Copyright (c) 2016年 kf. All rights reserved.
//

#import "Class_job.h"
#import "DBConnecter.h"
#import "Next_Page.h"
#import "ViewController.h"
@interface Class_job ()

@end

@implementation Class_job
static NSString *Selected_Job,*Selected_jobname;
@synthesize Selected_Class_Id;
@synthesize Selected_Job_Id;
@synthesize Job_id,Job_name;

- (void)viewDidLoad {
    [super viewDidLoad];
    Selected_Job_Id=@"asd";
    NSString *Query_class=@"";
    NSString *Query_job=@"select job_id,job_name from job where job_class=6";
    
    _nbar.title=[[[ViewController alloc] UserName] stringByAppendingString:@"  ,您好 ！"];
    NSArray *db_result= [[DBConnecter alloc] QueryForSQL:Query_job];
    Job_id = [NSMutableArray arrayWithCapacity:[db_result count]];
    Job_name = [NSMutableArray arrayWithCapacity:[db_result count]];
    [db_result enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop){
        NSDictionary* result = [db_result objectAtIndex:idx];
        
        [Job_id addObject:[result valueForKey:@"job_id"]];
        [Job_name addObject:[result valueForKey:@"job_name"]];
      
    }];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

//下面都是实现UITableViewDelegate,UITableViewDataSource两个协议中定义的方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //返回行数
    return [Job_id count];
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
    cell.textLabel.text=[Job_name objectAtIndex:row];//设置文字
    UIImage *image=[UIImage imageNamed:@"57"];//读取图片,无需扩展名
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
    Selected_Job=[Job_id objectAtIndex:[indexPath row]];
    Selected_jobname=[Job_name objectAtIndex:[indexPath row]];
    //取出被选中项的文字
   /* UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:string delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [alert show];*/
    [[Next_Page alloc] thisStoryBoard:@"Main" _GoTo:@"Every_Quest" _thisPage:self];
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




-(NSString *)Selected_Job
{
    return Selected_Job;}
-(IBAction)btn_OnClick_back:(id)sender
{
    [self dismissViewControllerAnimated:true completion:nil];
}
+(NSString *)isjobname{
    return Selected_jobname;
}
@end
