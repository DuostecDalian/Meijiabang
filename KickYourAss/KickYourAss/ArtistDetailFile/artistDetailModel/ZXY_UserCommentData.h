//
//  ZXY_UserCommentData.h
//
//  Created by   on 15/1/30
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ZXY_UserCommentData : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *headImage;
@property (nonatomic, assign) id cutPath;
@property (nonatomic, assign) id width;
@property (nonatomic, strong) NSString *nickName;
@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *comment;
@property (nonatomic, assign) id cutHeight;
@property (nonatomic, assign) id cutWidth;
@property (nonatomic, strong) NSString *ctime;
@property (nonatomic, assign) id imageId;
@property (nonatomic, assign) id commentId;
@property (nonatomic, assign) id height;
@property (nonatomic, assign) id imagePath;
@property (nonatomic, strong) NSString *score;
@property (nonatomic, assign) id addTime;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
