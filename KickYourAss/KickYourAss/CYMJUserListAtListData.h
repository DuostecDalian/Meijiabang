//
//  CYMJUserListAtListData.h
//
//  Created by 超逸 李 on 15/2/10
//  Copyright (c) 2015 Duostec. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface CYMJUserListAtListData : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *nickName;
@property (nonatomic, strong) NSString *score;
@property (nonatomic, strong) NSString *headImage;
@property (nonatomic, strong) NSString *longitude;
@property (nonatomic, strong) NSString *orderCount;
@property (nonatomic, strong) NSString *orderCount2;
@property (nonatomic, strong) NSString *latitude;
@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *byAttention;
@property (nonatomic, strong) NSString *albumCount;
@property (nonatomic, strong) NSString *isPass;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
