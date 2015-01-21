//
//  ZXYData.h
//
//  Created by   on 15/1/21
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ZXYData : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *p;
@property (nonatomic, strong) NSString *headImage;
@property (nonatomic, strong) NSString *longitude;
@property (nonatomic, strong) NSString *nickName;
@property (nonatomic, strong) NSString *latitude;
@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *albumCount;
@property (nonatomic, strong) NSArray *image;
@property (nonatomic, strong) NSString *role;
@property (nonatomic, strong) NSString *score;
@property (nonatomic, strong) NSString *isPass;
@property (nonatomic, assign) double isAttention;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
