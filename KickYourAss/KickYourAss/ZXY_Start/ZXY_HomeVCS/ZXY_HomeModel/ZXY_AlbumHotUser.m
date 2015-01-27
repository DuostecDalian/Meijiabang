//
//  ZXY_AlbumHotUser.m
//
//  Created by   on 15/1/27
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "ZXY_AlbumHotUser.h"


NSString *const kZXY_AlbumHotUserNickName = @"nick_name";
NSString *const kZXY_AlbumHotUserRole = @"role";
NSString *const kZXY_AlbumHotUserHeadImage = @"head_image";


@interface ZXY_AlbumHotUser ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ZXY_AlbumHotUser

@synthesize nickName = _nickName;
@synthesize role = _role;
@synthesize headImage = _headImage;


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
            self.nickName = [self objectOrNilForKey:kZXY_AlbumHotUserNickName fromDictionary:dict];
            self.role = [self objectOrNilForKey:kZXY_AlbumHotUserRole fromDictionary:dict];
            self.headImage = [self objectOrNilForKey:kZXY_AlbumHotUserHeadImage fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.nickName forKey:kZXY_AlbumHotUserNickName];
    [mutableDict setValue:self.role forKey:kZXY_AlbumHotUserRole];
    [mutableDict setValue:self.headImage forKey:kZXY_AlbumHotUserHeadImage];

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

    self.nickName = [aDecoder decodeObjectForKey:kZXY_AlbumHotUserNickName];
    self.role = [aDecoder decodeObjectForKey:kZXY_AlbumHotUserRole];
    self.headImage = [aDecoder decodeObjectForKey:kZXY_AlbumHotUserHeadImage];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_nickName forKey:kZXY_AlbumHotUserNickName];
    [aCoder encodeObject:_role forKey:kZXY_AlbumHotUserRole];
    [aCoder encodeObject:_headImage forKey:kZXY_AlbumHotUserHeadImage];
}

- (id)copyWithZone:(NSZone *)zone
{
    ZXY_AlbumHotUser *copy = [[ZXY_AlbumHotUser alloc] init];
    
    if (copy) {

        copy.nickName = [self.nickName copyWithZone:zone];
        copy.role = [self.role copyWithZone:zone];
        copy.headImage = [self.headImage copyWithZone:zone];
    }
    
    return copy;
}


@end
