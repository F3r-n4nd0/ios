//
//  DQProduct.h
//  WallaDog
//
//  Created by Pepe Padilla on 15/08/12.
//  Copyright © 2015 Dancing Queen. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface DQProduct : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *gender;
@property (nonatomic, assign) double stateId;
@property (nonatomic, assign) double raceId;
@property (nonatomic, assign) double internalBaseClassIdentifier;
@property (nonatomic, assign) double price;
@property (nonatomic, assign) double sellerId;
@property (nonatomic, assign) BOOL sterile;
@property (nonatomic, strong) NSString *publishDate;
@property (nonatomic, assign) double categoryId;
@property (nonatomic, strong) NSString *internalBaseClassDescription;
@property (nonatomic, strong) NSString *name;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
