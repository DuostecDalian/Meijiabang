//
//  ZXY_AlbumHotData.h
//
//  Created by   on 15/1/27
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ZXY_AlbumHotUser, ZXY_AlbumHotImage;

@interface ZXY_AlbumHotData : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) ZXY_AlbumHotUser *user;
@property (nonatomic, strong) NSString *albumId;
@property (nonatomic, strong) ZXY_AlbumHotImage *image;
@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *dataDescription;
@property (nonatomic, strong) NSString *agreeCount;
@property (nonatomic, strong) NSString *addTime;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
