//
//  ZXY_MMOCFile.h
//  KickYourAss
//
//  Created by 宇周 on 15/1/22.
//  Copyright (c) 2015年 宇周. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZXY_MMOCFile : NSObject
+ (ZXY_MMOCFile *)sharedInstance;
- (BOOL)authordBDMap;
@end
