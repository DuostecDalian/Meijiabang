//
//  CYMJOrderListData.m
//
//  Created by 超逸 李 on 15/2/11
//  Copyright (c) 2015 Duostec. All rights reserved.
//

#import "CYMJOrderListData.h"


NSString *const kCYMJOrderListDataNickName = @"nick_name";
NSString *const kCYMJOrderListDataAddTime = @"add_time";
NSString *const kCYMJOrderListDataOrderId = @"order_id";
NSString *const kCYMJOrderListDataUid = @"uid";
NSString *const kCYMJOrderListDataDetailAddr = @"detail_addr";
NSString *const kCYMJOrderListDataOrderStatus = @"order_status";


@interface CYMJOrderListData ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation CYMJOrderListData

@synthesize nickName = _nickName;
@synthesize addTime = _addTime;
@synthesize orderId = _orderId;
@synthesize uid = _uid;
@synthesize detailAddr = _detailAddr;
@synthesize orderStatus = _orderStatus;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.nickName = [self objectOrNilForKey:kCYMJOrderListDataNickName fromDictionary:dict];
            self.addTime = [self objectOrNilForKey:kCYMJOrderListDataAddTime fromDictionary:dict];
            self.orderId = [self objectOrNilForKey:kCYMJOrderListDataOrderId fromDictionary:dict];
            self.uid = [self objectOrNilForKey:kCYMJOrderListDataUid fromDictionary:dict];
            self.detailAddr = [self objectOrNilForKey:kCYMJOrderListDataDetailAddr fromDictionary:dict];
            self.orderStatus = [self objectOrNilForKey:kCYMJOrderListDataOrderStatus fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.nickName forKey:kCYMJOrderListDataNickName];
    [mutableDict setValue:self.addTime forKey:kCYMJOrderListDataAddTime];
    [mutableDict setValue:self.orderId forKey:kCYMJOrderListDataOrderId];
    [mutableDict setValue:self.uid forKey:kCYMJOrderListDataUid];
    [mutableDict setValue:self.detailAddr forKey:kCYMJOrderListDataDetailAddr];
    [mutableDict setValue:self.orderStatus forKey:kCYMJOrderListDataOrderStatus];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description 
{
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}


#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];

    self.nickName = [aDecoder decodeObjectForKey:kCYMJOrderListDataNickName];
    self.addTime = [aDecoder decodeObjectForKey:kCYMJOrderListDataAddTime];
    self.orderId = [aDecoder decodeObjectForKey:kCYMJOrderListDataOrderId];
    self.uid = [aDecoder decodeObjectForKey:kCYMJOrderListDataUid];
    self.detailAddr = [aDecoder decodeObjectForKey:kCYMJOrderListDataDetailAddr];
    self.orderStatus = [aDecoder decodeObjectForKey:kCYMJOrderListDataOrderStatus];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_nickName forKey:kCYMJOrderListDataNickName];
    [aCoder encodeObject:_addTime forKey:kCYMJOrderListDataAddTime];
    [aCoder encodeObject:_orderId forKey:kCYMJOrderListDataOrderId];
    [aCoder encodeObject:_uid forKey:kCYMJOrderListDataUid];
    [aCoder encodeObject:_detailAddr forKey:kCYMJOrderListDataDetailAddr];
    [aCoder encodeObject:_orderStatus forKey:kCYMJOrderListDataOrderStatus];
}

- (id)copyWithZone:(NSZone *)zone
{
    CYMJOrderListData *copy = [[CYMJOrderListData alloc] init];
    
    if (copy) {

        copy.nickName = [self.nickName copyWithZone:zone];
        copy.addTime = [self.addTime copyWithZone:zone];
        copy.orderId = [self.orderId copyWithZone:zone];
        copy.uid = [self.uid copyWithZone:zone];
        copy.detailAddr = [self.detailAddr copyWithZone:zone];
        copy.orderStatus = [self.orderStatus copyWithZone:zone];
    }
    
    return copy;
}


@end
