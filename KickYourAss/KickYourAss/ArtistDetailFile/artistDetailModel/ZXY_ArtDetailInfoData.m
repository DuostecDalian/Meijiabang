//
//  ZXY_ArtDetailInfoData.m
//
//  Created by   on 15/1/30
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "ZXY_ArtDetailInfoData.h"


NSString *const kZXY_ArtDetailInfoDataOrderCount2 = @"order_count2";
NSString *const kZXY_ArtDetailInfoDataRealName = @"real_name";
NSString *const kZXY_ArtDetailInfoDataHeadImage = @"head_image";
NSString *const kZXY_ArtDetailInfoDataSex = @"sex";
NSString *const kZXY_ArtDetailInfoDataLongitude = @"longitude";
NSString *const kZXY_ArtDetailInfoDataNickName = @"nick_name";
NSString *const kZXY_ArtDetailInfoDataLatitude = @"latitude";
NSString *const kZXY_ArtDetailInfoDataAlbumCount = @"album_count";
NSString *const kZXY_ArtDetailInfoDataByAttention = @"by_attention";
NSString *const kZXY_ArtDetailInfoDataAddress = @"address";
NSString *const kZXY_ArtDetailInfoDataOrderCount = @"order_count";
NSString *const kZXY_ArtDetailInfoDataRole = @"role";
NSString *const kZXY_ArtDetailInfoDataTel = @"tel";
NSString *const kZXY_ArtDetailInfoDataAttention = @"attention";
NSString *const kZXY_ArtDetailInfoDataScore = @"score";
NSString *const kZXY_ArtDetailInfoDataIsAttention = @"is_attention";


@interface ZXY_ArtDetailInfoData ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ZXY_ArtDetailInfoData

@synthesize orderCount2 = _orderCount2;
@synthesize realName = _realName;
@synthesize headImage = _headImage;
@synthesize sex = _sex;
@synthesize longitude = _longitude;
@synthesize nickName = _nickName;
@synthesize latitude = _latitude;
@synthesize albumCount = _albumCount;
@synthesize byAttention = _byAttention;
@synthesize address = _address;
@synthesize orderCount = _orderCount;
@synthesize role = _role;
@synthesize tel = _tel;
@synthesize attention = _attention;
@synthesize score = _score;
@synthesize isAttention = _isAttention;


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
            self.orderCount2 = [self objectOrNilForKey:kZXY_ArtDetailInfoDataOrderCount2 fromDictionary:dict];
            self.realName = [self objectOrNilForKey:kZXY_ArtDetailInfoDataRealName fromDictionary:dict];
            self.headImage = [self objectOrNilForKey:kZXY_ArtDetailInfoDataHeadImage fromDictionary:dict];
            self.sex = [self objectOrNilForKey:kZXY_ArtDetailInfoDataSex fromDictionary:dict];
            self.longitude = [self objectOrNilForKey:kZXY_ArtDetailInfoDataLongitude fromDictionary:dict];
            self.nickName = [self objectOrNilForKey:kZXY_ArtDetailInfoDataNickName fromDictionary:dict];
            self.latitude = [self objectOrNilForKey:kZXY_ArtDetailInfoDataLatitude fromDictionary:dict];
            self.albumCount = [self objectOrNilForKey:kZXY_ArtDetailInfoDataAlbumCount fromDictionary:dict];
            self.byAttention = [self objectOrNilForKey:kZXY_ArtDetailInfoDataByAttention fromDictionary:dict];
            self.address = [self objectOrNilForKey:kZXY_ArtDetailInfoDataAddress fromDictionary:dict];
            self.orderCount = [self objectOrNilForKey:kZXY_ArtDetailInfoDataOrderCount fromDictionary:dict];
            self.role = [self objectOrNilForKey:kZXY_ArtDetailInfoDataRole fromDictionary:dict];
            self.tel = [self objectOrNilForKey:kZXY_ArtDetailInfoDataTel fromDictionary:dict];
            self.attention = [self objectOrNilForKey:kZXY_ArtDetailInfoDataAttention fromDictionary:dict];
            self.score = [self objectOrNilForKey:kZXY_ArtDetailInfoDataScore fromDictionary:dict];
            self.isAttention = [[self objectOrNilForKey:kZXY_ArtDetailInfoDataIsAttention fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.orderCount2 forKey:kZXY_ArtDetailInfoDataOrderCount2];
    [mutableDict setValue:self.realName forKey:kZXY_ArtDetailInfoDataRealName];
    [mutableDict setValue:self.headImage forKey:kZXY_ArtDetailInfoDataHeadImage];
    [mutableDict setValue:self.sex forKey:kZXY_ArtDetailInfoDataSex];
    [mutableDict setValue:self.longitude forKey:kZXY_ArtDetailInfoDataLongitude];
    [mutableDict setValue:self.nickName forKey:kZXY_ArtDetailInfoDataNickName];
    [mutableDict setValue:self.latitude forKey:kZXY_ArtDetailInfoDataLatitude];
    [mutableDict setValue:self.albumCount forKey:kZXY_ArtDetailInfoDataAlbumCount];
    [mutableDict setValue:self.byAttention forKey:kZXY_ArtDetailInfoDataByAttention];
    [mutableDict setValue:self.address forKey:kZXY_ArtDetailInfoDataAddress];
    [mutableDict setValue:self.orderCount forKey:kZXY_ArtDetailInfoDataOrderCount];
    [mutableDict setValue:self.role forKey:kZXY_ArtDetailInfoDataRole];
    [mutableDict setValue:self.tel forKey:kZXY_ArtDetailInfoDataTel];
    [mutableDict setValue:self.attention forKey:kZXY_ArtDetailInfoDataAttention];
    [mutableDict setValue:self.score forKey:kZXY_ArtDetailInfoDataScore];
    [mutableDict setValue:[NSNumber numberWithDouble:self.isAttention] forKey:kZXY_ArtDetailInfoDataIsAttention];

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
    return [object isEqual:[NSNull null]] ? @"" : object;
}


