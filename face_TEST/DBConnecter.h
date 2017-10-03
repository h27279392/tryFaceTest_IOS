//
//  DBConnecter.h
//  face_test
//
//  Created by kf on 2016/3/24.
//  Copyright (c) 2016年 kf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIKit/UIKit.h"
@interface DBConnecter : NSObject
@property NSArray *result;
-(NSArray *) QueryForSQL:(NSString *)query_string;
+(BOOL *) isRun;
-(NSInteger *) getlines:(UILabel *)label;
-(UIImage *)urlString_getImage:(NSString *)url_String;
-(NSString *)getServer_time;
@end
