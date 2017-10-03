//
//  Google_AuthViewController.m
//  face_TEST
//
//  Created by kf on 2016/4/22.
//  Copyright (c) 2016年 kf. All rights reserved.
//

#import "Google_AuthViewController.h"
#import "GTMOAuth2Authentication.h"
#import "ViewController.h"
#import "Every_Quest.h"
#import "DBConnecter.h"
#import "Every_Replyer.h"
@interface Google_AuthViewController ()
@property (strong) YouTubeHelper *youtubeHelper;
@end

@implementation Google_AuthViewController

UIImagePickerController *imagePicker;
NSURL *videoURL;
AVPlayerItem *playerItem;
bool *block_isRun=false;
NSThread *thread1;
NSString *youtube_ID;
NSString *uName,*uUID,*uQID,*Reply_who;
NSString *Query_add;
//判斷slider是否按下，
BOOL isOpen;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    // Do any additional setup after loading the view.
    self.youtubeHelper = [[YouTubeHelper alloc] initWithDelegate:self];
    imagePicker = [[UIImagePickerController alloc] init];
    _slider.hidden=true;
    
    [self check_];
   [self layout];
}
-(void)layout{
  
   
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)check_{
   /* if(Is_every_teach.thisQ.indexOf('s')==-1)
    {
        thisQ =Is_every.thisQ;
        Iam  =Hello_login.Iam;
        who=Iam;
        read="update reply set pig_read='1' where r_name!=r_who AND r_who="+Hello_login.Iam+" AND r_quest='"+thisQ+"' AND pig_read='0'";
    }
    else
    {
        thisQ =Is_every_teach.thisQ.substring(1);
        Iam   =Hello_login.Iam;
        who   =Is_every_teach.Who;
        read="update reply set pig_read='1' where r_name=r_who AND r_who="+who+" AND r_quest='"+thisQ+"' AND pig_read='0'";
    }*/
    if([[[ViewController alloc] UserCosplay] isEqual:@"學生"])
    {
        uUID=[[ViewController alloc] UserUID];
        uName=[[ViewController alloc] UserName];
        uQID=[[Every_Quest alloc] UserQID];
        Reply_who=uUID;
    }
    else
    {
        uUID=[[ViewController alloc] UserUID];
        uName=[[ViewController alloc] UserName];
        uQID=[[Every_Replyer alloc] getReply_QID];
        Reply_who=[[Every_Replyer alloc] getReply_who];
    }
    NSLog(@"%@身份",[[ViewController alloc] UserCosplay]);
}

