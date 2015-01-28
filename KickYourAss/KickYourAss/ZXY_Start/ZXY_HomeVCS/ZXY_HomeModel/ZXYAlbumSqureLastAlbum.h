//
//  ZXYAlbumSqureLastAlbum.h
//
//  Created by   on 15/1/28
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ZXYAlbumSqureImage;

@interface ZXYAlbumSqureLastAlbum : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *nickName;
@property (nonatomic, strong) NSString *albumId;
@property (nonatomic, assign) id headImage;
@property (nonatomic, strong) NSString *collectCount;
@property (nonatomic, strong) NSString *role;
@property (nonatomic, strong) ZXYAlbumSqureImage *image;
@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *lastAlbumDescription;
@property (nonatomic, strong) NSString *agreeCount;
@property (nonatomic, strong) NSString *addTime;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
