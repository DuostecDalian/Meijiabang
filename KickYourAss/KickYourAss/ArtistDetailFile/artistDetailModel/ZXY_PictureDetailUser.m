//
//  ZXY_PictureDetailUser.m
//
//  Created by   on 15/2/2
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "ZXY_PictureDetailUser.h"


NSString *const kZXY_PictureDetailUserNickName = @"nick_name";
NSString *const kZXY_PictureDetailUserAttention = @"attention";
NSString *const kZXY_PictureDetailUserScore = @"score";
NSString *const kZXY_PictureDetailUserHeadImage = @"head_image";
NSString *const kZXY_PictureDetailUserRole = @"role";
NSString *const kZXY_PictureDetailUserUserId = @"user_id";
NSString *const kZXY_PictureDetailUserByAttention = @"by_attention";
NSString *const kZXY_PictureDetailUserAlbumCount = @"album_count";
NSString *const kZXY_PictureDetailUserAddTime = @"add_time";


@interface ZXY_PictureDetailUser ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ZXY_PictureDetailUser

@synthesize nickName = _nickName;
@synthesize attention = _attention;
@synthesize score = _score;
@synthesize headImage = _headImage;
@synthesize role = _role;
@synthesize userId = _userId;
@synthesize byAttention = _byAttention;
@synthesize albumCount = _albumCount;
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
            self.nickName = [self objectOrNilForKey:kZXY_PictureDetailUserNickName fromDictionary:dict];
            self.attention = [self objectOrNilForKey:kZXY_PictureDetailUserAttention fromDictionary:dict];
            self.score = [self objectOrNilForKey:kZXY_PictureDetailUserScore fromDictionary:dict];
            self.headImage = [self objectOrNilForKey:kZXY_PictureDetailUserHeadImage fromDictionary:dict];
            self.role = [self objectOrNilForKey:kZXY_PictureDetailUserRole fromDictionary:dict];
            self.userId = [self objectOrNilForKey:kZXY_PictureDetailUserUserId fromDictionary:dict];
            self.byAttention = [self objectOrNilForKey:kZXY_PictureDetailUserByAttention fromDictionary:dict];
            self.albumCount = [self objectOrNilForKey:kZXY_PictureDetailUserAlbumCount fromDictionary:dict];
            self.addTime = [self objectOrNilForKey:kZXY_PictureDetailUserAddTime fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.nickName forKey:kZXY_PictureDetailUserNickName];
    [mutableDict setValue:self.attention forKey:kZXY_PictureDetailUserAttention];
    [mutableDict setValue:self.score forKey:kZXY_PictureDetailUserScore];
    [mutableDict setValue:self.headImage forKey:kZXY_PictureDetailUserHeadImage];
    [mutableDict setValue:self.role forKey:kZXY_PictureDetailUserRole];
    [mutableDict setValue:self.userId forKey:kZXY_PictureDetailUserUserId];
    [mutableDict setValue:self.byAttention forKey:kZXY_PictureDetailUserByAttention];
    [mutableDict setValue:self.albumCount forKey:kZXY_PictureDetailUserAlbumCount];
    [mutableDict setValue:self.addTime forKey:kZXY_PictureDetailUserAddTime];

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

    self.nickName = [aDecoder decodeObjectForKey:kZXY_PictureDetailUserNickName];
    self.attention = [aDecoder decodeObjectForKey:kZXY_PictureDetailUserAttention];
    self.score = [aDecoder decodeObjectForKey:kZXY_PictureDetailUserScore];
    self.headImage = [aDecoder decodeObjectForKey:kZXY_PictureDetailUserHeadImage];
    self.role = [aDecoder decodeObjectForKey:kZXY_PictureDetailUserRole];
    self.userId = [aDecoder decodeObjectForKey:kZXY_PictureDetailUserUserId];
    self.byAttention = [aDecoder decodeObjectForKey:kZXY_PictureDetailUserByAttention];
    self.albumCount = [aDecoder decodeObjectForKey:kZXY_PictureDetailUserAlbumCount];
    self.addTime = [aDecoder decodeObjectForKey:kZXY_PictureDetailUserAddTime];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_nickName forKey:kZXY_PictureDetailUserNickName];
    [aCoder encodeObject:_attention forKey:kZXY_PictureDetailUserAttention];
    [aCoder encodeObject:_score forKey:kZXY_PictureDetailUserScore];
    [aCoder encodeObject:_headImage forKey:kZXY_PictureDetailUserHeadImage];
    [aCoder encodeObject:_role forKey:kZXY_PictureDetailUserRole];
    [aCoder encodeObject:_userId forKey:kZXY_PictureDetailUserUserId];
    [aCoder encodeObject:_byAttention forKey:kZXY_PictureDetailUserByAttention];
    [aCoder encodeObject:_albumCount forKey:kZXY_PictureDetailUserAlbumCount];
    [aCoder encodeObject:_addTime forKey:kZXY_PictureDetailUserAddTime];
}

- (id)copyWithZone:(NSZone *)zone
{
    ZXY_PictureDetailUser *copy = [[ZXY_PictureDetailUser alloc] init];
    
    if (copy) {

        copy.nickName = [self.nickName copyWithZone:zone];
        copy.attention = [self.attention copyWithZone:zone];
        copy.score = [self.score copyWithZone:zone];
        copy.headImage = [self.headImage copyWithZone:zone];
        copy.role = [self.role copyWithZone:zone];
        copy.userId = [self.userId copyWithZone:zone];
        copy.byAttention = [self.byAttention copyWithZone:zone];
        copy.albumCount = [self.albumCount copyWithZone:zone];
        copy.addTime = [self.addTime copyWithZone:zone];
    }
    
    return copy;
}


@end
