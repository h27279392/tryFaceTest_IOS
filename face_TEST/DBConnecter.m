//
//  DBConnecter.m
//  face_test
//
//  Created by kf on 2016/3/24.
//  Copyright (c) 2016年 kf. All rights reserved.
//

#import "DBConnecter.h"

@implementation DBConnecter
bool isRun=false;
-(NSArray *)QueryForSQL:(NSString *)query_string{
    
    isRun=true;
    NSError *error=[NSError alloc];
    NSURL *url = [NSURL URLWithString:@"http://chentopic.no-ip.info/go_db_ios.php"];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    NSString *query = [@"query_string=" stringByAppendingString:query_string];
    NSData *data = [query dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:data];
    NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    if(received!=nil)
    _result = [NSJSONSerialization JSONObjectWithData:received options:NSJSONWritingPrettyPrinted error:nil];
    isRun=false;
    
    
    if ([error code] == kCFURLErrorNotConnectedToInternet) {
        // if we can identify the error, we can present a more precise message to the user.
        NSDictionary *userInfo = [NSDictionary dictionaryWithObject:@"Connection Failed"
                                                             forKey:NSLocalizedDescriptionKey];
        
        NSError *noConnectionError = [NSError errorWithDomain:NSCocoaErrorDomain
                                                         code:kCFURLErrorNotConnectedToInternet
                                                     userInfo:userInfo];
        [self handleError:noConnectionError];
        
    }
    
    
    
       return _result;
   // NSString *str1 = [[NSString alloc]initWithData:received encoding:NSUTF8StringEncoding];
   // NSLog(@"%@",str1);
    
}

-(NSString *)getServer_time
{
    NSError *error=[NSError alloc];
    NSURL *url = [NSURL URLWithString:@"http://chentopic.no-ip.info/server_time.php"];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    if(received!=nil)
        _result = [[NSString alloc] initWithData:received encoding:NSUTF8StringEncoding];
    
    if ([error code] == kCFURLErrorNotConnectedToInternet) {
        // if we can identify the error, we can present a more precise message to the user.
        NSDictionary *userInfo = [NSDictionary dictionaryWithObject:@"Connection Failed"
                                                             forKey:NSLocalizedDescriptionKey];
        
        NSError *noConnectionError = [NSError errorWithDomain:NSCocoaErrorDomain
                                                         code:kCFURLErrorNotConnectedToInternet
                                                     userInfo:userInfo];
        [self handleError:noConnectionError];
    }
    return _result;
}

- (void)handleError:(NSError *)error
{
    NSString *errorMessage = [error localizedDescription];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@""
                                                        message:errorMessage
                                                       delegate:self
                                              cancelButtonTitle:@"Cancel"
                                              otherButtonTitles: nil];
    [alertView show];
}


+(BOOL *) isRun
{
    return isRun;
}
-(NSInteger *)getlines:(UILabel *)label
{
    int lines = [label.text sizeWithFont:label.font constrainedToSize:label.frame.size].height /label.font.pointSize;
    
    return lines;
}

-(UIImage *)urlString_getImage:(NSString *)url_String
{
    NSURL *url = [NSURL URLWithString:[[@"http://img.youtube.com/vi/" stringByAppendingString:url_String] stringByAppendingString:@"/0.jpg"]];
    UIImage *urlImage = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:url]];
   /*
    UIGraphicsBeginImageContext(CGSizeMake(200, 200));
    
    //將原始影像重繪在此範圍中
    [urlImage drawInRect:CGRectMake(0, 0, 200, 200)];
    
    //以目前的ImageContext來製作新的UIImage
    UIImage *resizeImage =UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    */
    return urlImage;
}
@end
