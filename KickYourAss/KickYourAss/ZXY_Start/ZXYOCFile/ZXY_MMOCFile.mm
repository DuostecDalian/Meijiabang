//
//  ZXY_MMOCFile.m
//  KickYourAss
//
//  Created by 宇周 on 15/1/22.
//  Copyright (c) 2015年 宇周. All rights reserved.
//

#import "ZXY_MMOCFile.h"
#import <Baidu-Maps-iOS-SDK/BMapKit.h>
@implementation ZXY_MMOCFile
static ZXY_MMOCFile *instance = nil;
+ (ZXY_MMOCFile *)sharedInstance
{
    static dispatch_once_t onece;
    dispatch_once(&onece, ^{
        if(instance == nil)
        {
            instance = [[super allocWithZone:NULL] init];
        }
    });
    return instance;
}

+ (id)allocWithZone:(NSZone *)zone
{
    return [self sharedInstance];
}

+ (id)copyWithZone:(NSZone *)zone
{
    return [self sharedInstance];
}

+ (id)mutableCopyWithZone:(NSZone *)zone
{
    return [self sharedInstance];
}

- (id)mutableCopy
{
    return [[ZXY_MMOCFile alloc] init];
}

- (id)copy
{
    return [[ZXY_MMOCFile alloc] init];
}

- (id)init
{
    if(instance)
    {
        return instance;
    }
    else
    {
        self = [super init];
        return self;
    }
}

- (BOOL)authordBDMap
{
    BMKMapManager *manager = [[BMKMapManager alloc] init];
    return [manager start:@"SbwxQMHWZzd0kT1cbkTMHtzV" generalDelegate:nil];
}

@end
