//
//  CYMJOrderListBase.m
//
//  Created by 超逸 李 on 15/2/11
//  Copyright (c) 2015 Duostec. All rights reserved.
//

#import "CYMJOrderListBase.h"
#import "CYMJOrderListData.h"


NSString *const kCYMJOrderListBaseResult = @"result";
NSString *const kCYMJOrderListBaseData = @"data";


@interface CYMJOrderListBase ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation CYMJOrderListBase

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
            self.result = [[self objectOrNilForKey:kCYMJOrderListBaseResult fromDictionary:dict] doubleValue];
    NSObject *receivedCYMJOrderListData = [dict objectForKey:kCYMJOrderListBaseData];
    NSMutableArray *parsedCYMJOrderListData = [NSMutableArray array];
    if ([receivedCYMJOrderListData isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedCYMJOrderListData) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedCYMJOrderListData addObject:[CYMJOrderListData modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedCYMJOrderListData isKindOfClass:[NSDictionary class]]) {
       [parsedCYMJOrderListData addObject:[CYMJOrderListData modelObjectWithDictionary:(NSDictionary *)receivedCYMJOrderListData]];
    }

    self.data = [NSArray arrayWithArray:parsedCYMJOrderListData];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.result] forKey:kCYMJOrderListBaseResult];
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
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForData] forKey:kCYMJOrderListBaseData];

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

    self.result = [aDecoder decodeDoubleForKey:kCYMJOrderListBaseResult];
    self.data = [aDecoder decodeObjectForKey:kCYMJOrderListBaseData];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_result forKey:kCYMJOrderListBaseResult];
    [aCoder encodeObject:_data forKey:kCYMJOrderListBaseData];
}

- (id)copyWithZone:(NSZone *)zone
{
    CYMJOrderListBase *copy = [[CYMJOrderListBase alloc] init];
    
    if (copy) {

        copy.result = self.result;
        copy.data = [self.data copyWithZone:zone];
    }
    
    return copy;
}


@end
