//
//  CYMJUserListAtListBase.m
//
//  Created by 超逸 李 on 15/2/10
//  Copyright (c) 2015 Duostec. All rights reserved.
//

#import "CYMJUserListAtListBase.h"
#import "CYMJUserListAtListData.h"


NSString *const kCYMJUserListAtListBaseResult = @"result";
NSString *const kCYMJUserListAtListBaseData = @"data";


@interface CYMJUserListAtListBase ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation CYMJUserListAtListBase

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
            self.result = [[self objectOrNilForKey:kCYMJUserListAtListBaseResult fromDictionary:dict] doubleValue];
    NSObject *receivedCYMJUserListAtListData = [dict objectForKey:kCYMJUserListAtListBaseData];
    NSMutableArray *parsedCYMJUserListAtListData = [NSMutableArray array];
    if ([receivedCYMJUserListAtListData isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedCYMJUserListAtListData) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedCYMJUserListAtListData addObject:[CYMJUserListAtListData modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedCYMJUserListAtListData isKindOfClass:[NSDictionary class]]) {
       [parsedCYMJUserListAtListData addObject:[CYMJUserListAtListData modelObjectWithDictionary:(NSDictionary *)receivedCYMJUserListAtListData]];
    }

    self.data = [NSArray arrayWithArray:parsedCYMJUserListAtListData];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.result] forKey:kCYMJUserListAtListBaseResult];
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
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForData] forKey:kCYMJUserListAtListBaseData];

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

    self.result = [aDecoder decodeDoubleForKey:kCYMJUserListAtListBaseResult];
    self.data = [aDecoder decodeObjectForKey:kCYMJUserListAtListBaseData];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_result forKey:kCYMJUserListAtListBaseResult];
    [aCoder encodeObject:_data forKey:kCYMJUserListAtListBaseData];
}

- (id)copyWithZone:(NSZone *)zone
{
    CYMJUserListAtListBase *copy = [[CYMJUserListAtListBase alloc] init];
    
    if (copy) {

        copy.result = self.result;
        copy.data = [self.data copyWithZone:zone];
    }
    
    return copy;
}


@end
