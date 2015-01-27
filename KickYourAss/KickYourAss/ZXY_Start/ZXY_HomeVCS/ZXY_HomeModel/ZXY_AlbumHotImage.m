//
//  ZXY_AlbumHotImage.m
//
//  Created by   on 15/1/27
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "ZXY_AlbumHotImage.h"


NSString *const kZXY_AlbumHotImageCutWidth = @"cut_width";
NSString *const kZXY_AlbumHotImageCutPath = @"cut_path";
NSString *const kZXY_AlbumHotImageCutHeight = @"cut_height";


@interface ZXY_AlbumHotImage ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ZXY_AlbumHotImage

@synthesize cutWidth = _cutWidth;
@synthesize cutPath = _cutPath;
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
            self.cutWidth = [self objectOrNilForKey:kZXY_AlbumHotImageCutWidth fromDictionary:dict];
            self.cutPath = [self objectOrNilForKey:kZXY_AlbumHotImageCutPath fromDictionary:dict];
            self.cutHeight = [self objectOrNilForKey:kZXY_AlbumHotImageCutHeight fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.cutWidth forKey:kZXY_AlbumHotImageCutWidth];
    [mutableDict setValue:self.cutPath forKey:kZXY_AlbumHotImageCutPath];
    [mutableDict setValue:self.cutHeight forKey:kZXY_AlbumHotImageCutHeight];

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

    self.cutWidth = [aDecoder decodeObjectForKey:kZXY_AlbumHotImageCutWidth];
    self.cutPath = [aDecoder decodeObjectForKey:kZXY_AlbumHotImageCutPath];
    self.cutHeight = [aDecoder decodeObjectForKey:kZXY_AlbumHotImageCutHeight];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_cutWidth forKey:kZXY_AlbumHotImageCutWidth];
    [aCoder encodeObject:_cutPath forKey:kZXY_AlbumHotImageCutPath];
    [aCoder encodeObject:_cutHeight forKey:kZXY_AlbumHotImageCutHeight];
}

- (id)copyWithZone:(NSZone *)zone
{
    ZXY_AlbumHotImage *copy = [[ZXY_AlbumHotImage alloc] init];
    
    if (copy) {

        copy.cutWidth = [self.cutWidth copyWithZone:zone];
        copy.cutPath = [self.cutPath copyWithZone:zone];
        copy.cutHeight = [self.cutHeight copyWithZone:zone];
    }
    
    return copy;
}


@end
