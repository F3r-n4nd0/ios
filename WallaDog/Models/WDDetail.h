//
//  WDDetail.h
//  WallaDog
//
//  Created by Pepe Padilla on 15/08/12.
//  Copyright © 2015 Dancing Queen. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface WDDetail : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double latitude;
@property (nonatomic, strong) NSString *facebookToken;
@property (nonatomic, assign) double longitude;
@property (nonatomic, strong) NSString *avatarUrl;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
