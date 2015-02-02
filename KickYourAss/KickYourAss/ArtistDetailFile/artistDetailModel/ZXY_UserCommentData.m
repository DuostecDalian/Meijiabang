//
//  ZXY_UserCommentData.m
//
//  Created by   on 15/1/30
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "ZXY_UserCommentData.h"


NSString *const kZXY_UserCommentDataHeadImage = @"head_image";
NSString *const kZXY_UserCommentDataCutPath = @"cut_path";
NSString *const kZXY_UserCommentDataWidth = @"width";
NSString *const kZXY_UserCommentDataNickName = @"nick_name";
NSString *const kZXY_UserCommentDataUserId = @"user_id";
NSString *const kZXY_UserCommentDataComment = @"comment";
NSString *const kZXY_UserCommentDataCutHeight = @"cut_height";
NSString *const kZXY_UserCommentDataCutWidth = @"cut_width";
NSString *const kZXY_UserCommentDataCtime = @"ctime";
NSString *const kZXY_UserCommentDataImageId = @"image_id";
NSString *const kZXY_UserCommentDataCommentId = @"comment_id";
NSString *const kZXY_UserCommentDataHeight = @"height";
NSString *const kZXY_UserCommentDataImagePath = @"image_path";
NSString *const kZXY_UserCommentDataScore = @"score";
NSString *const kZXY_UserCommentDataAddTime = @"add_time";


@interface ZXY_UserCommentData ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ZXY_UserCommentData

