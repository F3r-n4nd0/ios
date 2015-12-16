//
//  WDSaveSearch.h
//  WallaDog
//
//  Created by Pepe Padilla on 15/08/12.
//  Copyright © 2015 Dancing Queen. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface WDSavedSearch : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double raceId;
@property (nonatomic, assign) double userId;
@property (nonatomic, assign) double longitude;
@property (nonatomic, assign) double internalBaseClassIdentifier;
@property (nonatomic, strong) NSString *keywords;
@property (nonatomic, assign) double categoryId;
@property (nonatomic, assign) double latitude;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
