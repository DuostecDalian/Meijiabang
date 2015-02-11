//
//  CYMJOrderListData.h
//
//  Created by 超逸 李 on 15/2/11
//  Copyright (c) 2015 Duostec. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface CYMJOrderListData : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *nickName;
@property (nonatomic, strong) NSString *addTime;
@property (nonatomic, strong) NSString *orderId;
@property (nonatomic, strong) NSString *uid;
@property (nonatomic, strong) NSString *detailAddr;
@property (nonatomic, strong) NSString *orderStatus;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
