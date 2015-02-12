//
//  CYMJUserListOrderEvaData.h
//
//  Created by 超逸 李 on 15/2/11
//  Copyright (c) 2015 Duostec. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface CYMJUserListOrderEvaData : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *headImage;
@property (nonatomic, strong) NSString *cutPath;
@property (nonatomic, strong) NSString *width;
@property (nonatomic, strong) NSString *nickName;
@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *comment;
@property (nonatomic, strong) NSString *cutHeight;
@property (nonatomic, strong) NSString *cutWidth;
@property (nonatomic, strong) NSString *ctime;
@property (nonatomic, strong) NSString *imageId;
@property (nonatomic, strong) NSString *commentId;
@property (nonatomic, strong) NSString *height;
@property (nonatomic, strong) NSString *imagePath;
@property (nonatomic, strong) NSString *score;
@property (nonatomic, strong) NSString *addTime;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
