//
//  CYMJUserInfoBase.h
//
//  Created by 超逸 李 on 15/2/6
//  Copyright (c) 2015 Duostec. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CYMJUserInfoData;

@interface CYMJUserInfoBase : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double result;
@property (nonatomic, strong) CYMJUserInfoData *data;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
