//
//  CYMJAlbumMyCollectionData.m
//
//  Created by 超逸 李 on 15/2/12
//  Copyright (c) 2015 Duostec. All rights reserved.
//

#import "CYMJAlbumMyCollectionData.h"


NSString *const kCYMJAlbumMyCollectionDataNickName = @"nick_name";
NSString *const kCYMJAlbumMyCollectionDataAlbumId = @"album_id";
NSString *const kCYMJAlbumMyCollectionDataHeadImage = @"head_image";
NSString *const kCYMJAlbumMyCollectionDataCutHeight = @"cut_height";
NSString *const kCYMJAlbumMyCollectionDataCutPath = @"cut_path";
NSString *const kCYMJAlbumMyCollectionDataUserId = @"user_id";
NSString *const kCYMJAlbumMyCollectionDataDescription = @"description";
NSString *const kCYMJAlbumMyCollectionDataCutWidth = @"cut_width";
NSString *const kCYMJAlbumMyCollectionDataAgreeCount = @"agree_count";
NSString *const kCYMJAlbumMyCollectionDataAddTime = @"add_time";


@interface CYMJAlbumMyCollectionData ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation CYMJAlbumMyCollectionData

@synthesize nickName = _nickName;
@synthesize albumId = _albumId;
@synthesize headImage = _headImage;
@synthesize cutHeight = _cutHeight;
@synthesize cutPath = _cutPath;
@synthesize userId = _userId;
@synthesize dataDescription = _dataDescription;
@synthesize cutWidth = _cutWidth;
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
            self.nickName = [self objectOrNilForKey:kCYMJAlbumMyCollectionDataNickName fromDictionary:dict];
            self.albumId = [self objectOrNilForKey:kCYMJAlbumMyCollectionDataAlbumId fromDictionary:dict];
            self.headImage = [self objectOrNilForKey:kCYMJAlbumMyCollectionDataHeadImage fromDictionary:dict];
            self.cutHeight = [self objectOrNilForKey:kCYMJAlbumMyCollectionDataCutHeight fromDictionary:dict];
            self.cutPath = [self objectOrNilForKey:kCYMJAlbumMyCollectionDataCutPath fromDictionary:dict];
            self.userId = [self objectOrNilForKey:kCYMJAlbumMyCollectionDataUserId fromDictionary:dict];
            self.dataDescription = [self objectOrNilForKey:kCYMJAlbumMyCollectionDataDescription fromDictionary:dict];
            self.cutWidth = [self objectOrNilForKey:kCYMJAlbumMyCollectionDataCutWidth fromDictionary:dict];
            self.agreeCount = [self objectOrNilForKey:kCYMJAlbumMyCollectionDataAgreeCount fromDictionary:dict];
            self.addTime = [self objectOrNilForKey:kCYMJAlbumMyCollectionDataAddTime fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.nickName forKey:kCYMJAlbumMyCollectionDataNickName];
    [mutableDict setValue:self.albumId forKey:kCYMJAlbumMyCollectionDataAlbumId];
    [mutableDict setValue:self.headImage forKey:kCYMJAlbumMyCollectionDataHeadImage];
    [mutableDict setValue:self.cutHeight forKey:kCYMJAlbumMyCollectionDataCutHeight];
    [mutableDict setValue:self.cutPath forKey:kCYMJAlbumMyCollectionDataCutPath];
    [mutableDict setValue:self.userId forKey:kCYMJAlbumMyCollectionDataUserId];
    [mutableDict setValue:self.dataDescription forKey:kCYMJAlbumMyCollectionDataDescription];
    [mutableDict setValue:self.cutWidth forKey:kCYMJAlbumMyCollectionDataCutWidth];
    [mutableDict setValue:self.agreeCount forKey:kCYMJAlbumMyCollectionDataAgreeCount];
    [mutableDict setValue:self.addTime forKey:kCYMJAlbumMyCollectionDataAddTime];

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

    self.nickName = [aDecoder decodeObjectForKey:kCYMJAlbumMyCollectionDataNickName];
    self.albumId = [aDecoder decodeObjectForKey:kCYMJAlbumMyCollectionDataAlbumId];
    self.headImage = [aDecoder decodeObjectForKey:kCYMJAlbumMyCollectionDataHeadImage];
    self.cutHeight = [aDecoder decodeObjectForKey:kCYMJAlbumMyCollectionDataCutHeight];
    self.cutPath = [aDecoder decodeObjectForKey:kCYMJAlbumMyCollectionDataCutPath];
    self.userId = [aDecoder decodeObjectForKey:kCYMJAlbumMyCollectionDataUserId];
    self.dataDescription = [aDecoder decodeObjectForKey:kCYMJAlbumMyCollectionDataDescription];
    self.cutWidth = [aDecoder decodeObjectForKey:kCYMJAlbumMyCollectionDataCutWidth];
    self.agreeCount = [aDecoder decodeObjectForKey:kCYMJAlbumMyCollectionDataAgreeCount];
    self.addTime = [aDecoder decodeObjectForKey:kCYMJAlbumMyCollectionDataAddTime];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_nickName forKey:kCYMJAlbumMyCollectionDataNickName];
    [aCoder encodeObject:_albumId forKey:kCYMJAlbumMyCollectionDataAlbumId];
    [aCoder encodeObject:_headImage forKey:kCYMJAlbumMyCollectionDataHeadImage];
    [aCoder encodeObject:_cutHeight forKey:kCYMJAlbumMyCollectionDataCutHeight];
    [aCoder encodeObject:_cutPath forKey:kCYMJAlbumMyCollectionDataCutPath];
    [aCoder encodeObject:_userId forKey:kCYMJAlbumMyCollectionDataUserId];
    [aCoder encodeObject:_dataDescription forKey:kCYMJAlbumMyCollectionDataDescription];
    [aCoder encodeObject:_cutWidth forKey:kCYMJAlbumMyCollectionDataCutWidth];
    [aCoder encodeObject:_agreeCount forKey:kCYMJAlbumMyCollectionDataAgreeCount];
    [aCoder encodeObject:_addTime forKey:kCYMJAlbumMyCollectionDataAddTime];
}

- (id)copyWithZone:(NSZone *)zone
{
    CYMJAlbumMyCollectionData *copy = [[CYMJAlbumMyCollectionData alloc] init];
    
    if (copy) {

        copy.nickName = [self.nickName copyWithZone:zone];
        copy.albumId = [self.albumId copyWithZone:zone];
        copy.headImage = [self.headImage copyWithZone:zone];
        copy.cutHeight = [self.cutHeight copyWithZone:zone];
        copy.cutPath = [self.cutPath copyWithZone:zone];
        copy.userId = [self.userId copyWithZone:zone];
        copy.dataDescription = [self.dataDescription copyWithZone:zone];
        copy.cutWidth = [self.cutWidth copyWithZone:zone];
        copy.agreeCount = [self.agreeCount copyWithZone:zone];
        copy.addTime = [self.addTime copyWithZone:zone];
    }
    
    return copy;
}


@end
