//
//  CYMJUserListAtListData.m
//
//  Created by 超逸 李 on 15/2/10
//  Copyright (c) 2015 Duostec. All rights reserved.
//

#import "CYMJUserListAtListData.h"


NSString *const kCYMJUserListAtListDataNickName = @"nick_name";
NSString *const kCYMJUserListAtListDataScore = @"score";
NSString *const kCYMJUserListAtListDataHeadImage = @"head_image";
NSString *const kCYMJUserListAtListDataLongitude = @"longitude";
NSString *const kCYMJUserListAtListDataOrderCount = @"order_count";
NSString *const kCYMJUserListAtListDataOrderCount2 = @"order_count2";
NSString *const kCYMJUserListAtListDataLatitude = @"latitude";
NSString *const kCYMJUserListAtListDataUserId = @"user_id";
NSString *const kCYMJUserListAtListDataByAttention = @"by_attention";
NSString *const kCYMJUserListAtListDataAlbumCount = @"album_count";
NSString *const kCYMJUserListAtListDataIsPass = @"is_pass";


@interface CYMJUserListAtListData ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation CYMJUserListAtListData

@synthesize nickName = _nickName;
@synthesize score = _score;
@synthesize headImage = _headImage;
@synthesize longitude = _longitude;
@synthesize orderCount = _orderCount;
@synthesize orderCount2 = _orderCount2;
@synthesize latitude = _latitude;
@synthesize userId = _userId;
@synthesize byAttention = _byAttention;
@synthesize albumCount = _albumCount;
@synthesize isPass = _isPass;


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
            self.nickName = [self objectOrNilForKey:kCYMJUserListAtListDataNickName fromDictionary:dict];
            self.score = [self objectOrNilForKey:kCYMJUserListAtListDataScore fromDictionary:dict];
            self.headImage = [self objectOrNilForKey:kCYMJUserListAtListDataHeadImage fromDictionary:dict];
            self.longitude = [self objectOrNilForKey:kCYMJUserListAtListDataLongitude fromDictionary:dict];
            self.orderCount = [self objectOrNilForKey:kCYMJUserListAtListDataOrderCount fromDictionary:dict];
            self.orderCount2 = [self objectOrNilForKey:kCYMJUserListAtListDataOrderCount2 fromDictionary:dict];
            self.latitude = [self objectOrNilForKey:kCYMJUserListAtListDataLatitude fromDictionary:dict];
            self.userId = [self objectOrNilForKey:kCYMJUserListAtListDataUserId fromDictionary:dict];
            self.byAttention = [self objectOrNilForKey:kCYMJUserListAtListDataByAttention fromDictionary:dict];
            self.albumCount = [self objectOrNilForKey:kCYMJUserListAtListDataAlbumCount fromDictionary:dict];
            self.isPass = [self objectOrNilForKey:kCYMJUserListAtListDataIsPass fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.nickName forKey:kCYMJUserListAtListDataNickName];
    [mutableDict setValue:self.score forKey:kCYMJUserListAtListDataScore];
    [mutableDict setValue:self.headImage forKey:kCYMJUserListAtListDataHeadImage];
    [mutableDict setValue:self.longitude forKey:kCYMJUserListAtListDataLongitude];
    [mutableDict setValue:self.orderCount forKey:kCYMJUserListAtListDataOrderCount];
    [mutableDict setValue:self.orderCount2 forKey:kCYMJUserListAtListDataOrderCount2];
    [mutableDict setValue:self.latitude forKey:kCYMJUserListAtListDataLatitude];
    [mutableDict setValue:self.userId forKey:kCYMJUserListAtListDataUserId];
    [mutableDict setValue:self.byAttention forKey:kCYMJUserListAtListDataByAttention];
    [mutableDict setValue:self.albumCount forKey:kCYMJUserListAtListDataAlbumCount];
    [mutableDict setValue:self.isPass forKey:kCYMJUserListAtListDataIsPass];

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

    self.nickName = [aDecoder decodeObjectForKey:kCYMJUserListAtListDataNickName];
    self.score = [aDecoder decodeObjectForKey:kCYMJUserListAtListDataScore];
    self.headImage = [aDecoder decodeObjectForKey:kCYMJUserListAtListDataHeadImage];
    self.longitude = [aDecoder decodeObjectForKey:kCYMJUserListAtListDataLongitude];
    self.orderCount = [aDecoder decodeObjectForKey:kCYMJUserListAtListDataOrderCount];
    self.orderCount2 = [aDecoder decodeObjectForKey:kCYMJUserListAtListDataOrderCount2];
    self.latitude = [aDecoder decodeObjectForKey:kCYMJUserListAtListDataLatitude];
    self.userId = [aDecoder decodeObjectForKey:kCYMJUserListAtListDataUserId];
    self.byAttention = [aDecoder decodeObjectForKey:kCYMJUserListAtListDataByAttention];
    self.albumCount = [aDecoder decodeObjectForKey:kCYMJUserListAtListDataAlbumCount];
    self.isPass = [aDecoder decodeObjectForKey:kCYMJUserListAtListDataIsPass];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_nickName forKey:kCYMJUserListAtListDataNickName];
    [aCoder encodeObject:_score forKey:kCYMJUserListAtListDataScore];
    [aCoder encodeObject:_headImage forKey:kCYMJUserListAtListDataHeadImage];
    [aCoder encodeObject:_longitude forKey:kCYMJUserListAtListDataLongitude];
    [aCoder encodeObject:_orderCount forKey:kCYMJUserListAtListDataOrderCount];
    [aCoder encodeObject:_orderCount2 forKey:kCYMJUserListAtListDataOrderCount2];
    [aCoder encodeObject:_latitude forKey:kCYMJUserListAtListDataLatitude];
    [aCoder encodeObject:_userId forKey:kCYMJUserListAtListDataUserId];
    [aCoder encodeObject:_byAttention forKey:kCYMJUserListAtListDataByAttention];
    [aCoder encodeObject:_albumCount forKey:kCYMJUserListAtListDataAlbumCount];
    [aCoder encodeObject:_isPass forKey:kCYMJUserListAtListDataIsPass];
}

- (id)copyWithZone:(NSZone *)zone
{
    CYMJUserListAtListData *copy = [[CYMJUserListAtListData alloc] init];
    
    if (copy) {

        copy.nickName = [self.nickName copyWithZone:zone];
        copy.score = [self.score copyWithZone:zone];
        copy.headImage = [self.headImage copyWithZone:zone];
        copy.longitude = [self.longitude copyWithZone:zone];
        copy.orderCount = [self.orderCount copyWithZone:zone];
        copy.orderCount2 = [self.orderCount2 copyWithZone:zone];
        copy.latitude = [self.latitude copyWithZone:zone];
        copy.userId = [self.userId copyWithZone:zone];
        copy.byAttention = [self.byAttention copyWithZone:zone];
        copy.albumCount = [self.albumCount copyWithZone:zone];
        copy.isPass = [self.isPass copyWithZone:zone];
    }
    
    return copy;
}


@end
