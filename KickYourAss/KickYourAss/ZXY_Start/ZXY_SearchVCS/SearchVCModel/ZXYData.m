//
//  ZXYData.m
//
//  Created by   on 15/1/21
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "ZXYData.h"
#import "ZXYImage.h"


NSString *const kZXYDataP = @"p";
NSString *const kZXYDataHeadImage = @"head_image";
NSString *const kZXYDataLongitude = @"longitude";
NSString *const kZXYDataNickName = @"nick_name";
NSString *const kZXYDataLatitude = @"latitude";
NSString *const kZXYDataUserId = @"user_id";
NSString *const kZXYDataAlbumCount = @"album_count";
NSString *const kZXYDataImage = @"image";
NSString *const kZXYDataRole = @"role";
NSString *const kZXYDataScore = @"score";
NSString *const kZXYDataIsPass = @"is_pass";
NSString *const kZXYDataIsAttention = @"is_attention";


@interface ZXYData ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ZXYData

@synthesize p = _p;
@synthesize headImage = _headImage;
@synthesize longitude = _longitude;
@synthesize nickName = _nickName;
@synthesize latitude = _latitude;
@synthesize userId = _userId;
@synthesize albumCount = _albumCount;
@synthesize image = _image;
@synthesize role = _role;
@synthesize score = _score;
@synthesize isPass = _isPass;
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
            self.p = [self objectOrNilForKey:kZXYDataP fromDictionary:dict];
            self.headImage = [self objectOrNilForKey:kZXYDataHeadImage fromDictionary:dict];
            self.longitude = [self objectOrNilForKey:kZXYDataLongitude fromDictionary:dict];
            self.nickName = [self objectOrNilForKey:kZXYDataNickName fromDictionary:dict];
            self.latitude = [self objectOrNilForKey:kZXYDataLatitude fromDictionary:dict];
            self.userId = [self objectOrNilForKey:kZXYDataUserId fromDictionary:dict];
            self.albumCount = [self objectOrNilForKey:kZXYDataAlbumCount fromDictionary:dict];
    NSObject *receivedZXYImage = [dict objectForKey:kZXYDataImage];
    NSMutableArray *parsedZXYImage = [NSMutableArray array];
    if ([receivedZXYImage isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedZXYImage) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedZXYImage addObject:[ZXYImage modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedZXYImage isKindOfClass:[NSDictionary class]]) {
       [parsedZXYImage addObject:[ZXYImage modelObjectWithDictionary:(NSDictionary *)receivedZXYImage]];
    }

    self.image = [NSArray arrayWithArray:parsedZXYImage];
            self.role = [self objectOrNilForKey:kZXYDataRole fromDictionary:dict];
            self.score = [self objectOrNilForKey:kZXYDataScore fromDictionary:dict];
            self.isPass = [self objectOrNilForKey:kZXYDataIsPass fromDictionary:dict];
            self.isAttention = [[self objectOrNilForKey:kZXYDataIsAttention fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.p forKey:kZXYDataP];
    [mutableDict setValue:self.headImage forKey:kZXYDataHeadImage];
    [mutableDict setValue:self.longitude forKey:kZXYDataLongitude];
    [mutableDict setValue:self.nickName forKey:kZXYDataNickName];
    [mutableDict setValue:self.latitude forKey:kZXYDataLatitude];
    [mutableDict setValue:self.userId forKey:kZXYDataUserId];
    [mutableDict setValue:self.albumCount forKey:kZXYDataAlbumCount];
    NSMutableArray *tempArrayForImage = [NSMutableArray array];
    for (NSObject *subArrayObject in self.image) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForImage addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForImage addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForImage] forKey:kZXYDataImage];
    [mutableDict setValue:self.role forKey:kZXYDataRole];
    [mutableDict setValue:self.score forKey:kZXYDataScore];
    [mutableDict setValue:self.isPass forKey:kZXYDataIsPass];
    [mutableDict setValue:[NSNumber numberWithDouble:self.isAttention] forKey:kZXYDataIsAttention];

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

    self.p = [aDecoder decodeObjectForKey:kZXYDataP];
    self.headImage = [aDecoder decodeObjectForKey:kZXYDataHeadImage];
    self.longitude = [aDecoder decodeObjectForKey:kZXYDataLongitude];
    self.nickName = [aDecoder decodeObjectForKey:kZXYDataNickName];
    self.latitude = [aDecoder decodeObjectForKey:kZXYDataLatitude];
    self.userId = [aDecoder decodeObjectForKey:kZXYDataUserId];
    self.albumCount = [aDecoder decodeObjectForKey:kZXYDataAlbumCount];
    self.image = [aDecoder decodeObjectForKey:kZXYDataImage];
    self.role = [aDecoder decodeObjectForKey:kZXYDataRole];
    self.score = [aDecoder decodeObjectForKey:kZXYDataScore];
    self.isPass = [aDecoder decodeObjectForKey:kZXYDataIsPass];
    self.isAttention = [aDecoder decodeDoubleForKey:kZXYDataIsAttention];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_p forKey:kZXYDataP];
    [aCoder encodeObject:_headImage forKey:kZXYDataHeadImage];
    [aCoder encodeObject:_longitude forKey:kZXYDataLongitude];
    [aCoder encodeObject:_nickName forKey:kZXYDataNickName];
    [aCoder encodeObject:_latitude forKey:kZXYDataLatitude];
    [aCoder encodeObject:_userId forKey:kZXYDataUserId];
    [aCoder encodeObject:_albumCount forKey:kZXYDataAlbumCount];
    [aCoder encodeObject:_image forKey:kZXYDataImage];
    [aCoder encodeObject:_role forKey:kZXYDataRole];
    [aCoder encodeObject:_score forKey:kZXYDataScore];
    [aCoder encodeObject:_isPass forKey:kZXYDataIsPass];
    [aCoder encodeDouble:_isAttention forKey:kZXYDataIsAttention];
}

- (id)copyWithZone:(NSZone *)zone
{
    ZXYData *copy = [[ZXYData alloc] init];
    
    if (copy) {

        copy.p = [self.p copyWithZone:zone];
        copy.headImage = [self.headImage copyWithZone:zone];
        copy.longitude = [self.longitude copyWithZone:zone];
        copy.nickName = [self.nickName copyWithZone:zone];
        copy.latitude = [self.latitude copyWithZone:zone];
        copy.userId = [self.userId copyWithZone:zone];
        copy.albumCount = [self.albumCount copyWithZone:zone];
        copy.image = [self.image copyWithZone:zone];
        copy.role = [self.role copyWithZone:zone];
        copy.score = [self.score copyWithZone:zone];
        copy.isPass = [self.isPass copyWithZone:zone];
        copy.isAttention = self.isAttention;
    }
    
    return copy;
}


@end
