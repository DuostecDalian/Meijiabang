//
//  ZXYAlbumSqureLastAlbum.m
//
//  Created by   on 15/1/28
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "ZXYAlbumSqureLastAlbum.h"
#import "ZXYAlbumSqureImage.h"


NSString *const kZXYAlbumSqureLastAlbumNickName = @"nick_name";
NSString *const kZXYAlbumSqureLastAlbumAlbumId = @"album_id";
NSString *const kZXYAlbumSqureLastAlbumHeadImage = @"head_image";
NSString *const kZXYAlbumSqureLastAlbumCollectCount = @"collect_count";
NSString *const kZXYAlbumSqureLastAlbumRole = @"role";
NSString *const kZXYAlbumSqureLastAlbumImage = @"image";
NSString *const kZXYAlbumSqureLastAlbumUserId = @"user_id";
NSString *const kZXYAlbumSqureLastAlbumDescription = @"description";
NSString *const kZXYAlbumSqureLastAlbumAgreeCount = @"agree_count";
NSString *const kZXYAlbumSqureLastAlbumAddTime = @"add_time";


@interface ZXYAlbumSqureLastAlbum ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ZXYAlbumSqureLastAlbum

@synthesize nickName = _nickName;
@synthesize albumId = _albumId;
@synthesize headImage = _headImage;
@synthesize collectCount = _collectCount;
@synthesize role = _role;
@synthesize image = _image;
@synthesize userId = _userId;
@synthesize lastAlbumDescription = _lastAlbumDescription;
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
            self.nickName = [self objectOrNilForKey:kZXYAlbumSqureLastAlbumNickName fromDictionary:dict];
            self.albumId = [self objectOrNilForKey:kZXYAlbumSqureLastAlbumAlbumId fromDictionary:dict];
            self.headImage = [self objectOrNilForKey:kZXYAlbumSqureLastAlbumHeadImage fromDictionary:dict];
            self.collectCount = [self objectOrNilForKey:kZXYAlbumSqureLastAlbumCollectCount fromDictionary:dict];
            self.role = [self objectOrNilForKey:kZXYAlbumSqureLastAlbumRole fromDictionary:dict];
            self.image = [ZXYAlbumSqureImage modelObjectWithDictionary:[dict objectForKey:kZXYAlbumSqureLastAlbumImage]];
            self.userId = [self objectOrNilForKey:kZXYAlbumSqureLastAlbumUserId fromDictionary:dict];
            self.lastAlbumDescription = [self objectOrNilForKey:kZXYAlbumSqureLastAlbumDescription fromDictionary:dict];
            self.agreeCount = [self objectOrNilForKey:kZXYAlbumSqureLastAlbumAgreeCount fromDictionary:dict];
            self.addTime = [self objectOrNilForKey:kZXYAlbumSqureLastAlbumAddTime fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.nickName forKey:kZXYAlbumSqureLastAlbumNickName];
    [mutableDict setValue:self.albumId forKey:kZXYAlbumSqureLastAlbumAlbumId];
    [mutableDict setValue:self.headImage forKey:kZXYAlbumSqureLastAlbumHeadImage];
    [mutableDict setValue:self.collectCount forKey:kZXYAlbumSqureLastAlbumCollectCount];
    [mutableDict setValue:self.role forKey:kZXYAlbumSqureLastAlbumRole];
    [mutableDict setValue:[self.image dictionaryRepresentation] forKey:kZXYAlbumSqureLastAlbumImage];
    [mutableDict setValue:self.userId forKey:kZXYAlbumSqureLastAlbumUserId];
    [mutableDict setValue:self.lastAlbumDescription forKey:kZXYAlbumSqureLastAlbumDescription];
    [mutableDict setValue:self.agreeCount forKey:kZXYAlbumSqureLastAlbumAgreeCount];
    [mutableDict setValue:self.addTime forKey:kZXYAlbumSqureLastAlbumAddTime];

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

    self.nickName = [aDecoder decodeObjectForKey:kZXYAlbumSqureLastAlbumNickName];
    self.albumId = [aDecoder decodeObjectForKey:kZXYAlbumSqureLastAlbumAlbumId];
    self.headImage = [aDecoder decodeObjectForKey:kZXYAlbumSqureLastAlbumHeadImage];
    self.collectCount = [aDecoder decodeObjectForKey:kZXYAlbumSqureLastAlbumCollectCount];
    self.role = [aDecoder decodeObjectForKey:kZXYAlbumSqureLastAlbumRole];
    self.image = [aDecoder decodeObjectForKey:kZXYAlbumSqureLastAlbumImage];
    self.userId = [aDecoder decodeObjectForKey:kZXYAlbumSqureLastAlbumUserId];
    self.lastAlbumDescription = [aDecoder decodeObjectForKey:kZXYAlbumSqureLastAlbumDescription];
    self.agreeCount = [aDecoder decodeObjectForKey:kZXYAlbumSqureLastAlbumAgreeCount];
    self.addTime = [aDecoder decodeObjectForKey:kZXYAlbumSqureLastAlbumAddTime];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_nickName forKey:kZXYAlbumSqureLastAlbumNickName];
    [aCoder encodeObject:_albumId forKey:kZXYAlbumSqureLastAlbumAlbumId];
    [aCoder encodeObject:_headImage forKey:kZXYAlbumSqureLastAlbumHeadImage];
    [aCoder encodeObject:_collectCount forKey:kZXYAlbumSqureLastAlbumCollectCount];
    [aCoder encodeObject:_role forKey:kZXYAlbumSqureLastAlbumRole];
    [aCoder encodeObject:_image forKey:kZXYAlbumSqureLastAlbumImage];
    [aCoder encodeObject:_userId forKey:kZXYAlbumSqureLastAlbumUserId];
    [aCoder encodeObject:_lastAlbumDescription forKey:kZXYAlbumSqureLastAlbumDescription];
    [aCoder encodeObject:_agreeCount forKey:kZXYAlbumSqureLastAlbumAgreeCount];
    [aCoder encodeObject:_addTime forKey:kZXYAlbumSqureLastAlbumAddTime];
}

- (id)copyWithZone:(NSZone *)zone
{
    ZXYAlbumSqureLastAlbum *copy = [[ZXYAlbumSqureLastAlbum alloc] init];
    
    if (copy) {

        copy.nickName = [self.nickName copyWithZone:zone];
        copy.albumId = [self.albumId copyWithZone:zone];
        copy.headImage = [self.headImage copyWithZone:zone];
        copy.collectCount = [self.collectCount copyWithZone:zone];
        copy.role = [self.role copyWithZone:zone];
        copy.image = [self.image copyWithZone:zone];
        copy.userId = [self.userId copyWithZone:zone];
        copy.lastAlbumDescription = [self.lastAlbumDescription copyWithZone:zone];
        copy.agreeCount = [self.agreeCount copyWithZone:zone];
        copy.addTime = [self.addTime copyWithZone:zone];
    }
    
    return copy;
}


@end
