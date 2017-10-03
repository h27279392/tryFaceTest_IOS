//
//  Go_Test.h
//  face_TEST
//
//  Created by kf on 2016/4/17.
//  Copyright (c) 2016年 kf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Go_Test : UIViewController<UIPageViewControllerDataSource>

@property (strong, nonatomic) UIPageViewController *pageController;
@property IBOutlet UIView *content;
@property IBOutlet UIButton *btn_Back,*btn_upload;
@property IBOutlet UISegmentedControl *onetwo;

- (IBAction)valueChanged:(id)sender;
-(IBAction)btn_OnClick_back:(id)sender;

@end
