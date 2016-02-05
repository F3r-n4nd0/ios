//
//  WDTransaction.m
//  WallaDog
//
//  Created by Pepe Padilla on 15/08/12.
//  Copyright © 2015 Dancing Queen. All rights reserved.
//

#import "WDTransaction.h"


NSString *const kDQTransactionId = @"id";
NSString *const kDQTransactionSellerId = @"sellerId";
NSString *const kDQTransactionProductId = @"productId";
NSString *const kDQTransactionBuyerId = @"buyerId";
NSString *const kDQTransactionTransactionDate = @"transaction_date";


@interface WDTransaction ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation WDTransaction

@synthesize internalBaseClassIdentifier = _internalBaseClassIdentifier;
@synthesize sellerId = _sellerId;
@synthesize productId = _productId;
@synthesize buyerId = _buyerId;
@synthesize transactionDate = _transactionDate;


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
        self.internalBaseClassIdentifier = [[self objectOrNilForKey:kDQTransactionId fromDictionary:dict] doubleValue];
        self.sellerId = [[self objectOrNilForKey:kDQTransactionSellerId fromDictionary:dict] doubleValue];
        self.productId = [[self objectOrNilForKey:kDQTransactionProductId fromDictionary:dict] doubleValue];
        self.buyerId = [[self objectOrNilForKey:kDQTransactionBuyerId fromDictionary:dict] doubleValue];
        self.transactionDate = [self objectOrNilForKey:kDQTransactionTransactionDate fromDictionary:dict];
        
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.internalBaseClassIdentifier] forKey:kDQTransactionId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.sellerId] forKey:kDQTransactionSellerId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.productId] forKey:kDQTransactionProductId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.buyerId] forKey:kDQTransactionBuyerId];
    [mutableDict setValue:self.transactionDate forKey:kDQTransactionTransactionDate];
    
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
    
    self.internalBaseClassIdentifier = [aDecoder decodeDoubleForKey:kDQTransactionId];
    self.sellerId = [aDecoder decodeDoubleForKey:kDQTransactionSellerId];
    self.productId = [aDecoder decodeDoubleForKey:kDQTransactionProductId];
    self.buyerId = [aDecoder decodeDoubleForKey:kDQTransactionBuyerId];
    self.transactionDate = [aDecoder decodeObjectForKey:kDQTransactionTransactionDate];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
    [aCoder encodeDouble:_internalBaseClassIdentifier forKey:kDQTransactionId];
    [aCoder encodeDouble:_sellerId forKey:kDQTransactionSellerId];
    [aCoder encodeDouble:_productId forKey:kDQTransactionProductId];
    [aCoder encodeDouble:_buyerId forKey:kDQTransactionBuyerId];
    [aCoder encodeObject:_transactionDate forKey:kDQTransactionTransactionDate];
}

- (id)copyWithZone:(NSZone *)zone
{
    WDTransaction *copy = [[WDTransaction alloc] init];
    
    if (copy) {
        
        copy.internalBaseClassIdentifier = self.internalBaseClassIdentifier;
        copy.sellerId = self.sellerId;
        copy.productId = self.productId;
        copy.buyerId = self.buyerId;
        copy.transactionDate = [self.transactionDate copyWithZone:zone];
    }
    
    return copy;
}


@end
