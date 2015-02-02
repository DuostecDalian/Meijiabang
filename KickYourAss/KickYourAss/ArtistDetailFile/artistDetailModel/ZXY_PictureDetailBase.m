//
//  ZXY_PictureDetailBase.m
//
//  Created by   on 15/2/2
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "ZXY_PictureDetailBase.h"
#import "ZXY_PictureDetailData.h"


NSString *const kZXY_PictureDetailBaseResult = @"result";
NSString *const kZXY_PictureDetailBaseData = @"data";


@interface ZXY_PictureDetailBase ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ZXY_PictureDetailBase

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
            self.result = [[self objectOrNilForKey:kZXY_PictureDetailBaseResult fromDictionary:dict] doubleValue];
            self.data = [ZXY_PictureDetailData modelObjectWithDictionary:[dict objectForKey:kZXY_PictureDetailBaseData]];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.result] forKey:kZXY_PictureDetailBaseResult];
    [mutableDict setValue:[self.data dictionaryRepresentation] forKey:kZXY_PictureDetailBaseData];

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

    self.result = [aDecoder decodeDoubleForKey:kZXY_PictureDetailBaseResult];
    self.data = [aDecoder decodeObjectForKey:kZXY_PictureDetailBaseData];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_result forKey:kZXY_PictureDetailBaseResult];
    [aCoder encodeObject:_data forKey:kZXY_PictureDetailBaseData];
}

- (id)copyWithZone:(NSZone *)zone
{
    ZXY_PictureDetailBase *copy = [[ZXY_PictureDetailBase alloc] init];
    
    if (copy) {

        copy.result = self.result;
        copy.data = [self.data copyWithZone:zone];
    }
    
    return copy;
}


@end
