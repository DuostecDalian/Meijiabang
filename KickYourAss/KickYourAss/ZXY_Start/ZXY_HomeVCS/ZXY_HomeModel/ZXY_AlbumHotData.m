//
//  ZXY_AlbumHotData.m
//
//  Created by   on 15/1/27
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "ZXY_AlbumHotData.h"
#import "ZXY_AlbumHotUser.h"
#import "ZXY_AlbumHotImage.h"


NSString *const kZXY_AlbumHotDataUser = @"user";
NSString *const kZXY_AlbumHotDataAlbumId = @"album_id";
NSString *const kZXY_AlbumHotDataImage = @"image";
NSString *const kZXY_AlbumHotDataUserId = @"user_id";
NSString *const kZXY_AlbumHotDataDescription = @"description";
NSString *const kZXY_AlbumHotDataAgreeCount = @"agree_count";
NSString *const kZXY_AlbumHotDataAddTime = @"add_time";


@interface ZXY_AlbumHotData ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ZXY_AlbumHotData

@synthesize user = _user;
@synthesize albumId = _albumId;
@synthesize image = _image;
@synthesize userId = _userId;
@synthesize dataDescription = _dataDescription;
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
            self.user = [ZXY_AlbumHotUser modelObjectWithDictionary:[dict objectForKey:kZXY_AlbumHotDataUser]];
            self.albumId = [self objectOrNilForKey:kZXY_AlbumHotDataAlbumId fromDictionary:dict];
            self.image = [ZXY_AlbumHotImage modelObjectWithDictionary:[dict objectForKey:kZXY_AlbumHotDataImage]];
            self.userId = [self objectOrNilForKey:kZXY_AlbumHotDataUserId fromDictionary:dict];
            self.dataDescription = [self objectOrNilForKey:kZXY_AlbumHotDataDescription fromDictionary:dict];
            self.agreeCount = [self objectOrNilForKey:kZXY_AlbumHotDataAgreeCount fromDictionary:dict];
            self.addTime = [self objectOrNilForKey:kZXY_AlbumHotDataAddTime fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[self.user dictionaryRepresentation] forKey:kZXY_AlbumHotDataUser];
    [mutableDict setValue:self.albumId forKey:kZXY_AlbumHotDataAlbumId];
    [mutableDict setValue:[self.image dictionaryRepresentation] forKey:kZXY_AlbumHotDataImage];
    [mutableDict setValue:self.userId forKey:kZXY_AlbumHotDataUserId];
    [mutableDict setValue:self.dataDescription forKey:kZXY_AlbumHotDataDescription];
    [mutableDict setValue:self.agreeCount forKey:kZXY_AlbumHotDataAgreeCount];
    [mutableDict setValue:self.addTime forKey:kZXY_AlbumHotDataAddTime];

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

    self.user = [aDecoder decodeObjectForKey:kZXY_AlbumHotDataUser];
    self.albumId = [aDecoder decodeObjectForKey:kZXY_AlbumHotDataAlbumId];
    self.image = [aDecoder decodeObjectForKey:kZXY_AlbumHotDataImage];
    self.userId = [aDecoder decodeObjectForKey:kZXY_AlbumHotDataUserId];
    self.dataDescription = [aDecoder decodeObjectForKey:kZXY_AlbumHotDataDescription];
    self.agreeCount = [aDecoder decodeObjectForKey:kZXY_AlbumHotDataAgreeCount];
    self.addTime = [aDecoder decodeObjectForKey:kZXY_AlbumHotDataAddTime];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_user forKey:kZXY_AlbumHotDataUser];
    [aCoder encodeObject:_albumId forKey:kZXY_AlbumHotDataAlbumId];
    [aCoder encodeObject:_image forKey:kZXY_AlbumHotDataImage];
    [aCoder encodeObject:_userId forKey:kZXY_AlbumHotDataUserId];
    [aCoder encodeObject:_dataDescription forKey:kZXY_AlbumHotDataDescription];
    [aCoder encodeObject:_agreeCount forKey:kZXY_AlbumHotDataAgreeCount];
    [aCoder encodeObject:_addTime forKey:kZXY_AlbumHotDataAddTime];
}

- (id)copyWithZone:(NSZone *)zone
{
    ZXY_AlbumHotData *copy = [[ZXY_AlbumHotData alloc] init];
    
    if (copy) {

        copy.user = [self.user copyWithZone:zone];
        copy.albumId = [self.albumId copyWithZone:zone];
        copy.image = [self.image copyWithZone:zone];
        copy.userId = [self.userId copyWithZone:zone];
        copy.dataDescription = [self.dataDescription copyWithZone:zone];
        copy.agreeCount = [self.agreeCount copyWithZone:zone];
        copy.addTime = [self.addTime copyWithZone:zone];
    }
    
    return copy;
}


@end
