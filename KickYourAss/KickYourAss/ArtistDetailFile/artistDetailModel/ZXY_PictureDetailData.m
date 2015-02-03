//
//  ZXY_PictureDetailData.m
//
//  Created by   on 15/2/2
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "ZXY_PictureDetailData.h"
#import "ZXY_PictureDetailImages.h"
#import "ZXY_PictureDetailUser.h"


NSString *const kZXY_PictureDetailDataDescription = @"description";
NSString *const kZXY_PictureDetailDataIsCollect = @"is_collect";
NSString *const kZXY_PictureDetailDataCollectCount = @"collect_count";
NSString *const kZXY_PictureDetailDataImgCount = @"img_count";
NSString *const kZXY_PictureDetailDataUserId = @"user_id";
NSString *const kZXY_PictureDetailDataIsAtten = @"is_atten";
NSString *const kZXY_PictureDetailDataAgreeCount = @"agree_count";
NSString *const kZXY_PictureDetailDataImages = @"images";
NSString *const kZXY_PictureDetailDataIsAgree = @"is_agree";
NSString *const kZXY_PictureDetailDataAddTime = @"add_time";
NSString *const kZXY_PictureDetailDataAlbumId = @"album_id";
NSString *const kZXY_PictureDetailDataUser = @"user";


@interface ZXY_PictureDetailData ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ZXY_PictureDetailData

