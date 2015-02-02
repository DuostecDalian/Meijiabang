//
//  ZXY_ArtDetailInfoBase.h
//
//  Created by   on 15/1/30
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ZXY_ArtDetailInfoData;

@interface ZXY_ArtDetailInfoBase : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double result;
@property (nonatomic, strong) ZXY_ArtDetailInfoData *data;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
