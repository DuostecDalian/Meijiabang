//
//  CYMJUserInfoBase.m
//
//  Created by 超逸 李 on 15/2/6
//  Copyright (c) 2015 Duostec. All rights reserved.
//

#import "CYMJUserInfoBase.h"
#import "CYMJUserInfoData.h"


NSString *const kCYMJUserInfoBaseResult = @"result";
NSString *const kCYMJUserInfoBaseData = @"data";


@interface CYMJUserInfoBase ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation CYMJUserInfoBase

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
            self.result = [[self objectOrNilForKey:kCYMJUserInfoBaseResult fromDictionary:dict] doubleValue];
            self.data = [CYMJUserInfoData modelObjectWithDictionary:[dict objectForKey:kCYMJUserInfoBaseData]];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.result] forKey:kCYMJUserInfoBaseResult];
    [mutableDict setValue:[self.data dictionaryRepresentation] forKey:kCYMJUserInfoBaseData];

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

    self.result = [aDecoder decodeDoubleForKey:kCYMJUserInfoBaseResult];
    self.data = [aDecoder decodeObjectForKey:kCYMJUserInfoBaseData];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_result forKey:kCYMJUserInfoBaseResult];
    [aCoder encodeObject:_data forKey:kCYMJUserInfoBaseData];
}

- (id)copyWithZone:(NSZone *)zone
{
    CYMJUserInfoBase *copy = [[CYMJUserInfoBase alloc] init];
    
    if (copy) {

        copy.result = self.result;
        copy.data = [self.data copyWithZone:zone];
    }
    
    return copy;
}


@end