@synthesize dataDescription = _dataDescription;
@synthesize isCollect = _isCollect;
@synthesize collectCount = _collectCount;
@synthesize imgCount = _imgCount;
@synthesize userId = _userId;
@synthesize isAtten = _isAtten;
@synthesize agreeCount = _agreeCount;
@synthesize images = _images;
@synthesize isAgree = _isAgree;
@synthesize addTime = _addTime;
@synthesize albumId = _albumId;
@synthesize user = _user;


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
            self.dataDescription = [self objectOrNilForKey:kZXY_PictureDetailDataDescription fromDictionary:dict];
            self.isCollect = [[self objectOrNilForKey:kZXY_PictureDetailDataIsCollect fromDictionary:dict] doubleValue];
            self.collectCount = [self objectOrNilForKey:kZXY_PictureDetailDataCollectCount fromDictionary:dict];
            self.imgCount = [self objectOrNilForKey:kZXY_PictureDetailDataImgCount fromDictionary:dict];
            self.userId = [self objectOrNilForKey:kZXY_PictureDetailDataUserId fromDictionary:dict];
            self.isAtten = [[self objectOrNilForKey:kZXY_PictureDetailDataIsAtten fromDictionary:dict] doubleValue];
            self.agreeCount = [self objectOrNilForKey:kZXY_PictureDetailDataAgreeCount fromDictionary:dict];
    NSObject *receivedZXY_PictureDetailImages = [dict objectForKey:kZXY_PictureDetailDataImages];
    NSMutableArray *parsedZXY_PictureDetailImages = [NSMutableArray array];
    if ([receivedZXY_PictureDetailImages isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedZXY_PictureDetailImages) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedZXY_PictureDetailImages addObject:[ZXY_PictureDetailImages modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedZXY_PictureDetailImages isKindOfClass:[NSDictionary class]]) {
       [parsedZXY_PictureDetailImages addObject:[ZXY_PictureDetailImages modelObjectWithDictionary:(NSDictionary *)receivedZXY_PictureDetailImages]];
    }

    self.images = [NSArray arrayWithArray:parsedZXY_PictureDetailImages];
            self.isAgree = [[self objectOrNilForKey:kZXY_PictureDetailDataIsAgree fromDictionary:dict] doubleValue];
            self.addTime = [self objectOrNilForKey:kZXY_PictureDetailDataAddTime fromDictionary:dict];
            self.albumId = [self objectOrNilForKey:kZXY_PictureDetailDataAlbumId fromDictionary:dict];
            self.user = [ZXY_PictureDetailUser modelObjectWithDictionary:[dict objectForKey:kZXY_PictureDetailDataUser]];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.dataDescription forKey:kZXY_PictureDetailDataDescription];
    [mutableDict setValue:[NSNumber numberWithDouble:self.isCollect] forKey:kZXY_PictureDetailDataIsCollect];
    [mutableDict setValue:self.collectCount forKey:kZXY_PictureDetailDataCollectCount];
    [mutableDict setValue:self.imgCount forKey:kZXY_PictureDetailDataImgCount];
    [mutableDict setValue:self.userId forKey:kZXY_PictureDetailDataUserId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.isAtten] forKey:kZXY_PictureDetailDataIsAtten];
    [mutableDict setValue:self.agreeCount forKey:kZXY_PictureDetailDataAgreeCount];
    NSMutableArray *tempArrayForImages = [NSMutableArray array];
    for (NSObject *subArrayObject in self.images) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForImages addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForImages addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForImages] forKey:kZXY_PictureDetailDataImages];
    [mutableDict setValue:[NSNumber numberWithDouble:self.isAgree] forKey:kZXY_PictureDetailDataIsAgree];
    [mutableDict setValue:self.addTime forKey:kZXY_PictureDetailDataAddTime];
    [mutableDict setValue:self.albumId forKey:kZXY_PictureDetailDataAlbumId];
    [mutableDict setValue:[self.user dictionaryRepresentation] forKey:kZXY_PictureDetailDataUser];

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

    self.dataDescription = [aDecoder decodeObjectForKey:kZXY_PictureDetailDataDescription];
    self.isCollect = [aDecoder decodeDoubleForKey:kZXY_PictureDetailDataIsCollect];
    self.collectCount = [aDecoder decodeObjectForKey:kZXY_PictureDetailDataCollectCount];
    self.imgCount = [aDecoder decodeObjectForKey:kZXY_PictureDetailDataImgCount];
    self.userId = [aDecoder decodeObjectForKey:kZXY_PictureDetailDataUserId];
    self.isAtten = [aDecoder decodeDoubleForKey:kZXY_PictureDetailDataIsAtten];
    self.agreeCount = [aDecoder decodeObjectForKey:kZXY_PictureDetailDataAgreeCount];
    self.images = [aDecoder decodeObjectForKey:kZXY_PictureDetailDataImages];
    self.isAgree = [aDecoder decodeDoubleForKey:kZXY_PictureDetailDataIsAgree];
    self.addTime = [aDecoder decodeObjectForKey:kZXY_PictureDetailDataAddTime];
    self.albumId = [aDecoder decodeObjectForKey:kZXY_PictureDetailDataAlbumId];
    self.user = [aDecoder decodeObjectForKey:kZXY_PictureDetailDataUser];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_dataDescription forKey:kZXY_PictureDetailDataDescription];
    [aCoder encodeDouble:_isCollect forKey:kZXY_PictureDetailDataIsCollect];
    [aCoder encodeObject:_collectCount forKey:kZXY_PictureDetailDataCollectCount];
    [aCoder encodeObject:_imgCount forKey:kZXY_PictureDetailDataImgCount];
    [aCoder encodeObject:_userId forKey:kZXY_PictureDetailDataUserId];
    [aCoder encodeDouble:_isAtten forKey:kZXY_PictureDetailDataIsAtten];
    [aCoder encodeObject:_agreeCount forKey:kZXY_PictureDetailDataAgreeCount];
    [aCoder encodeObject:_images forKey:kZXY_PictureDetailDataImages];
    [aCoder encodeDouble:_isAgree forKey:kZXY_PictureDetailDataIsAgree];
    [aCoder encodeObject:_addTime forKey:kZXY_PictureDetailDataAddTime];
    [aCoder encodeObject:_albumId forKey:kZXY_PictureDetailDataAlbumId];
    [aCoder encodeObject:_user forKey:kZXY_PictureDetailDataUser];
}

- (id)copyWithZone:(NSZone *)zone
{
    ZXY_PictureDetailData *copy = [[ZXY_PictureDetailData alloc] init];
    
    if (copy) {

        copy.dataDescription = [self.dataDescription copyWithZone:zone];
        copy.isCollect = self.isCollect;
        copy.collectCount = [self.collectCount copyWithZone:zone];
        copy.imgCount = [self.imgCount copyWithZone:zone];
        copy.userId = [self.userId copyWithZone:zone];
        copy.isAtten = self.isAtten;
        copy.agreeCount = [self.agreeCount copyWithZone:zone];
        copy.images = [self.images copyWithZone:zone];
        copy.isAgree = self.isAgree;
        copy.addTime = [self.addTime copyWithZone:zone];
        copy.albumId = [self.albumId copyWithZone:zone];
        copy.user = [self.user copyWithZone:zone];
    }
    
    return copy;
}


@end
