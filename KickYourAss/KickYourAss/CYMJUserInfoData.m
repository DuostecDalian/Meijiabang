//
//  CYMJUserInfoData.m
//
//  Created by 超逸 李 on 15/2/6
//  Copyright (c) 2015 Duostec. All rights reserved.
//

#import "CYMJUserInfoData.h"


NSString *const kCYMJUserInfoDataRealName = @"real_name";
NSString *const kCYMJUserInfoDataHeadImage = @"head_image";
NSString *const kCYMJUserInfoDataSex = @"sex";
NSString *const kCYMJUserInfoDataLongitude = @"longitude";
NSString *const kCYMJUserInfoDataNickName = @"nick_name";
NSString *const kCYMJUserInfoDataLatitude = @"latitude";
NSString *const kCYMJUserInfoDataByAttention = @"by_attention";
NSString *const kCYMJUserInfoDataAddress = @"address";
NSString *const kCYMJUserInfoDataUserName = @"user_name";
NSString *const kCYMJUserInfoDataRole = @"role";
NSString *const kCYMJUserInfoDataTel = @"tel";
NSString *const kCYMJUserInfoDataAttention = @"attention";
NSString *const kCYMJUserInfoDataScore = @"score";


@interface CYMJUserInfoData ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation CYMJUserInfoData

