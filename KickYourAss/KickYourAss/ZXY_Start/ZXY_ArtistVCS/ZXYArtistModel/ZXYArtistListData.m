//
//  ZXYArtistListData.m
//
//  Created by   on 15/1/28
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "ZXYArtistListData.h"


NSString *const kZXYArtistListDataNickName = @"nick_name";
NSString *const kZXYArtistListDataScore = @"score";
NSString *const kZXYArtistListDataP = @"p";
NSString *const kZXYArtistListDataHeadImage = @"head_image";
NSString *const kZXYArtistListDataLongitude = @"longitude";
NSString *const kZXYArtistListDataLatitude = @"latitude";
NSString *const kZXYArtistListDataUserId = @"user_id";
NSString *const kZXYArtistListDataByAttention = @"by_attention";
NSString *const kZXYArtistListDataAlbumCount = @"album_count";
NSString *const kZXYArtistListDataIsPass = @"is_pass";


@interface ZXYArtistListData ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ZXYArtistListData

@synthesize nickName = _nickName;
@synthesize score = _score;
@synthesize p = _p;
@synthesize headImage = _headImage;
@synthesize longitude = _longitude;
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
            self.nickName = [self objectOrNilForKey:kZXYArtistListDataNickName fromDictionary:dict];
            self.score = [self objectOrNilForKey:kZXYArtistListDataScore fromDictionary:dict];
            self.p = [self objectOrNilForKey:kZXYArtistListDataP fromDictionary:dict];
            self.headImage = [self objectOrNilForKey:kZXYArtistListDataHeadImage fromDictionary:dict];
            self.longitude = [self objectOrNilForKey:kZXYArtistListDataLongitude fromDictionary:dict];
            self.latitude = [self objectOrNilForKey:kZXYArtistListDataLatitude fromDictionary:dict];
            self.userId = [self objectOrNilForKey:kZXYArtistListDataUserId fromDictionary:dict];
            self.byAttention = [self objectOrNilForKey:kZXYArtistListDataByAttention fromDictionary:dict];
            self.albumCount = [self objectOrNilForKey:kZXYArtistListDataAlbumCount fromDictionary:dict];
            self.isPass = [self objectOrNilForKey:kZXYArtistListDataIsPass fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.nickName forKey:kZXYArtistListDataNickName];
    [mutableDict setValue:self.score forKey:kZXYArtistListDataScore];
    [mutableDict setValue:self.p forKey:kZXYArtistListDataP];
    [mutableDict setValue:self.headImage forKey:kZXYArtistListDataHeadImage];
    [mutableDict setValue:self.longitude forKey:kZXYArtistListDataLongitude];
    [mutableDict setValue:self.latitude forKey:kZXYArtistListDataLatitude];
    [mutableDict setValue:self.userId forKey:kZXYArtistListDataUserId];
    [mutableDict setValue:self.byAttention forKey:kZXYArtistListDataByAttention];
    [mutableDict setValue:self.albumCount forKey:kZXYArtistListDataAlbumCount];
    [mutableDict setValue:self.isPass forKey:kZXYArtistListDataIsPass];

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

    self.nickName = [aDecoder decodeObjectForKey:kZXYArtistListDataNickName];
    self.score = [aDecoder decodeObjectForKey:kZXYArtistListDataScore];
    self.p = [aDecoder decodeObjectForKey:kZXYArtistListDataP];
    self.headImage = [aDecoder decodeObjectForKey:kZXYArtistListDataHeadImage];
    self.longitude = [aDecoder decodeObjectForKey:kZXYArtistListDataLongitude];
    self.latitude = [aDecoder decodeObjectForKey:kZXYArtistListDataLatitude];
    self.userId = [aDecoder decodeObjectForKey:kZXYArtistListDataUserId];
    self.byAttention = [aDecoder decodeObjectForKey:kZXYArtistListDataByAttention];
    self.albumCount = [aDecoder decodeObjectForKey:kZXYArtistListDataAlbumCount];
    self.isPass = [aDecoder decodeObjectForKey:kZXYArtistListDataIsPass];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_nickName forKey:kZXYArtistListDataNickName];
    [aCoder encodeObject:_score forKey:kZXYArtistListDataScore];
    [aCoder encodeObject:_p forKey:kZXYArtistListDataP];
    [aCoder encodeObject:_headImage forKey:kZXYArtistListDataHeadImage];
    [aCoder encodeObject:_longitude forKey:kZXYArtistListDataLongitude];
    [aCoder encodeObject:_latitude forKey:kZXYArtistListDataLatitude];
    [aCoder encodeObject:_userId forKey:kZXYArtistListDataUserId];
    [aCoder encodeObject:_byAttention forKey:kZXYArtistListDataByAttention];
    [aCoder encodeObject:_albumCount forKey:kZXYArtistListDataAlbumCount];
    [aCoder encodeObject:_isPass forKey:kZXYArtistListDataIsPass];
}

- (id)copyWithZone:(NSZone *)zone
{
    ZXYArtistListData *copy = [[ZXYArtistListData alloc] init];
    
    if (copy) {

        copy.nickName = [self.nickName copyWithZone:zone];
        copy.score = [self.score copyWithZone:zone];
        copy.p = [self.p copyWithZone:zone];
        copy.headImage = [self.headImage copyWithZone:zone];
        copy.longitude = [self.longitude copyWithZone:zone];
        copy.latitude = [self.latitude copyWithZone:zone];
        copy.userId = [self.userId copyWithZone:zone];
        copy.byAttention = [self.byAttention copyWithZone:zone];
        copy.albumCount = [self.albumCount copyWithZone:zone];
        copy.isPass = [self.isPass copyWithZone:zone];
    }
    
    return copy;
}


@end
