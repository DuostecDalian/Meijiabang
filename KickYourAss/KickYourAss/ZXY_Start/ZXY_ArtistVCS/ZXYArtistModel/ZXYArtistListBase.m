//
//  ZXYArtistListBase.m
//
//  Created by   on 15/1/28
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "ZXYArtistListBase.h"
#import "ZXYArtistListData.h"


NSString *const kZXYArtistListBaseResult = @"result";
NSString *const kZXYArtistListBaseData = @"data";


@interface ZXYArtistListBase ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ZXYArtistListBase

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
            self.result = [[self objectOrNilForKey:kZXYArtistListBaseResult fromDictionary:dict] doubleValue];
    NSObject *receivedZXYArtistListData = [dict objectForKey:kZXYArtistListBaseData];
    NSMutableArray *parsedZXYArtistListData = [NSMutableArray array];
    if ([receivedZXYArtistListData isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedZXYArtistListData) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedZXYArtistListData addObject:[ZXYArtistListData modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedZXYArtistListData isKindOfClass:[NSDictionary class]]) {
       [parsedZXYArtistListData addObject:[ZXYArtistListData modelObjectWithDictionary:(NSDictionary *)receivedZXYArtistListData]];
    }

    self.data = [NSArray arrayWithArray:parsedZXYArtistListData];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.result] forKey:kZXYArtistListBaseResult];
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
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForData] forKey:kZXYArtistListBaseData];

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

    self.result = [aDecoder decodeDoubleForKey:kZXYArtistListBaseResult];
    self.data = [aDecoder decodeObjectForKey:kZXYArtistListBaseData];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_result forKey:kZXYArtistListBaseResult];
    [aCoder encodeObject:_data forKey:kZXYArtistListBaseData];
}

- (id)copyWithZone:(NSZone *)zone
{
    ZXYArtistListBase *copy = [[ZXYArtistListBase alloc] init];
    
    if (copy) {

        copy.result = self.result;
        copy.data = [self.data copyWithZone:zone];
    }
    
    return copy;
}


@end
