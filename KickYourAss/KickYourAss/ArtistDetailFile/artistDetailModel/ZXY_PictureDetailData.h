//
//  ZXY_PictureDetailData.h
//
//  Created by   on 15/2/2
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ZXY_PictureDetailUser;

@interface ZXY_PictureDetailData : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *dataDescription;
@property (nonatomic, assign) double isCollect;
@property (nonatomic, strong) NSString *collectCount;
@property (nonatomic, strong) NSString *imgCount;
@property (nonatomic, strong) NSString *userId;
@property (nonatomic, assign) double isAtten;
@property (nonatomic, strong) NSString *agreeCount;
@property (nonatomic, strong) NSArray *images;
@property (nonatomic, assign) double isAgree;
@property (nonatomic, strong) NSString *addTime;
@property (nonatomic, strong) NSString *albumId;
@property (nonatomic, strong) ZXY_PictureDetailUser *user;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
