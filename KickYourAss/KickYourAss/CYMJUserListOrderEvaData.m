//
//  CYMJUserListOrderEvaData.m
//
//  Created by 超逸 李 on 15/2/11
//  Copyright (c) 2015 Duostec. All rights reserved.
//

#import "CYMJUserListOrderEvaData.h"


NSString *const kCYMJUserListOrderEvaDataHeadImage = @"head_image";
NSString *const kCYMJUserListOrderEvaDataCutPath = @"cut_path";
NSString *const kCYMJUserListOrderEvaDataWidth = @"width";
NSString *const kCYMJUserListOrderEvaDataNickName = @"nick_name";
NSString *const kCYMJUserListOrderEvaDataUserId = @"user_id";
NSString *const kCYMJUserListOrderEvaDataComment = @"comment";
NSString *const kCYMJUserListOrderEvaDataCutHeight = @"cut_height";
NSString *const kCYMJUserListOrderEvaDataCutWidth = @"cut_width";
NSString *const kCYMJUserListOrderEvaDataCtime = @"ctime";
NSString *const kCYMJUserListOrderEvaDataImageId = @"image_id";
NSString *const kCYMJUserListOrderEvaDataCommentId = @"comment_id";
NSString *const kCYMJUserListOrderEvaDataHeight = @"height";
NSString *const kCYMJUserListOrderEvaDataImagePath = @"image_path";
NSString *const kCYMJUserListOrderEvaDataScore = @"score";
NSString *const kCYMJUserListOrderEvaDataAddTime = @"add_time";


