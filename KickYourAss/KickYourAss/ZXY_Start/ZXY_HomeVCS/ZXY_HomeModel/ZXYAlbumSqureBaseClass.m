//
//  ZXYAlbumSqureBaseClass.m
//
//  Created by   on 15/1/28
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "ZXYAlbumSqureBaseClass.h"
#import "ZXYAlbumSqureData.h"


NSString *const kZXYAlbumSqureBaseClassResult = @"result";
NSString *const kZXYAlbumSqureBaseClassData = @"data";


@interface ZXYAlbumSqureBaseClass ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ZXYAlbumSqureBaseClass

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
            self.result = [[self objectOrNilForKey:kZXYAlbumSqureBaseClassResult fromDictionary:dict] doubleValue];
            self.data = [ZXYAlbumSqureData modelObjectWithDictionary:[dict objectForKey:kZXYAlbumSqureBaseClassData]];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.result] forKey:kZXYAlbumSqureBaseClassResult];
    [mutableDict setValue:[self.data dictionaryRepresentation] forKey:kZXYAlbumSqureBaseClassData];

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

    self.result = [aDecoder decodeDoubleForKey:kZXYAlbumSqureBaseClassResult];
    self.data = [aDecoder decodeObjectForKey:kZXYAlbumSqureBaseClassData];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_result forKey:kZXYAlbumSqureBaseClassResult];
    [aCoder encodeObject:_data forKey:kZXYAlbumSqureBaseClassData];
}

- (id)copyWithZone:(NSZone *)zone
{
    ZXYAlbumSqureBaseClass *copy = [[ZXYAlbumSqureBaseClass alloc] init];
    
    if (copy) {

        copy.result = self.result;
        copy.data = [self.data copyWithZone:zone];
    }
    
    return copy;
}


@end
