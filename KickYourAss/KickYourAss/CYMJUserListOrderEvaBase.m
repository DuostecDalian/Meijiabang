//
//  CYMJUserListOrderEvaBase.m
//
//  Created by 超逸 李 on 15/2/11
//  Copyright (c) 2015 Duostec. All rights reserved.
//

#import "CYMJUserListOrderEvaBase.h"
#import "CYMJUserListOrderEvaData.h"


NSString *const kCYMJUserListOrderEvaBaseResult = @"result";
NSString *const kCYMJUserListOrderEvaBaseData = @"data";


@interface CYMJUserListOrderEvaBase ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation CYMJUserListOrderEvaBase

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
            self.result = [[self objectOrNilForKey:kCYMJUserListOrderEvaBaseResult fromDictionary:dict] doubleValue];
    NSObject *receivedCYMJUserListOrderEvaData = [dict objectForKey:kCYMJUserListOrderEvaBaseData];
    NSMutableArray *parsedCYMJUserListOrderEvaData = [NSMutableArray array];
    if ([receivedCYMJUserListOrderEvaData isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedCYMJUserListOrderEvaData) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedCYMJUserListOrderEvaData addObject:[CYMJUserListOrderEvaData modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedCYMJUserListOrderEvaData isKindOfClass:[NSDictionary class]]) {
       [parsedCYMJUserListOrderEvaData addObject:[CYMJUserListOrderEvaData modelObjectWithDictionary:(NSDictionary *)receivedCYMJUserListOrderEvaData]];
    }

    self.data = [NSArray arrayWithArray:parsedCYMJUserListOrderEvaData];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.result] forKey:kCYMJUserListOrderEvaBaseResult];
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
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForData] forKey:kCYMJUserListOrderEvaBaseData];

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

    self.result = [aDecoder decodeDoubleForKey:kCYMJUserListOrderEvaBaseResult];
    self.data = [aDecoder decodeObjectForKey:kCYMJUserListOrderEvaBaseData];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_result forKey:kCYMJUserListOrderEvaBaseResult];
    [aCoder encodeObject:_data forKey:kCYMJUserListOrderEvaBaseData];
}

- (id)copyWithZone:(NSZone *)zone
{
    CYMJUserListOrderEvaBase *copy = [[CYMJUserListOrderEvaBase alloc] init];
    
    if (copy) {

        copy.result = self.result;
        copy.data = [self.data copyWithZone:zone];
    }
    
    return copy;
}


@end
