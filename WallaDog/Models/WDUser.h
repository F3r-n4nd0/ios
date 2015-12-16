//
//  WDUser.h
//  WallaDog
//
//  Created by Pepe Padilla on 15/08/12.
//  Copyright © 2015 Dancing Queen. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WDDetail;

@interface WDUser : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) WDDetail *detail;
@property (nonatomic, strong) NSString *password;
@property (nonatomic, assign) double internalBaseClassIdentifier;
@property (nonatomic, strong) NSString *lastname;
@property (nonatomic, strong) NSString *company;
@property (nonatomic, strong) NSString *firstname;
@property (nonatomic, strong) NSString *email;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
