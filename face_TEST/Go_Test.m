//
//  Go_Test.m
//  face_TEST
//
//  Created by kf on 2016/4/17.
//  Copyright (c) 2016年 kf. All rights reserved.
//

#import "Go_Test.h"
#import "Next_Page.h"
#import "Page_GoTest.h"
@interface Go_Test ()

@end

@implementation Go_Test
@synthesize onetwo,btn_upload;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.pageController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    
    self.pageController.dataSource = self;
    [[self.pageController view] setFrame:[[self content] bounds]];
    
    Page_GoTest *initialViewController = [self viewControllerAtIndex:0];
    
    NSArray *viewControllers = [NSArray arrayWithObject:initialViewController];
    
    [self.pageController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    [self addChildViewController:self.pageController];
    [[self content] addSubview:[self.pageController view]];
    [self.pageController didMoveToParentViewController:self];
    
    onetwo.layer.cornerRadius=10;
    UIFont *font = [UIFont boldSystemFontOfSize:17.0f];
    NSDictionary *attributes = [NSDictionary dictionaryWithObject:font
                                                           forKey:NSFontAttributeName];
    [onetwo setTitleTextAttributes:attributes
                                    forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (Page_GoTest *)viewControllerAtIndex:(NSUInteger)index {
    Page_GoTest *childViewController;
    if(index==0)
    {
        childViewController = [[Page_GoTest alloc] initWithNibName:@"Page_GoTest_notes1" bundle:nil];
    }else
    {
        childViewController = [[Page_GoTest alloc] initWithNibName:@"Page_GoTest_video2" bundle:nil];
    }
    childViewController.index = index;
    return childViewController;
    
}
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    
    NSUInteger index = [(Page_GoTest *)viewController index];
    onetwo.selectedSegmentIndex=index;
    if (index == 0) {
        return nil;
    }
    
    index--;
    return [self viewControllerAtIndex:index];
    
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    
    NSUInteger index = [(Page_GoTest *)viewController index];
    onetwo.selectedSegmentIndex=index;
    
    index++;
    
    if (index == 2) {
        return nil;
    }
    
    return [self viewControllerAtIndex:index];
    
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController {
    // The number of items reflected in the page indicator.
    return 2;
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController {
    // The selected item reflected in the page indicator.
    return 0;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)valueChanged:(id)sender {
   /* NSLog(@"aaaaa");
    switch (onetwo.selectedSegmentIndex) {
        case 0:
            [self.pageController setViewControllers:[NSArray arrayWithObject:[self viewControllerAtIndex:0]] direction:UIPageViewControllerNavigationDirectionReverse animated:YES completion:nil];
            
            break;
        case 1:
            [self.pageController ];
        default:
            break;
    }*/
}
-(IBAction)btn_OnClick_back:(id)sender
{
    [self dismissViewControllerAnimated:true completion:nil];
}
-(IBAction)btn_OnClick_uploadTest:(id)sender
{
    [[Next_Page alloc] thisStoryBoard:@"Google_Auth" _GoTo:@"Google_Auth" _thisPage:self];
}
@end
