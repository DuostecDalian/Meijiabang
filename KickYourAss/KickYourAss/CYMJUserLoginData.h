//
//  CYMJUserLoginData.h
//
//  Created by 超逸 李 on 15/2/5
//  Copyright (c) 2015 Duostec. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface CYMJUserLoginData : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *nickName;
@property (nonatomic, strong) NSString *role;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
