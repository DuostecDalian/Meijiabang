//
//  ZXYAlbumSqureRecommendAlbum.m
//
//  Created by   on 15/1/28
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "ZXYAlbumSqureRecommendAlbum.h"
#import "ZXYAlbumSqureImage.h"


NSString *const kZXYAlbumSqureRecommendAlbumNickName = @"nick_name";
NSString *const kZXYAlbumSqureRecommendAlbumAlbumId = @"album_id";
NSString *const kZXYAlbumSqureRecommendAlbumHeadImage = @"head_image";
NSString *const kZXYAlbumSqureRecommendAlbumCollectCount = @"collect_count";
NSString *const kZXYAlbumSqureRecommendAlbumRole = @"role";
NSString *const kZXYAlbumSqureRecommendAlbumImage = @"image";
NSString *const kZXYAlbumSqureRecommendAlbumUserId = @"user_id";
NSString *const kZXYAlbumSqureRecommendAlbumDescription = @"description";
NSString *const kZXYAlbumSqureRecommendAlbumAgreeCount = @"agree_count";
NSString *const kZXYAlbumSqureRecommendAlbumAddTime = @"add_time";


@interface ZXYAlbumSqureRecommendAlbum ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ZXYAlbumSqureRecommendAlbum

@synthesize nickName = _nickName;
@synthesize albumId = _albumId;
@synthesize headImage = _headImage;
@synthesize collectCount = _collectCount;
@synthesize role = _role;
@synthesize image = _image;
@synthesize userId = _userId;
@synthesize recommendAlbumDescription = _recommendAlbumDescription;
@synthesize agreeCount = _agreeCount;
@synthesize addTime = _addTime;


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
            self.nickName = [self objectOrNilForKey:kZXYAlbumSqureRecommendAlbumNickName fromDictionary:dict];
            self.albumId = [self objectOrNilForKey:kZXYAlbumSqureRecommendAlbumAlbumId fromDictionary:dict];
            self.headImage = [self objectOrNilForKey:kZXYAlbumSqureRecommendAlbumHeadImage fromDictionary:dict];
            self.collectCount = [self objectOrNilForKey:kZXYAlbumSqureRecommendAlbumCollectCount fromDictionary:dict];
            self.role = [self objectOrNilForKey:kZXYAlbumSqureRecommendAlbumRole fromDictionary:dict];
            self.image = [ZXYAlbumSqureImage modelObjectWithDictionary:[dict objectForKey:kZXYAlbumSqureRecommendAlbumImage]];
            self.userId = [self objectOrNilForKey:kZXYAlbumSqureRecommendAlbumUserId fromDictionary:dict];
            self.recommendAlbumDescription = [self objectOrNilForKey:kZXYAlbumSqureRecommendAlbumDescription fromDictionary:dict];
            self.agreeCount = [self objectOrNilForKey:kZXYAlbumSqureRecommendAlbumAgreeCount fromDictionary:dict];
            self.addTime = [self objectOrNilForKey:kZXYAlbumSqureRecommendAlbumAddTime fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.nickName forKey:kZXYAlbumSqureRecommendAlbumNickName];
    [mutableDict setValue:self.albumId forKey:kZXYAlbumSqureRecommendAlbumAlbumId];
    [mutableDict setValue:self.headImage forKey:kZXYAlbumSqureRecommendAlbumHeadImage];
    [mutableDict setValue:self.collectCount forKey:kZXYAlbumSqureRecommendAlbumCollectCount];
    [mutableDict setValue:self.role forKey:kZXYAlbumSqureRecommendAlbumRole];
    [mutableDict setValue:[self.image dictionaryRepresentation] forKey:kZXYAlbumSqureRecommendAlbumImage];
    [mutableDict setValue:self.userId forKey:kZXYAlbumSqureRecommendAlbumUserId];
    [mutableDict setValue:self.recommendAlbumDescription forKey:kZXYAlbumSqureRecommendAlbumDescription];
    [mutableDict setValue:self.agreeCount forKey:kZXYAlbumSqureRecommendAlbumAgreeCount];
    [mutableDict setValue:self.addTime forKey:kZXYAlbumSqureRecommendAlbumAddTime];

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

    self.nickName = [aDecoder decodeObjectForKey:kZXYAlbumSqureRecommendAlbumNickName];
    self.albumId = [aDecoder decodeObjectForKey:kZXYAlbumSqureRecommendAlbumAlbumId];
    self.headImage = [aDecoder decodeObjectForKey:kZXYAlbumSqureRecommendAlbumHeadImage];
    self.collectCount = [aDecoder decodeObjectForKey:kZXYAlbumSqureRecommendAlbumCollectCount];
    self.role = [aDecoder decodeObjectForKey:kZXYAlbumSqureRecommendAlbumRole];
    self.image = [aDecoder decodeObjectForKey:kZXYAlbumSqureRecommendAlbumImage];
    self.userId = [aDecoder decodeObjectForKey:kZXYAlbumSqureRecommendAlbumUserId];
    self.recommendAlbumDescription = [aDecoder decodeObjectForKey:kZXYAlbumSqureRecommendAlbumDescription];
    self.agreeCount = [aDecoder decodeObjectForKey:kZXYAlbumSqureRecommendAlbumAgreeCount];
    self.addTime = [aDecoder decodeObjectForKey:kZXYAlbumSqureRecommendAlbumAddTime];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_nickName forKey:kZXYAlbumSqureRecommendAlbumNickName];
    [aCoder encodeObject:_albumId forKey:kZXYAlbumSqureRecommendAlbumAlbumId];
    [aCoder encodeObject:_headImage forKey:kZXYAlbumSqureRecommendAlbumHeadImage];
    [aCoder encodeObject:_collectCount forKey:kZXYAlbumSqureRecommendAlbumCollectCount];
    [aCoder encodeObject:_role forKey:kZXYAlbumSqureRecommendAlbumRole];
    [aCoder encodeObject:_image forKey:kZXYAlbumSqureRecommendAlbumImage];
    [aCoder encodeObject:_userId forKey:kZXYAlbumSqureRecommendAlbumUserId];
    [aCoder encodeObject:_recommendAlbumDescription forKey:kZXYAlbumSqureRecommendAlbumDescription];
    [aCoder encodeObject:_agreeCount forKey:kZXYAlbumSqureRecommendAlbumAgreeCount];
    [aCoder encodeObject:_addTime forKey:kZXYAlbumSqureRecommendAlbumAddTime];
}

- (id)copyWithZone:(NSZone *)zone
{
    ZXYAlbumSqureRecommendAlbum *copy = [[ZXYAlbumSqureRecommendAlbum alloc] init];
    
    if (copy) {

        copy.nickName = [self.nickName copyWithZone:zone];
        copy.albumId = [self.albumId copyWithZone:zone];
        copy.headImage = [self.headImage copyWithZone:zone];
        copy.collectCount = [self.collectCount copyWithZone:zone];
        copy.role = [self.role copyWithZone:zone];
        copy.image = [self.image copyWithZone:zone];
        copy.userId = [self.userId copyWithZone:zone];
        copy.recommendAlbumDescription = [self.recommendAlbumDescription copyWithZone:zone];
        copy.agreeCount = [self.agreeCount copyWithZone:zone];
        copy.addTime = [self.addTime copyWithZone:zone];
    }
    
    return copy;
}


@end