#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];

    self.orderCount2 = [aDecoder decodeObjectForKey:kZXY_ArtDetailInfoDataOrderCount2];
    self.realName = [aDecoder decodeObjectForKey:kZXY_ArtDetailInfoDataRealName];
    self.headImage = [aDecoder decodeObjectForKey:kZXY_ArtDetailInfoDataHeadImage];
    self.sex = [aDecoder decodeObjectForKey:kZXY_ArtDetailInfoDataSex];
    self.longitude = [aDecoder decodeObjectForKey:kZXY_ArtDetailInfoDataLongitude];
    self.nickName = [aDecoder decodeObjectForKey:kZXY_ArtDetailInfoDataNickName];
    self.latitude = [aDecoder decodeObjectForKey:kZXY_ArtDetailInfoDataLatitude];
    self.albumCount = [aDecoder decodeObjectForKey:kZXY_ArtDetailInfoDataAlbumCount];
    self.byAttention = [aDecoder decodeObjectForKey:kZXY_ArtDetailInfoDataByAttention];
    self.address = [aDecoder decodeObjectForKey:kZXY_ArtDetailInfoDataAddress];
    self.orderCount = [aDecoder decodeObjectForKey:kZXY_ArtDetailInfoDataOrderCount];
    self.role = [aDecoder decodeObjectForKey:kZXY_ArtDetailInfoDataRole];
    self.tel = [aDecoder decodeObjectForKey:kZXY_ArtDetailInfoDataTel];
    self.attention = [aDecoder decodeObjectForKey:kZXY_ArtDetailInfoDataAttention];
    self.score = [aDecoder decodeObjectForKey:kZXY_ArtDetailInfoDataScore];
    self.isAttention = [aDecoder decodeDoubleForKey:kZXY_ArtDetailInfoDataIsAttention];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_orderCount2 forKey:kZXY_ArtDetailInfoDataOrderCount2];
    [aCoder encodeObject:_realName forKey:kZXY_ArtDetailInfoDataRealName];
    [aCoder encodeObject:_headImage forKey:kZXY_ArtDetailInfoDataHeadImage];
    [aCoder encodeObject:_sex forKey:kZXY_ArtDetailInfoDataSex];
    [aCoder encodeObject:_longitude forKey:kZXY_ArtDetailInfoDataLongitude];
    [aCoder encodeObject:_nickName forKey:kZXY_ArtDetailInfoDataNickName];
    [aCoder encodeObject:_latitude forKey:kZXY_ArtDetailInfoDataLatitude];
    [aCoder encodeObject:_albumCount forKey:kZXY_ArtDetailInfoDataAlbumCount];
    [aCoder encodeObject:_byAttention forKey:kZXY_ArtDetailInfoDataByAttention];
    [aCoder encodeObject:_address forKey:kZXY_ArtDetailInfoDataAddress];
    [aCoder encodeObject:_orderCount forKey:kZXY_ArtDetailInfoDataOrderCount];
    [aCoder encodeObject:_role forKey:kZXY_ArtDetailInfoDataRole];
    [aCoder encodeObject:_tel forKey:kZXY_ArtDetailInfoDataTel];
    [aCoder encodeObject:_attention forKey:kZXY_ArtDetailInfoDataAttention];
    [aCoder encodeObject:_score forKey:kZXY_ArtDetailInfoDataScore];
    [aCoder encodeDouble:_isAttention forKey:kZXY_ArtDetailInfoDataIsAttention];
}

- (id)copyWithZone:(NSZone *)zone
{
    ZXY_ArtDetailInfoData *copy = [[ZXY_ArtDetailInfoData alloc] init];
    
    if (copy) {

        copy.orderCount2 = [self.orderCount2 copyWithZone:zone];
        copy.realName = [self.realName copyWithZone:zone];
        copy.headImage = [self.headImage copyWithZone:zone];
        copy.sex = [self.sex copyWithZone:zone];
        copy.longitude = [self.longitude copyWithZone:zone];
        copy.nickName = [self.nickName copyWithZone:zone];
        copy.latitude = [self.latitude copyWithZone:zone];
        copy.albumCount = [self.albumCount copyWithZone:zone];
        copy.byAttention = [self.byAttention copyWithZone:zone];
        copy.address = [self.address copyWithZone:zone];
        copy.orderCount = [self.orderCount copyWithZone:zone];
        copy.role = [self.role copyWithZone:zone];
        copy.tel = [self.tel copyWithZone:zone];
        copy.attention = [self.attention copyWithZone:zone];
        copy.score = [self.score copyWithZone:zone];
        copy.isAttention = self.isAttention;
    }
    
    return copy;
}


@end