@synthesize realName = _realName;
@synthesize headImage = _headImage;
@synthesize sex = _sex;
@synthesize longitude = _longitude;
@synthesize nickName = _nickName;
@synthesize latitude = _latitude;
@synthesize byAttention = _byAttention;
@synthesize address = _address;
@synthesize userName = _userName;
@synthesize role = _role;
@synthesize tel = _tel;
@synthesize attention = _attention;
@synthesize score = _score;


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
            self.realName = [self objectOrNilForKey:kCYMJUserInfoDataRealName fromDictionary:dict];
            self.headImage = [self objectOrNilForKey:kCYMJUserInfoDataHeadImage fromDictionary:dict];
            self.sex = [self objectOrNilForKey:kCYMJUserInfoDataSex fromDictionary:dict];
            self.longitude = [self objectOrNilForKey:kCYMJUserInfoDataLongitude fromDictionary:dict];
            self.nickName = [self objectOrNilForKey:kCYMJUserInfoDataNickName fromDictionary:dict];
            self.latitude = [self objectOrNilForKey:kCYMJUserInfoDataLatitude fromDictionary:dict];
            self.byAttention = [self objectOrNilForKey:kCYMJUserInfoDataByAttention fromDictionary:dict];
            self.address = [self objectOrNilForKey:kCYMJUserInfoDataAddress fromDictionary:dict];
            self.userName = [self objectOrNilForKey:kCYMJUserInfoDataUserName fromDictionary:dict];
            self.role = [self objectOrNilForKey:kCYMJUserInfoDataRole fromDictionary:dict];
            self.tel = [self objectOrNilForKey:kCYMJUserInfoDataTel fromDictionary:dict];
            self.attention = [self objectOrNilForKey:kCYMJUserInfoDataAttention fromDictionary:dict];
            self.score = [self objectOrNilForKey:kCYMJUserInfoDataScore fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.realName forKey:kCYMJUserInfoDataRealName];
    [mutableDict setValue:self.headImage forKey:kCYMJUserInfoDataHeadImage];
    [mutableDict setValue:self.sex forKey:kCYMJUserInfoDataSex];
    [mutableDict setValue:self.longitude forKey:kCYMJUserInfoDataLongitude];
    [mutableDict setValue:self.nickName forKey:kCYMJUserInfoDataNickName];
    [mutableDict setValue:self.latitude forKey:kCYMJUserInfoDataLatitude];
    [mutableDict setValue:self.byAttention forKey:kCYMJUserInfoDataByAttention];
    [mutableDict setValue:self.address forKey:kCYMJUserInfoDataAddress];
    [mutableDict setValue:self.userName forKey:kCYMJUserInfoDataUserName];
    [mutableDict setValue:self.role forKey:kCYMJUserInfoDataRole];
    [mutableDict setValue:self.tel forKey:kCYMJUserInfoDataTel];
    [mutableDict setValue:self.attention forKey:kCYMJUserInfoDataAttention];
    [mutableDict setValue:self.score forKey:kCYMJUserInfoDataScore];

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

    self.realName = [aDecoder decodeObjectForKey:kCYMJUserInfoDataRealName];
    self.headImage = [aDecoder decodeObjectForKey:kCYMJUserInfoDataHeadImage];
    self.sex = [aDecoder decodeObjectForKey:kCYMJUserInfoDataSex];
    self.longitude = [aDecoder decodeObjectForKey:kCYMJUserInfoDataLongitude];
    self.nickName = [aDecoder decodeObjectForKey:kCYMJUserInfoDataNickName];
    self.latitude = [aDecoder decodeObjectForKey:kCYMJUserInfoDataLatitude];
    self.byAttention = [aDecoder decodeObjectForKey:kCYMJUserInfoDataByAttention];
    self.address = [aDecoder decodeObjectForKey:kCYMJUserInfoDataAddress];
    self.userName = [aDecoder decodeObjectForKey:kCYMJUserInfoDataUserName];
    self.role = [aDecoder decodeObjectForKey:kCYMJUserInfoDataRole];
    self.tel = [aDecoder decodeObjectForKey:kCYMJUserInfoDataTel];
    self.attention = [aDecoder decodeObjectForKey:kCYMJUserInfoDataAttention];
    self.score = [aDecoder decodeObjectForKey:kCYMJUserInfoDataScore];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_realName forKey:kCYMJUserInfoDataRealName];
    [aCoder encodeObject:_headImage forKey:kCYMJUserInfoDataHeadImage];
    [aCoder encodeObject:_sex forKey:kCYMJUserInfoDataSex];
    [aCoder encodeObject:_longitude forKey:kCYMJUserInfoDataLongitude];
    [aCoder encodeObject:_nickName forKey:kCYMJUserInfoDataNickName];
    [aCoder encodeObject:_latitude forKey:kCYMJUserInfoDataLatitude];
    [aCoder encodeObject:_byAttention forKey:kCYMJUserInfoDataByAttention];
    [aCoder encodeObject:_address forKey:kCYMJUserInfoDataAddress];
    [aCoder encodeObject:_userName forKey:kCYMJUserInfoDataUserName];
    [aCoder encodeObject:_role forKey:kCYMJUserInfoDataRole];
    [aCoder encodeObject:_tel forKey:kCYMJUserInfoDataTel];
    [aCoder encodeObject:_attention forKey:kCYMJUserInfoDataAttention];
    [aCoder encodeObject:_score forKey:kCYMJUserInfoDataScore];
}

- (id)copyWithZone:(NSZone *)zone
{
    CYMJUserInfoData *copy = [[CYMJUserInfoData alloc] init];
    
    if (copy) {

        copy.realName = [self.realName copyWithZone:zone];
        copy.headImage = [self.headImage copyWithZone:zone];
        copy.sex = [self.sex copyWithZone:zone];
        copy.longitude = [self.longitude copyWithZone:zone];
        copy.nickName = [self.nickName copyWithZone:zone];
        copy.latitude = [self.latitude copyWithZone:zone];
        copy.byAttention = [self.byAttention copyWithZone:zone];
        copy.address = [self.address copyWithZone:zone];
        copy.userName = [self.userName copyWithZone:zone];
        copy.role = [self.role copyWithZone:zone];
        copy.tel = [self.tel copyWithZone:zone];
        copy.attention = [self.attention copyWithZone:zone];
        copy.score = [self.score copyWithZone:zone];
    }
    
    return copy;
}


@end
