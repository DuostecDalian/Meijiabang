//
//  ZXY_PictureDetailImages.m
//
//  Created by   on 15/2/2
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "ZXY_PictureDetailImages.h"


NSString *const kZXY_PictureDetailImagesHeight = @"height";
NSString *const kZXY_PictureDetailImagesImagePath = @"image_path";
NSString *const kZXY_PictureDetailImagesAlbumId = @"album_id";
NSString *const kZXY_PictureDetailImagesAddTime = @"add_time";
NSString *const kZXY_PictureDetailImagesImageId = @"image_id";
NSString *const kZXY_PictureDetailImagesCutPath = @"cut_path";
NSString *const kZXY_PictureDetailImagesWidth = @"width";
NSString *const kZXY_PictureDetailImagesIsFirst = @"is_first";
NSString *const kZXY_PictureDetailImagesCutWidth = @"cut_width";
NSString *const kZXY_PictureDetailImagesCutHeight = @"cut_height";


@interface ZXY_PictureDetailImages ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ZXY_PictureDetailImages

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
            self.height = [self objectOrNilForKey:kZXY_PictureDetailImagesHeight fromDictionary:dict];
            self.imagePath = [self objectOrNilForKey:kZXY_PictureDetailImagesImagePath fromDictionary:dict];
            self.albumId = [self objectOrNilForKey:kZXY_PictureDetailImagesAlbumId fromDictionary:dict];
            self.addTime = [self objectOrNilForKey:kZXY_PictureDetailImagesAddTime fromDictionary:dict];
            self.imageId = [self objectOrNilForKey:kZXY_PictureDetailImagesImageId fromDictionary:dict];
            self.cutPath = [self objectOrNilForKey:kZXY_PictureDetailImagesCutPath fromDictionary:dict];
            self.width = [self objectOrNilForKey:kZXY_PictureDetailImagesWidth fromDictionary:dict];
            self.isFirst = [self objectOrNilForKey:kZXY_PictureDetailImagesIsFirst fromDictionary:dict];
            self.cutWidth = [self objectOrNilForKey:kZXY_PictureDetailImagesCutWidth fromDictionary:dict];
            self.cutHeight = [self objectOrNilForKey:kZXY_PictureDetailImagesCutHeight fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.height forKey:kZXY_PictureDetailImagesHeight];
    [mutableDict setValue:self.imagePath forKey:kZXY_PictureDetailImagesImagePath];
    [mutableDict setValue:self.albumId forKey:kZXY_PictureDetailImagesAlbumId];
    [mutableDict setValue:self.addTime forKey:kZXY_PictureDetailImagesAddTime];
    [mutableDict setValue:self.imageId forKey:kZXY_PictureDetailImagesImageId];
    [mutableDict setValue:self.cutPath forKey:kZXY_PictureDetailImagesCutPath];
    [mutableDict setValue:self.width forKey:kZXY_PictureDetailImagesWidth];
    [mutableDict setValue:self.isFirst forKey:kZXY_PictureDetailImagesIsFirst];
    [mutableDict setValue:self.cutWidth forKey:kZXY_PictureDetailImagesCutWidth];
    [mutableDict setValue:self.cutHeight forKey:kZXY_PictureDetailImagesCutHeight];

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

    self.height = [aDecoder decodeObjectForKey:kZXY_PictureDetailImagesHeight];
    self.imagePath = [aDecoder decodeObjectForKey:kZXY_PictureDetailImagesImagePath];
    self.albumId = [aDecoder decodeObjectForKey:kZXY_PictureDetailImagesAlbumId];
    self.addTime = [aDecoder decodeObjectForKey:kZXY_PictureDetailImagesAddTime];
    self.imageId = [aDecoder decodeObjectForKey:kZXY_PictureDetailImagesImageId];
    self.cutPath = [aDecoder decodeObjectForKey:kZXY_PictureDetailImagesCutPath];
    self.width = [aDecoder decodeObjectForKey:kZXY_PictureDetailImagesWidth];
    self.isFirst = [aDecoder decodeObjectForKey:kZXY_PictureDetailImagesIsFirst];
    self.cutWidth = [aDecoder decodeObjectForKey:kZXY_PictureDetailImagesCutWidth];
    self.cutHeight = [aDecoder decodeObjectForKey:kZXY_PictureDetailImagesCutHeight];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_height forKey:kZXY_PictureDetailImagesHeight];
    [aCoder encodeObject:_imagePath forKey:kZXY_PictureDetailImagesImagePath];
    [aCoder encodeObject:_albumId forKey:kZXY_PictureDetailImagesAlbumId];
    [aCoder encodeObject:_addTime forKey:kZXY_PictureDetailImagesAddTime];
    [aCoder encodeObject:_imageId forKey:kZXY_PictureDetailImagesImageId];
    [aCoder encodeObject:_cutPath forKey:kZXY_PictureDetailImagesCutPath];
    [aCoder encodeObject:_width forKey:kZXY_PictureDetailImagesWidth];
    [aCoder encodeObject:_isFirst forKey:kZXY_PictureDetailImagesIsFirst];
    [aCoder encodeObject:_cutWidth forKey:kZXY_PictureDetailImagesCutWidth];
    [aCoder encodeObject:_cutHeight forKey:kZXY_PictureDetailImagesCutHeight];
}

- (id)copyWithZone:(NSZone *)zone
{
    ZXY_PictureDetailImages *copy = [[ZXY_PictureDetailImages alloc] init];
    
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
