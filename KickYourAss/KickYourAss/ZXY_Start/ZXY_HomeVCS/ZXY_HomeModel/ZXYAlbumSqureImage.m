//
//  ZXYAlbumSqureImage.m
//
//  Created by   on 15/1/28
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "ZXYAlbumSqureImage.h"


NSString *const kZXYAlbumSqureImageCutWidth = @"cut_width";
NSString *const kZXYAlbumSqureImageCutPath = @"cut_path";
NSString *const kZXYAlbumSqureImageCutHeight = @"cut_height";


@interface ZXYAlbumSqureImage ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ZXYAlbumSqureImage

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
            self.cutWidth = [self objectOrNilForKey:kZXYAlbumSqureImageCutWidth fromDictionary:dict];
            self.cutPath = [self objectOrNilForKey:kZXYAlbumSqureImageCutPath fromDictionary:dict];
            self.cutHeight = [self objectOrNilForKey:kZXYAlbumSqureImageCutHeight fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.cutWidth forKey:kZXYAlbumSqureImageCutWidth];
    [mutableDict setValue:self.cutPath forKey:kZXYAlbumSqureImageCutPath];
    [mutableDict setValue:self.cutHeight forKey:kZXYAlbumSqureImageCutHeight];

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

    self.cutWidth = [aDecoder decodeObjectForKey:kZXYAlbumSqureImageCutWidth];
    self.cutPath = [aDecoder decodeObjectForKey:kZXYAlbumSqureImageCutPath];
    self.cutHeight = [aDecoder decodeObjectForKey:kZXYAlbumSqureImageCutHeight];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_cutWidth forKey:kZXYAlbumSqureImageCutWidth];
    [aCoder encodeObject:_cutPath forKey:kZXYAlbumSqureImageCutPath];
    [aCoder encodeObject:_cutHeight forKey:kZXYAlbumSqureImageCutHeight];
}

- (id)copyWithZone:(NSZone *)zone
{
    ZXYAlbumSqureImage *copy = [[ZXYAlbumSqureImage alloc] init];
    
    if (copy) {

        copy.cutWidth = [self.cutWidth copyWithZone:zone];
        copy.cutPath = [self.cutPath copyWithZone:zone];
        copy.cutHeight = [self.cutHeight copyWithZone:zone];
    }
    
    return copy;
}


@end