// 按下[拍照]按鈕
-(IBAction) takePicture:(UIButton *) sender {
    [self.playvideoView.player pause];
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if(authStatus == AVAuthorizationStatusAuthorized || authStatus == AVAuthorizationStatusNotDetermined)
    {
        
        imagePicker.sourceType =  UIImagePickerControllerCameraDeviceFront;
        imagePicker.delegate = self;
        imagePicker.allowsEditing = YES;
        //NSArray *mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:imagePicker.sourceType];
        imagePicker.mediaTypes= [[NSArray alloc] initWithObjects:@"public.movie",nil];
        
        [imagePicker setVideoQuality:UIImagePickerControllerQualityTypeLow];  //設定影片品質
        [imagePicker setVideoMaximumDuration:60];  //設定最大錄影時間(秒)
        // 顯示相機功能
        [self presentViewController:imagePicker animated:YES completion:nil];
        
    } else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"無法存取相機" message:@"請至 設定>隱私權 中開啟權限" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
        
        [alert show];
    }
}
-(IBAction)Picker:(id)sender
{
    [self.playvideoView.player pause];
    imagePicker.sourceType =  UIImagePickerControllerSourceTypePhotoLibrary;
    imagePicker.mediaTypes= [[NSArray alloc] initWithObjects:@"public.movie",nil];
    imagePicker.delegate = self;
[self presentViewController:imagePicker animated:YES completion:nil];
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
 
        NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    if(imagePicker.sourceType ==  UIImagePickerControllerCameraDeviceFront)
    {
        if ([mediaType isEqualToString:@"public.movie"])
        {  //來源為影片
            videoURL = [info objectForKey:UIImagePickerControllerMediaURL];
            UISaveVideoAtPathToSavedPhotosAlbum(videoURL.path, self, nil, nil);
            //  NSData *videoData = [NSData dataWithContentsOfURL:videoURL];
        }else if ([mediaType isEqualToString:@"public.image"])
        {  //來源為圖片
            UIImage *img = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
            UIImageWriteToSavedPhotosAlbum(img, nil, nil, nil);
        }

    }
    else
    {
        if ([mediaType isEqualToString:@"public.movie"])
        {  //來源為影片
            videoURL = [info objectForKey:UIImagePickerControllerMediaURL];
            
            [self bye];
            
            playerItem  = [[AVPlayerItem alloc]initWithURL:videoURL];
            AVPlayer * player = [AVPlayer playerWithPlayerItem:playerItem];
            self.playvideoView.player = player;
            self.playvideoView.playerLayer.videoGravity = AVLayerVideoGravityResizeAspect;
            [self.playvideoView.player seekToTime:kCMTimeZero];
            [self.playvideoView.player play];
            
            [playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
        
            //觀察緩存現在的進度，KVO進行觀察，觀察loadedTimeRanges
        [playerItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];
           
        }
    }
    
        [picker dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)btn_OnClick_Send:(id)sender {
   /*
    if (mFileURI != null) {
        
        tmp_text=edt_rtext.getText().toString();
        query_add="INSERT INTO reply (r_name, r_who,r_quest,r_time,r_text,r_video) VALUES ("+Iam+","+who+",'"+thisQ+"','"+Server_Time+"','"+tmp_text+"',";
        
    
        
       
        Ytitle=Server_Time+"__"+Ytitle;
        uploadIntent.putExtra("Youtubetitle", Ytitle);
        startService(uploadIntent);
        teach_update_time();
        Toast.makeText(Create_Ans.this, R.string.youtube_upload_started,
                       Toast.LENGTH_LONG).show();
        
        Ytitle="";
        mFileURI = null;
        edt_rtext.setText("");
        edt_path.setText("");
        imbtn_del.setVisibility(View.INVISIBLE);
        vv_lookAns.setVisibility(View.INVISIBLE);
        txt_title.setVisibility(View.VISIBLE);
        
        showAlert("≠±∏’µ™Æ◊•ø¶b§W∂«");
    */
    

    if(videoURL!=nil && ![_edt_text.text isEqualToString:@""])
    {
    if([self.youtubeHelper isAuthValid])
      {
        [self bye];
        _slider.hidden=true;
        playerItem=nil;
        self.playvideoView.player=nil;
        
        NSString *server_time=[[DBConnecter alloc] getServer_time];
        Query_add=
            [[NSString alloc] initWithFormat:
             @"INSERT INTO reply (r_name, r_who,r_quest,r_time,r_text,r_video) VALUES (%@,%@,\'%@\',\'%@\',\'%@\',"
             ,uUID,Reply_who,uQID,server_time,_edt_text.text];
        
        _edt_text.text=@"";
        
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
        [self.youtubeHelper uploadPrivateVideoWithTitle:[[NSString alloc] initWithFormat:@"%@  模擬面試 題目：%@",server_time,uQID]
                                                description:@"模擬面試"
                                         commaSeperatedTags:@""
                                                    andPath:videoURL.path];
            [NSThread sleepForTimeInterval:2];
           while(1)
           {
               
               if([YouTubeHelper getlock])
            {
                [NSThread sleepForTimeInterval:2];
            }
               else
               {
                   NSLog(@"get vid");
                   break;
               }
           }
            
            [self setYTID:[YouTubeHelper getYID]];
            //NSLog(@"%@ok",[YouTubeHelper getYID]);
        
            dispatch_async(dispatch_get_main_queue(), ^{
                if(youtube_ID!=nil)
                {
                    [[DBConnecter alloc] QueryForSQL:
                     [Query_add stringByAppendingString:[[NSString alloc] initWithFormat:@"\'%@\')",youtube_ID]]];
                    NSLog(@"%@",[Query_add stringByAppendingString:[[NSString alloc] initWithFormat:@"\'%@\')",youtube_ID]]);
                    
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@""
                                                                        message:@"上傳完成！"
                                                                       delegate:self
                                                              cancelButtonTitle:@"Cancel"
                                                              otherButtonTitles: nil];
                    [alertView show];
                    Query_add=nil;
                    youtube_ID=nil;
                    videoURL=nil;
                }
            });
        
        });
      }else {
          UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@""
                                                              message:@"請登入授權.."
                                                             delegate:self
                                                    cancelButtonTitle:@"Cancel"
                                                    otherButtonTitles: nil];
          [alertView show];
            }
    }else
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@""
                                                            message:@"請輸入內容和影片.."
                                                           delegate:self
                                                  cancelButtonTitle:@"Cancel"
                                                  otherButtonTitles: nil];
        [alertView show];
 
    }
    
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if (![_edt_text isExclusiveTouch]) {
        [_edt_text resignFirstResponder];
    }
    
}
-(void) setYTID:(NSString *)yid{
    youtube_ID=yid;
}
- (IBAction)authenticateTapped:(id)sender {
    [self.playvideoView.player pause];
    _txt_auth.text=[_youtubeHelper authenticate];
    
}

