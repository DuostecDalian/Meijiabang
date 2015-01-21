//
//  ZXYImage.m
//
//  Created by   on 15/1/21
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "ZXYImage.h"


NSString *const kZXYImageHeight = @"height";
NSString *const kZXYImageImagePath = @"image_path";
NSString *const kZXYImageAlbumId = @"album_id";
NSString *const kZXYImageAddTime = @"add_time";
NSString *const kZXYImageImageId = @"image_id";
NSString *const kZXYImageCutPath = @"cut_path";
NSString *const kZXYImageWidth = @"width";
NSString *const kZXYImageIsFirst = @"is_first";
NSString *const kZXYImageCutWidth = @"cut_width";
NSString *const kZXYImageCutHeight = @"cut_height";


@interface ZXYImage ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ZXYImage

@synthesize height = _height;
@synthesize imagePath = _imagePath;
@synthesize albumId = _albumId;
@synthesize addTime = _addTime;
@synthesize imageId = _imageId;
@synthesize cutPath = _cutPath;
@synthesize width = _width;
@synthesize isFirst = _isFirst;
@synthesize cutWidth = _cutWidth;
@synthesize cutHeight = _cutHeight;


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
            self.height = [self objectOrNilForKey:kZXYImageHeight fromDictionary:dict];
            self.imagePath = [self objectOrNilForKey:kZXYImageImagePath fromDictionary:dict];
            self.albumId = [self objectOrNilForKey:kZXYImageAlbumId fromDictionary:dict];
            self.addTime = [self objectOrNilForKey:kZXYImageAddTime fromDictionary:dict];
            self.imageId = [self objectOrNilForKey:kZXYImageImageId fromDictionary:dict];
            self.cutPath = [self objectOrNilForKey:kZXYImageCutPath fromDictionary:dict];
            self.width = [self objectOrNilForKey:kZXYImageWidth fromDictionary:dict];
            self.isFirst = [self objectOrNilForKey:kZXYImageIsFirst fromDictionary:dict];
            self.cutWidth = [self objectOrNilForKey:kZXYImageCutWidth fromDictionary:dict];
            self.cutHeight = [self objectOrNilForKey:kZXYImageCutHeight fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.height forKey:kZXYImageHeight];
    [mutableDict setValue:self.imagePath forKey:kZXYImageImagePath];
    [mutableDict setValue:self.albumId forKey:kZXYImageAlbumId];
    [mutableDict setValue:self.addTime forKey:kZXYImageAddTime];
    [mutableDict setValue:self.imageId forKey:kZXYImageImageId];
    [mutableDict setValue:self.cutPath forKey:kZXYImageCutPath];
    [mutableDict setValue:self.width forKey:kZXYImageWidth];
    [mutableDict setValue:self.isFirst forKey:kZXYImageIsFirst];
    [mutableDict setValue:self.cutWidth forKey:kZXYImageCutWidth];
    [mutableDict setValue:self.cutHeight forKey:kZXYImageCutHeight];

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

    self.height = [aDecoder decodeObjectForKey:kZXYImageHeight];
    self.imagePath = [aDecoder decodeObjectForKey:kZXYImageImagePath];
    self.albumId = [aDecoder decodeObjectForKey:kZXYImageAlbumId];
    self.addTime = [aDecoder decodeObjectForKey:kZXYImageAddTime];
    self.imageId = [aDecoder decodeObjectForKey:kZXYImageImageId];
    self.cutPath = [aDecoder decodeObjectForKey:kZXYImageCutPath];
    self.width = [aDecoder decodeObjectForKey:kZXYImageWidth];
    self.isFirst = [aDecoder decodeObjectForKey:kZXYImageIsFirst];
    self.cutWidth = [aDecoder decodeObjectForKey:kZXYImageCutWidth];
    self.cutHeight = [aDecoder decodeObjectForKey:kZXYImageCutHeight];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_height forKey:kZXYImageHeight];
    [aCoder encodeObject:_imagePath forKey:kZXYImageImagePath];
    [aCoder encodeObject:_albumId forKey:kZXYImageAlbumId];
    [aCoder encodeObject:_addTime forKey:kZXYImageAddTime];
    [aCoder encodeObject:_imageId forKey:kZXYImageImageId];
    [aCoder encodeObject:_cutPath forKey:kZXYImageCutPath];
    [aCoder encodeObject:_width forKey:kZXYImageWidth];
    [aCoder encodeObject:_isFirst forKey:kZXYImageIsFirst];
    [aCoder encodeObject:_cutWidth forKey:kZXYImageCutWidth];
    [aCoder encodeObject:_cutHeight forKey:kZXYImageCutHeight];
}

- (id)copyWithZone:(NSZone *)zone
{
    ZXYImage *copy = [[ZXYImage alloc] init];
    
    if (copy) {

        copy.height = [self.height copyWithZone:zone];
        copy.imagePath = [self.imagePath copyWithZone:zone];
        copy.albumId = [self.albumId copyWithZone:zone];
        copy.addTime = [self.addTime copyWithZone:zone];
        copy.imageId = [self.imageId copyWithZone:zone];
        copy.cutPath = [self.cutPath copyWithZone:zone];
        copy.width = [self.width copyWithZone:zone];
        copy.isFirst = [self.isFirst copyWithZone:zone];
        copy.cutWidth = [self.cutWidth copyWithZone:zone];
        copy.cutHeight = [self.cutHeight copyWithZone:zone];
    }
    
    return copy;
}


@end
