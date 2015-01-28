//
//  ZXYAlbumSqureData.m
//
//  Created by   on 15/1/28
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "ZXYAlbumSqureData.h"
#import "ZXYAlbumSqureRecommendAlbum.h"
#import "ZXYAlbumSqureLastAlbum.h"


NSString *const kZXYAlbumSqureDataRecommendAlbum = @"recommend_album";
NSString *const kZXYAlbumSqureDataLastAlbum = @"last_album";


@interface ZXYAlbumSqureData ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ZXYAlbumSqureData

@synthesize recommendAlbum = _recommendAlbum;
@synthesize lastAlbum = _lastAlbum;


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
    NSObject *receivedZXYAlbumSqureRecommendAlbum = [dict objectForKey:kZXYAlbumSqureDataRecommendAlbum];
    NSMutableArray *parsedZXYAlbumSqureRecommendAlbum = [NSMutableArray array];
    if ([receivedZXYAlbumSqureRecommendAlbum isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedZXYAlbumSqureRecommendAlbum) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedZXYAlbumSqureRecommendAlbum addObject:[ZXYAlbumSqureRecommendAlbum modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedZXYAlbumSqureRecommendAlbum isKindOfClass:[NSDictionary class]]) {
       [parsedZXYAlbumSqureRecommendAlbum addObject:[ZXYAlbumSqureRecommendAlbum modelObjectWithDictionary:(NSDictionary *)receivedZXYAlbumSqureRecommendAlbum]];
    }

    self.recommendAlbum = [NSArray arrayWithArray:parsedZXYAlbumSqureRecommendAlbum];
    NSObject *receivedZXYAlbumSqureLastAlbum = [dict objectForKey:kZXYAlbumSqureDataLastAlbum];
    NSMutableArray *parsedZXYAlbumSqureLastAlbum = [NSMutableArray array];
    if ([receivedZXYAlbumSqureLastAlbum isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedZXYAlbumSqureLastAlbum) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedZXYAlbumSqureLastAlbum addObject:[ZXYAlbumSqureLastAlbum modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedZXYAlbumSqureLastAlbum isKindOfClass:[NSDictionary class]]) {
       [parsedZXYAlbumSqureLastAlbum addObject:[ZXYAlbumSqureLastAlbum modelObjectWithDictionary:(NSDictionary *)receivedZXYAlbumSqureLastAlbum]];
    }

    self.lastAlbum = [NSArray arrayWithArray:parsedZXYAlbumSqureLastAlbum];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    NSMutableArray *tempArrayForRecommendAlbum = [NSMutableArray array];
    for (NSObject *subArrayObject in self.recommendAlbum) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForRecommendAlbum addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForRecommendAlbum addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForRecommendAlbum] forKey:kZXYAlbumSqureDataRecommendAlbum];
    NSMutableArray *tempArrayForLastAlbum = [NSMutableArray array];
    for (NSObject *subArrayObject in self.lastAlbum) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForLastAlbum addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForLastAlbum addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForLastAlbum] forKey:kZXYAlbumSqureDataLastAlbum];

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

    self.recommendAlbum = [aDecoder decodeObjectForKey:kZXYAlbumSqureDataRecommendAlbum];
    self.lastAlbum = [aDecoder decodeObjectForKey:kZXYAlbumSqureDataLastAlbum];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_recommendAlbum forKey:kZXYAlbumSqureDataRecommendAlbum];
    [aCoder encodeObject:_lastAlbum forKey:kZXYAlbumSqureDataLastAlbum];
}

- (id)copyWithZone:(NSZone *)zone
{
    ZXYAlbumSqureData *copy = [[ZXYAlbumSqureData alloc] init];
    
    if (copy) {

        copy.recommendAlbum = [self.recommendAlbum copyWithZone:zone];
        copy.lastAlbum = [self.lastAlbum copyWithZone:zone];
    }
    
    return copy;
}


@end
