//
//  Google_AuthViewController.h
//  face_TEST
//
//  Created by kf on 2016/4/22.
//  Copyright (c) 2016年 kf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YouTubeHelper.h"
#import "GTLYouTube.h"
#import "PlayVideoView.h"
@interface Google_AuthViewController : UIViewController<YouTubeHelperDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property IBOutlet UILabel *txt_auth;
@property IBOutlet PlayVideoView *playvideoView;
@property IBOutlet UIProgressView * progressView;
@property IBOutlet UISlider *slider;
@property IBOutlet UITextField *edt_text;
@end