#pragma mark YouTubeHelper Delegate

- (NSString *)youtubeAPIClientID
{
    return @"156236237120-pkmks32rn1mplbobdrca4qae5ugoekd5.apps.googleusercontent.com";
}

- (NSString *)youtubeAPIClientSecret
{
    return @"";
}

- (void)showAuthenticationViewController:(UIViewController *)authView;
{
    [self.navigationController pushViewController:authView animated:YES];
}

- (void)authenticationEndedWithError:(NSError *)error;
{
    NSString *error1;
    NSLog(@"Error %@", error.description);
    if(error.description==nil)
       error1=@"完成認證";
    else
        error1=error.description;
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:error1 delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
    
    [alert show];
}

-(void)bye
{
    [playerItem removeObserver:self forKeyPath:@"status" context:nil];
    [playerItem removeObserver:self forKeyPath:@"loadedTimeRanges" context:nil];
    [self.playvideoView.player removeTimeObserver:thread1];
}
- (void)uploadProgressPercentage:(int)percentage;
{
    _progressView.progress=percentage/100;
    NSLog(@"    Data uploaded: %d", percentage);
}
-(IBAction)btn_OnClick_back:(id)sender
{
    [self dismissViewControllerAnimated:true completion:nil];
}
-(IBAction)btn_OnClick_close:(id)sender
{
    [self bye];
    _slider.hidden=true;
    videoURL=nil;
    playerItem=nil;
    self.playvideoView.player=nil;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/








//觀察是否播放
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if ([keyPath isEqualToString:@"status"]) {
        if (playerItem.status == AVPlayerStatusReadyToPlay) {
            NSLog(@"開始播放");
            _slider.hidden=false;
            
            [self loadData];
        }else{
            NSLog(@"播放失敗");
        }
    }else{
        //kvo觸發的另外一個屬性
        NSArray *array = [playerItem loadedTimeRanges];
        //獲取範圍i
        CMTimeRange range = [array.firstObject CMTimeRangeValue];
        //從哪兒開始的
        CGFloat start = CMTimeGetSeconds(range.start);
        //緩存了多少
        CGFloat duration = CMTimeGetSeconds(range.duration);
        //一共緩存了多少
        CGFloat allCache = start+duration+10;
        NSLog(@"緩存了多少數據：%f",allCache);
        
        //設置緩存的百分比
        CMTime allTime = [playerItem duration];
        //轉換
        CGFloat time = CMTimeGetSeconds(allTime);
        CGFloat y = allCache/time;
        NSLog(@"緩存百分比：--------%f",y);
        
    }
}


#pragma mark -- 獲取播放數據
- (void)loadData{
   AVPlayerItem *xx = playerItem;
   UISlider *cc = _slider;
    //第一個參數是每隔多長時間調用一次，在這裡設置的是每隔1秒調用一次
     thread1=[self.playvideoView.player addPeriodicTimeObserverForInterval:CMTimeMake(1, 1) queue:NULL usingBlock:^(CMTime t) {
        //當前播放時間
        //NSLog(@"%f",CMTimeGetSeconds(t)) ;
        CGFloat current = (CGFloat)playerItem.currentTime.value/(CGFloat)playerItem.currentTime.timescale;
        
        //獲取總時長
        CMTime time1 = playerItem.duration;
        float x = CMTimeGetSeconds(time1);
       // NSLog(@"當前播放的秒數------- %f --------%f",current,x);
        
        //設置滑動條進度
        float v = current/x;
        
        //判斷slider是否按下，按下去就先別賦值
        if (!isOpen) {
            cc.value = v;
        }
       
    }];
    

}


- (IBAction)sliderClick:(UISlider *)slider{
    NSLog(@"添加點擊事件");
    isOpen = YES;
}
- (IBAction)sliderClickUp:(UISlider *)slider{
    NSLog(@"抬起來的事件");
    isOpen = NO;
    
    //從這裡開始播放
    CGFloat g = slider.value;
    //獲取總時長
    CMTime time1 = playerItem.duration;
    float x = CMTimeGetSeconds(time1);
    //進行播放
    [self.playvideoView.player seekToTime:CMTimeMake(x * g,1)];
    //播放
    [self.playvideoView.player play];
    
}





@end
