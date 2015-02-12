//
//  CYMJAlbumMyCollectionBase.m
//
//  Created by 超逸 李 on 15/2/12
//  Copyright (c) 2015 Duostec. All rights reserved.
//

#import "CYMJAlbumMyCollectionBase.h"
#import "CYMJAlbumMyCollectionData.h"


NSString *const kCYMJAlbumMyCollectionBaseResult = @"result";
NSString *const kCYMJAlbumMyCollectionBaseData = @"data";


@interface CYMJAlbumMyCollectionBase ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation CYMJAlbumMyCollectionBase

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
            self.result = [[self objectOrNilForKey:kCYMJAlbumMyCollectionBaseResult fromDictionary:dict] doubleValue];
    NSObject *receivedCYMJAlbumMyCollectionData = [dict objectForKey:kCYMJAlbumMyCollectionBaseData];
    NSMutableArray *parsedCYMJAlbumMyCollectionData = [NSMutableArray array];
    if ([receivedCYMJAlbumMyCollectionData isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedCYMJAlbumMyCollectionData) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedCYMJAlbumMyCollectionData addObject:[CYMJAlbumMyCollectionData modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedCYMJAlbumMyCollectionData isKindOfClass:[NSDictionary class]]) {
       [parsedCYMJAlbumMyCollectionData addObject:[CYMJAlbumMyCollectionData modelObjectWithDictionary:(NSDictionary *)receivedCYMJAlbumMyCollectionData]];
    }

    self.data = [NSArray arrayWithArray:parsedCYMJAlbumMyCollectionData];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.result] forKey:kCYMJAlbumMyCollectionBaseResult];
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
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForData] forKey:kCYMJAlbumMyCollectionBaseData];

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

    self.result = [aDecoder decodeDoubleForKey:kCYMJAlbumMyCollectionBaseResult];
    self.data = [aDecoder decodeObjectForKey:kCYMJAlbumMyCollectionBaseData];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_result forKey:kCYMJAlbumMyCollectionBaseResult];
    [aCoder encodeObject:_data forKey:kCYMJAlbumMyCollectionBaseData];
}

- (id)copyWithZone:(NSZone *)zone
{
    CYMJAlbumMyCollectionBase *copy = [[CYMJAlbumMyCollectionBase alloc] init];
    
    if (copy) {

        copy.result = self.result;
        copy.data = [self.data copyWithZone:zone];
    }
    
    return copy;
}


@end
