//
//  ZXY_AlbumHotAlbumHot.m
//
//  Created by   on 15/1/27
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "ZXY_AlbumHotAlbumHot.h"
#import "ZXY_AlbumHotData.h"


NSString *const kZXY_AlbumHotAlbumHotResult = @"result";
NSString *const kZXY_AlbumHotAlbumHotData = @"data";


@interface ZXY_AlbumHotAlbumHot ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ZXY_AlbumHotAlbumHot

@synthesize result = _result;
@synthesize data = _data;


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
            self.result = [[self objectOrNilForKey:kZXY_AlbumHotAlbumHotResult fromDictionary:dict] doubleValue];
    NSObject *receivedZXY_AlbumHotData = [dict objectForKey:kZXY_AlbumHotAlbumHotData];
    NSMutableArray *parsedZXY_AlbumHotData = [NSMutableArray array];
    if ([receivedZXY_AlbumHotData isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedZXY_AlbumHotData) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedZXY_AlbumHotData addObject:[ZXY_AlbumHotData modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedZXY_AlbumHotData isKindOfClass:[NSDictionary class]]) {
       [parsedZXY_AlbumHotData addObject:[ZXY_AlbumHotData modelObjectWithDictionary:(NSDictionary *)receivedZXY_AlbumHotData]];
    }

    self.data = [NSArray arrayWithArray:parsedZXY_AlbumHotData];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.result] forKey:kZXY_AlbumHotAlbumHotResult];
    NSMutableArray *tempArrayForData = [NSMutableArray array];
    for (NSObject *subArrayObject in self.data) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForData addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForData addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForData] forKey:kZXY_AlbumHotAlbumHotData];

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

    self.result = [aDecoder decodeDoubleForKey:kZXY_AlbumHotAlbumHotResult];
    self.data = [aDecoder decodeObjectForKey:kZXY_AlbumHotAlbumHotData];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_result forKey:kZXY_AlbumHotAlbumHotResult];
    [aCoder encodeObject:_data forKey:kZXY_AlbumHotAlbumHotData];
}

- (id)copyWithZone:(NSZone *)zone
{
    ZXY_AlbumHotAlbumHot *copy = [[ZXY_AlbumHotAlbumHot alloc] init];
    
    if (copy) {

        copy.result = self.result;
        copy.data = [self.data copyWithZone:zone];
    }
    
    return copy;
}


@end
