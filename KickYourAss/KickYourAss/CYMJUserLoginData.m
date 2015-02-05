//
//  CYMJUserLoginData.m
//
//  Created by 超逸 李 on 15/2/5
//  Copyright (c) 2015 Duostec. All rights reserved.
//

#import "CYMJUserLoginData.h"


NSString *const kCYMJUserLoginDataUserId = @"user_id";
NSString *const kCYMJUserLoginDataNickName = @"nick_name";
NSString *const kCYMJUserLoginDataRole = @"role";


@interface CYMJUserLoginData ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation CYMJUserLoginData

@synthesize userId = _userId;
@synthesize nickName = _nickName;
@synthesize role = _role;


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
            self.userId = [self objectOrNilForKey:kCYMJUserLoginDataUserId fromDictionary:dict];
            self.nickName = [self objectOrNilForKey:kCYMJUserLoginDataNickName fromDictionary:dict];
            self.role = [self objectOrNilForKey:kCYMJUserLoginDataRole fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.userId forKey:kCYMJUserLoginDataUserId];
    [mutableDict setValue:self.nickName forKey:kCYMJUserLoginDataNickName];
    [mutableDict setValue:self.role forKey:kCYMJUserLoginDataRole];

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

    self.userId = [aDecoder decodeObjectForKey:kCYMJUserLoginDataUserId];
    self.nickName = [aDecoder decodeObjectForKey:kCYMJUserLoginDataNickName];
    self.role = [aDecoder decodeObjectForKey:kCYMJUserLoginDataRole];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_userId forKey:kCYMJUserLoginDataUserId];
    [aCoder encodeObject:_nickName forKey:kCYMJUserLoginDataNickName];
    [aCoder encodeObject:_role forKey:kCYMJUserLoginDataRole];
}

- (id)copyWithZone:(NSZone *)zone
{
    CYMJUserLoginData *copy = [[CYMJUserLoginData alloc] init];
    
    if (copy) {

        copy.userId = [self.userId copyWithZone:zone];
        copy.nickName = [self.nickName copyWithZone:zone];
        copy.role = [self.role copyWithZone:zone];
    }
    
    return copy;
}


@end
