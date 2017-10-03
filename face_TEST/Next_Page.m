//
//  Next_Page.m
//  face_TEST
//
//  Created by kf on 2016/4/14.
//  Copyright (c) 2016年 kf. All rights reserved.
//

#import "Next_Page.h"

@implementation Next_Page

-(void)thisStoryBoard:(NSString *)thisSB _GoTo:(NSString *)nextPage _thisPage:(UIViewController *)thisPage
{
    
    UIStoryboard *this_board = [UIStoryboard storyboardWithName:thisSB bundle:nil];
    UIViewController *next_board = [this_board instantiateViewControllerWithIdentifier:nextPage];

    if(next_board!=nil)
    {
        [thisPage presentModalViewController:next_board animated:YES];
    }

    
}
@end