@interface CYMJUserListOrderEvaData ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation CYMJUserListOrderEvaData

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
            self.headImage = [self objectOrNilForKey:kCYMJUserListOrderEvaDataHeadImage fromDictionary:dict];
            self.cutPath = [self objectOrNilForKey:kCYMJUserListOrderEvaDataCutPath fromDictionary:dict];
            self.width = [self objectOrNilForKey:kCYMJUserListOrderEvaDataWidth fromDictionary:dict];
            self.nickName = [self objectOrNilForKey:kCYMJUserListOrderEvaDataNickName fromDictionary:dict];
            self.userId = [self objectOrNilForKey:kCYMJUserListOrderEvaDataUserId fromDictionary:dict];
            self.comment = [self objectOrNilForKey:kCYMJUserListOrderEvaDataComment fromDictionary:dict];
            self.cutHeight = [self objectOrNilForKey:kCYMJUserListOrderEvaDataCutHeight fromDictionary:dict];
            self.cutWidth = [self objectOrNilForKey:kCYMJUserListOrderEvaDataCutWidth fromDictionary:dict];
            self.ctime = [self objectOrNilForKey:kCYMJUserListOrderEvaDataCtime fromDictionary:dict];
            self.imageId = [self objectOrNilForKey:kCYMJUserListOrderEvaDataImageId fromDictionary:dict];
            self.commentId = [self objectOrNilForKey:kCYMJUserListOrderEvaDataCommentId fromDictionary:dict];
            self.height = [self objectOrNilForKey:kCYMJUserListOrderEvaDataHeight fromDictionary:dict];
            self.imagePath = [self objectOrNilForKey:kCYMJUserListOrderEvaDataImagePath fromDictionary:dict];
            self.score = [self objectOrNilForKey:kCYMJUserListOrderEvaDataScore fromDictionary:dict];
            self.addTime = [self objectOrNilForKey:kCYMJUserListOrderEvaDataAddTime fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.headImage forKey:kCYMJUserListOrderEvaDataHeadImage];
    [mutableDict setValue:self.cutPath forKey:kCYMJUserListOrderEvaDataCutPath];
    [mutableDict setValue:self.width forKey:kCYMJUserListOrderEvaDataWidth];
    [mutableDict setValue:self.nickName forKey:kCYMJUserListOrderEvaDataNickName];
    [mutableDict setValue:self.userId forKey:kCYMJUserListOrderEvaDataUserId];
    [mutableDict setValue:self.comment forKey:kCYMJUserListOrderEvaDataComment];
    [mutableDict setValue:self.cutHeight forKey:kCYMJUserListOrderEvaDataCutHeight];
    [mutableDict setValue:self.cutWidth forKey:kCYMJUserListOrderEvaDataCutWidth];
    [mutableDict setValue:self.ctime forKey:kCYMJUserListOrderEvaDataCtime];
    [mutableDict setValue:self.imageId forKey:kCYMJUserListOrderEvaDataImageId];
    [mutableDict setValue:self.commentId forKey:kCYMJUserListOrderEvaDataCommentId];
    [mutableDict setValue:self.height forKey:kCYMJUserListOrderEvaDataHeight];
    [mutableDict setValue:self.imagePath forKey:kCYMJUserListOrderEvaDataImagePath];
    [mutableDict setValue:self.score forKey:kCYMJUserListOrderEvaDataScore];
    [mutableDict setValue:self.addTime forKey:kCYMJUserListOrderEvaDataAddTime];

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

    self.headImage = [aDecoder decodeObjectForKey:kCYMJUserListOrderEvaDataHeadImage];
    self.cutPath = [aDecoder decodeObjectForKey:kCYMJUserListOrderEvaDataCutPath];
    self.width = [aDecoder decodeObjectForKey:kCYMJUserListOrderEvaDataWidth];
    self.nickName = [aDecoder decodeObjectForKey:kCYMJUserListOrderEvaDataNickName];
    self.userId = [aDecoder decodeObjectForKey:kCYMJUserListOrderEvaDataUserId];
    self.comment = [aDecoder decodeObjectForKey:kCYMJUserListOrderEvaDataComment];
    self.cutHeight = [aDecoder decodeObjectForKey:kCYMJUserListOrderEvaDataCutHeight];
    self.cutWidth = [aDecoder decodeObjectForKey:kCYMJUserListOrderEvaDataCutWidth];
    self.ctime = [aDecoder decodeObjectForKey:kCYMJUserListOrderEvaDataCtime];
    self.imageId = [aDecoder decodeObjectForKey:kCYMJUserListOrderEvaDataImageId];
    self.commentId = [aDecoder decodeObjectForKey:kCYMJUserListOrderEvaDataCommentId];
    self.height = [aDecoder decodeObjectForKey:kCYMJUserListOrderEvaDataHeight];
    self.imagePath = [aDecoder decodeObjectForKey:kCYMJUserListOrderEvaDataImagePath];
    self.score = [aDecoder decodeObjectForKey:kCYMJUserListOrderEvaDataScore];
    self.addTime = [aDecoder decodeObjectForKey:kCYMJUserListOrderEvaDataAddTime];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_headImage forKey:kCYMJUserListOrderEvaDataHeadImage];
    [aCoder encodeObject:_cutPath forKey:kCYMJUserListOrderEvaDataCutPath];
    [aCoder encodeObject:_width forKey:kCYMJUserListOrderEvaDataWidth];
    [aCoder encodeObject:_nickName forKey:kCYMJUserListOrderEvaDataNickName];
    [aCoder encodeObject:_userId forKey:kCYMJUserListOrderEvaDataUserId];
    [aCoder encodeObject:_comment forKey:kCYMJUserListOrderEvaDataComment];
    [aCoder encodeObject:_cutHeight forKey:kCYMJUserListOrderEvaDataCutHeight];
    [aCoder encodeObject:_cutWidth forKey:kCYMJUserListOrderEvaDataCutWidth];
    [aCoder encodeObject:_ctime forKey:kCYMJUserListOrderEvaDataCtime];
    [aCoder encodeObject:_imageId forKey:kCYMJUserListOrderEvaDataImageId];
    [aCoder encodeObject:_commentId forKey:kCYMJUserListOrderEvaDataCommentId];
    [aCoder encodeObject:_height forKey:kCYMJUserListOrderEvaDataHeight];
    [aCoder encodeObject:_imagePath forKey:kCYMJUserListOrderEvaDataImagePath];
    [aCoder encodeObject:_score forKey:kCYMJUserListOrderEvaDataScore];
    [aCoder encodeObject:_addTime forKey:kCYMJUserListOrderEvaDataAddTime];
}

- (id)copyWithZone:(NSZone *)zone
{
    CYMJUserListOrderEvaData *copy = [[CYMJUserListOrderEvaData alloc] init];
    
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
