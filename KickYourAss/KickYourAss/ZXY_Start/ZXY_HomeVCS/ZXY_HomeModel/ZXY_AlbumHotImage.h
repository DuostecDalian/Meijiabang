//
//  ZXY_AlbumHotImage.h
//
//  Created by   on 15/1/27
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ZXY_AlbumHotImage : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *cutWidth;
@property (nonatomic, strong) NSString *cutPath;
@property (nonatomic, strong) NSString *cutHeight;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