@synthesize headImage = _headImage;
@synthesize cutPath = _cutPath;
@synthesize width = _width;
@synthesize nickName = _nickName;
@synthesize userId = _userId;
@synthesize comment = _comment;
@synthesize cutHeight = _cutHeight;
@synthesize cutWidth = _cutWidth;
@synthesize ctime = _ctime;
@synthesize imageId = _imageId;
@synthesize commentId = _commentId;
@synthesize height = _height;
@synthesize imagePath = _imagePath;
@synthesize score = _score;
@synthesize addTime = _addTime;


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
            self.headImage = [self objectOrNilForKey:kZXY_UserCommentDataHeadImage fromDictionary:dict];
            self.cutPath = [self objectOrNilForKey:kZXY_UserCommentDataCutPath fromDictionary:dict];
            self.width = [self objectOrNilForKey:kZXY_UserCommentDataWidth fromDictionary:dict];
            self.nickName = [self objectOrNilForKey:kZXY_UserCommentDataNickName fromDictionary:dict];
            self.userId = [self objectOrNilForKey:kZXY_UserCommentDataUserId fromDictionary:dict];
            self.comment = [self objectOrNilForKey:kZXY_UserCommentDataComment fromDictionary:dict];
            self.cutHeight = [self objectOrNilForKey:kZXY_UserCommentDataCutHeight fromDictionary:dict];
            self.cutWidth = [self objectOrNilForKey:kZXY_UserCommentDataCutWidth fromDictionary:dict];
            self.ctime = [self objectOrNilForKey:kZXY_UserCommentDataCtime fromDictionary:dict];
            self.imageId = [self objectOrNilForKey:kZXY_UserCommentDataImageId fromDictionary:dict];
            self.commentId = [self objectOrNilForKey:kZXY_UserCommentDataCommentId fromDictionary:dict];
            self.height = [self objectOrNilForKey:kZXY_UserCommentDataHeight fromDictionary:dict];
            self.imagePath = [self objectOrNilForKey:kZXY_UserCommentDataImagePath fromDictionary:dict];
            self.score = [self objectOrNilForKey:kZXY_UserCommentDataScore fromDictionary:dict];
            self.addTime = [self objectOrNilForKey:kZXY_UserCommentDataAddTime fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.headImage forKey:kZXY_UserCommentDataHeadImage];
    [mutableDict setValue:self.cutPath forKey:kZXY_UserCommentDataCutPath];
    [mutableDict setValue:self.width forKey:kZXY_UserCommentDataWidth];
    [mutableDict setValue:self.nickName forKey:kZXY_UserCommentDataNickName];
    [mutableDict setValue:self.userId forKey:kZXY_UserCommentDataUserId];
    [mutableDict setValue:self.comment forKey:kZXY_UserCommentDataComment];
    [mutableDict setValue:self.cutHeight forKey:kZXY_UserCommentDataCutHeight];
    [mutableDict setValue:self.cutWidth forKey:kZXY_UserCommentDataCutWidth];
    [mutableDict setValue:self.ctime forKey:kZXY_UserCommentDataCtime];
    [mutableDict setValue:self.imageId forKey:kZXY_UserCommentDataImageId];
    [mutableDict setValue:self.commentId forKey:kZXY_UserCommentDataCommentId];
    [mutableDict setValue:self.height forKey:kZXY_UserCommentDataHeight];
    [mutableDict setValue:self.imagePath forKey:kZXY_UserCommentDataImagePath];
    [mutableDict setValue:self.score forKey:kZXY_UserCommentDataScore];
    [mutableDict setValue:self.addTime forKey:kZXY_UserCommentDataAddTime];

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

    self.headImage = [aDecoder decodeObjectForKey:kZXY_UserCommentDataHeadImage];
    self.cutPath = [aDecoder decodeObjectForKey:kZXY_UserCommentDataCutPath];
    self.width = [aDecoder decodeObjectForKey:kZXY_UserCommentDataWidth];
    self.nickName = [aDecoder decodeObjectForKey:kZXY_UserCommentDataNickName];
    self.userId = [aDecoder decodeObjectForKey:kZXY_UserCommentDataUserId];
    self.comment = [aDecoder decodeObjectForKey:kZXY_UserCommentDataComment];
    self.cutHeight = [aDecoder decodeObjectForKey:kZXY_UserCommentDataCutHeight];
    self.cutWidth = [aDecoder decodeObjectForKey:kZXY_UserCommentDataCutWidth];
    self.ctime = [aDecoder decodeObjectForKey:kZXY_UserCommentDataCtime];
    self.imageId = [aDecoder decodeObjectForKey:kZXY_UserCommentDataImageId];
    self.commentId = [aDecoder decodeObjectForKey:kZXY_UserCommentDataCommentId];
    self.height = [aDecoder decodeObjectForKey:kZXY_UserCommentDataHeight];
    self.imagePath = [aDecoder decodeObjectForKey:kZXY_UserCommentDataImagePath];
    self.score = [aDecoder decodeObjectForKey:kZXY_UserCommentDataScore];
    self.addTime = [aDecoder decodeObjectForKey:kZXY_UserCommentDataAddTime];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_headImage forKey:kZXY_UserCommentDataHeadImage];
    [aCoder encodeObject:_cutPath forKey:kZXY_UserCommentDataCutPath];
    [aCoder encodeObject:_width forKey:kZXY_UserCommentDataWidth];
    [aCoder encodeObject:_nickName forKey:kZXY_UserCommentDataNickName];
    [aCoder encodeObject:_userId forKey:kZXY_UserCommentDataUserId];
    [aCoder encodeObject:_comment forKey:kZXY_UserCommentDataComment];
    [aCoder encodeObject:_cutHeight forKey:kZXY_UserCommentDataCutHeight];
    [aCoder encodeObject:_cutWidth forKey:kZXY_UserCommentDataCutWidth];
    [aCoder encodeObject:_ctime forKey:kZXY_UserCommentDataCtime];
    [aCoder encodeObject:_imageId forKey:kZXY_UserCommentDataImageId];
    [aCoder encodeObject:_commentId forKey:kZXY_UserCommentDataCommentId];
    [aCoder encodeObject:_height forKey:kZXY_UserCommentDataHeight];
    [aCoder encodeObject:_imagePath forKey:kZXY_UserCommentDataImagePath];
    [aCoder encodeObject:_score forKey:kZXY_UserCommentDataScore];
    [aCoder encodeObject:_addTime forKey:kZXY_UserCommentDataAddTime];
}

- (id)copyWithZone:(NSZone *)zone
{
    ZXY_UserCommentData *copy = [[ZXY_UserCommentData alloc] init];
    
    if (copy) {

        copy.headImage = [self.headImage copyWithZone:zone];
        copy.cutPath = [self.cutPath copyWithZone:zone];
        copy.width = [self.width copyWithZone:zone];
        copy.nickName = [self.nickName copyWithZone:zone];
        copy.userId = [self.userId copyWithZone:zone];
        copy.comment = [self.comment copyWithZone:zone];
        copy.cutHeight = [self.cutHeight copyWithZone:zone];
        copy.cutWidth = [self.cutWidth copyWithZone:zone];
        copy.ctime = [self.ctime copyWithZone:zone];
        copy.imageId = [self.imageId copyWithZone:zone];
        copy.commentId = [self.commentId copyWithZone:zone];
        copy.height = [self.height copyWithZone:zone];
        copy.imagePath = [self.imagePath copyWithZone:zone];
        copy.score = [self.score copyWithZone:zone];
        copy.addTime = [self.addTime copyWithZone:zone];
    }
    
    return copy;
}


@end
