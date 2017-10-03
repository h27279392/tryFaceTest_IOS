//
//  Class_job.h
//  face_TEST
//
//  Created by kf on 2016/3/28.
//  Copyright (c) 2016年 kf. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface Class_job : UIViewController<UITableViewDelegate,UITableViewDataSource>


@property NSString *Selected_Class_Id;
@property NSString *Selected_Job_Id;
@property NSString *Select_Job_Name;
@property (strong,nonatomic) NSMutableArray *Job_id;
@property (strong,nonatomic) NSMutableArray *Job_name;
@property (strong,nonatomic) NSArray *Class_id;
@property (strong,nonatomic) NSArray *Class_name;
@property IBOutlet UINavigationItem *nbar;

-(NSString *)Selected_Job;
+(NSString *)isjobname;
@end
