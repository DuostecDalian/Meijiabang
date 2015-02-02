//
//  ZXY_ArtDetailInfoBase.m
//
//  Created by   on 15/1/30
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "ZXY_ArtDetailInfoBase.h"
#import "ZXY_ArtDetailInfoData.h"


NSString *const kZXY_ArtDetailInfoBaseResult = @"result";
NSString *const kZXY_ArtDetailInfoBaseData = @"data";


@interface ZXY_ArtDetailInfoBase ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ZXY_ArtDetailInfoBase

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
            self.result = [[self objectOrNilForKey:kZXY_ArtDetailInfoBaseResult fromDictionary:dict] doubleValue];
            self.data = [ZXY_ArtDetailInfoData modelObjectWithDictionary:[dict objectForKey:kZXY_ArtDetailInfoBaseData]];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.result] forKey:kZXY_ArtDetailInfoBaseResult];
    [mutableDict setValue:[self.data dictionaryRepresentation] forKey:kZXY_ArtDetailInfoBaseData];

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

    self.result = [aDecoder decodeDoubleForKey:kZXY_ArtDetailInfoBaseResult];
    self.data = [aDecoder decodeObjectForKey:kZXY_ArtDetailInfoBaseData];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_result forKey:kZXY_ArtDetailInfoBaseResult];
    [aCoder encodeObject:_data forKey:kZXY_ArtDetailInfoBaseData];
}

- (id)copyWithZone:(NSZone *)zone
{
    ZXY_ArtDetailInfoBase *copy = [[ZXY_ArtDetailInfoBase alloc] init];
    
    if (copy) {

        copy.result = self.result;
        copy.data = [self.data copyWithZone:zone];
    }
    
    return copy;
}


@end
