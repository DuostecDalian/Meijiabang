//
//  CYMJAlbumMyCollectionData.h
//
//  Created by 超逸 李 on 15/2/12
//  Copyright (c) 2015 Duostec. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface CYMJAlbumMyCollectionData : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *nickName;
@property (nonatomic, strong) NSString *albumId;
@property (nonatomic, strong) NSString *headImage;
@property (nonatomic, strong) NSString *cutHeight;
@property (nonatomic, strong) NSString *cutPath;
@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *dataDescription;
@property (nonatomic, strong) NSString *cutWidth;
@property (nonatomic, strong) NSString *agreeCount;
@property (nonatomic, strong) NSString *addTime;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
