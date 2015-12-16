//
//  WDTransaction.h
//  WallaDog
//
//  Created by Pepe Padilla on 15/08/12.
//  Copyright © 2015 Dancing Queen. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface WDTransaction : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double internalBaseClassIdentifier;
@property (nonatomic, assign) double sellerId;
@property (nonatomic, assign) double productId;
@property (nonatomic, assign) double buyerId;
@property (nonatomic, strong) NSString *transactionDate;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
