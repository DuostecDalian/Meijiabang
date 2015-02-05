//
//  CYMJUserLoginBase.m
//
//  Created by 超逸 李 on 15/2/5
//  Copyright (c) 2015 Duostec. All rights reserved.
//

#import "CYMJUserLoginBase.h"
#import "CYMJUserLoginData.h"


NSString *const kCYMJUserLoginBaseResult = @"result";
NSString *const kCYMJUserLoginBaseData = @"data";


@interface CYMJUserLoginBase ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation CYMJUserLoginBase

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
            self.result = [[self objectOrNilForKey:kCYMJUserLoginBaseResult fromDictionary:dict] doubleValue];
            self.data = [CYMJUserLoginData modelObjectWithDictionary:[dict objectForKey:kCYMJUserLoginBaseData]];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.result] forKey:kCYMJUserLoginBaseResult];
    [mutableDict setValue:[self.data dictionaryRepresentation] forKey:kCYMJUserLoginBaseData];

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

    self.result = [aDecoder decodeDoubleForKey:kCYMJUserLoginBaseResult];
    self.data = [aDecoder decodeObjectForKey:kCYMJUserLoginBaseData];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_result forKey:kCYMJUserLoginBaseResult];
    [aCoder encodeObject:_data forKey:kCYMJUserLoginBaseData];
}

- (id)copyWithZone:(NSZone *)zone
{
    CYMJUserLoginBase *copy = [[CYMJUserLoginBase alloc] init];
    
    if (copy) {

        copy.result = self.result;
        copy.data = [self.data copyWithZone:zone];
    }
    
    return copy;
}


@end
