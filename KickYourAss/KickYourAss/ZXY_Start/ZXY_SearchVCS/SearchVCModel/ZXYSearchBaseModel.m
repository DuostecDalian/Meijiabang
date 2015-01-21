//
//  ZXYSearchBaseModel.m
//
//  Created by   on 15/1/21
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "ZXYSearchBaseModel.h"
#import "ZXYData.h"


NSString *const kZXYSearchBaseModelResult = @"result";
NSString *const kZXYSearchBaseModelData = @"data";


@interface ZXYSearchBaseModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ZXYSearchBaseModel

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
            self.result = [[self objectOrNilForKey:kZXYSearchBaseModelResult fromDictionary:dict] doubleValue];
    NSObject *receivedZXYData = [dict objectForKey:kZXYSearchBaseModelData];
    NSMutableArray *parsedZXYData = [NSMutableArray array];
    if ([receivedZXYData isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedZXYData) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedZXYData addObject:[ZXYData modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedZXYData isKindOfClass:[NSDictionary class]]) {
       [parsedZXYData addObject:[ZXYData modelObjectWithDictionary:(NSDictionary *)receivedZXYData]];
    }

    self.data = [NSArray arrayWithArray:parsedZXYData];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.result] forKey:kZXYSearchBaseModelResult];
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
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForData] forKey:kZXYSearchBaseModelData];

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

    self.result = [aDecoder decodeDoubleForKey:kZXYSearchBaseModelResult];
    self.data = [aDecoder decodeObjectForKey:kZXYSearchBaseModelData];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_result forKey:kZXYSearchBaseModelResult];
    [aCoder encodeObject:_data forKey:kZXYSearchBaseModelData];
}

- (id)copyWithZone:(NSZone *)zone
{
    ZXYSearchBaseModel *copy = [[ZXYSearchBaseModel alloc] init];
    
    if (copy) {

        copy.result = self.result;
        copy.data = [self.data copyWithZone:zone];
    }
    
    return copy;
}


@end
