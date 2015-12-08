//
//  DQProduct.m
//  WallaDog
//
//  Created by Pepe Padilla on 15/08/12.
//  Copyright © 2015 Dancing Queen. All rights reserved.
//


#import "DQProduct.h"


NSString *const kDQProductGender = @"gender";
NSString *const kDQProductStateId = @"stateId";
NSString *const kDQProductRaceId = @"raceId";
NSString *const kDQProductId = @"id";
NSString *const kDQProductPrice = @"price";
NSString *const kDQProductSellerId = @"sellerId";
NSString *const kDQProductSterile = @"sterile";
NSString *const kDQProductPublishDate = @"publish_date";
NSString *const kDQProductCategoryId = @"categoryId";
NSString *const kDQProductDescription = @"description";
NSString *const kDQProductName = @"name";


@interface DQProduct ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation DQProduct

@synthesize gender = _gender;
@synthesize stateId = _stateId;
@synthesize raceId = _raceId;
@synthesize internalBaseClassIdentifier = _internalBaseClassIdentifier;
@synthesize price = _price;
@synthesize sellerId = _sellerId;
@synthesize sterile = _sterile;
@synthesize publishDate = _publishDate;
@synthesize categoryId = _categoryId;
@synthesize internalBaseClassDescription = _internalBaseClassDescription;
@synthesize name = _name;


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
        self.gender = [self objectOrNilForKey:kDQProductGender fromDictionary:dict];
        self.stateId = [[self objectOrNilForKey:kDQProductStateId fromDictionary:dict] doubleValue];
        self.raceId = [[self objectOrNilForKey:kDQProductRaceId fromDictionary:dict] doubleValue];
        self.internalBaseClassIdentifier = [[self objectOrNilForKey:kDQProductId fromDictionary:dict] doubleValue];
        self.price = [[self objectOrNilForKey:kDQProductPrice fromDictionary:dict] doubleValue];
        self.sellerId = [[self objectOrNilForKey:kDQProductSellerId fromDictionary:dict] doubleValue];
        self.sterile = [[self objectOrNilForKey:kDQProductSterile fromDictionary:dict] boolValue];
        self.publishDate = [self objectOrNilForKey:kDQProductPublishDate fromDictionary:dict];
        self.categoryId = [[self objectOrNilForKey:kDQProductCategoryId fromDictionary:dict] doubleValue];
        self.internalBaseClassDescription = [self objectOrNilForKey:kDQProductDescription fromDictionary:dict];
        self.name = [self objectOrNilForKey:kDQProductName fromDictionary:dict];
        
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.gender forKey:kDQProductGender];
    [mutableDict setValue:[NSNumber numberWithDouble:self.stateId] forKey:kDQProductStateId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.raceId] forKey:kDQProductRaceId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.internalBaseClassIdentifier] forKey:kDQProductId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.price] forKey:kDQProductPrice];
    [mutableDict setValue:[NSNumber numberWithDouble:self.sellerId] forKey:kDQProductSellerId];
    [mutableDict setValue:[NSNumber numberWithBool:self.sterile] forKey:kDQProductSterile];
    [mutableDict setValue:self.publishDate forKey:kDQProductPublishDate];
    [mutableDict setValue:[NSNumber numberWithDouble:self.categoryId] forKey:kDQProductCategoryId];
    [mutableDict setValue:self.internalBaseClassDescription forKey:kDQProductDescription];
    [mutableDict setValue:self.name forKey:kDQProductName];
    
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
    
    self.gender = [aDecoder decodeObjectForKey:kDQProductGender];
    self.stateId = [aDecoder decodeDoubleForKey:kDQProductStateId];
    self.raceId = [aDecoder decodeDoubleForKey:kDQProductRaceId];
    self.internalBaseClassIdentifier = [aDecoder decodeDoubleForKey:kDQProductId];
    self.price = [aDecoder decodeDoubleForKey:kDQProductPrice];
    self.sellerId = [aDecoder decodeDoubleForKey:kDQProductSellerId];
    self.sterile = [aDecoder decodeBoolForKey:kDQProductSterile];
    self.publishDate = [aDecoder decodeObjectForKey:kDQProductPublishDate];
    self.categoryId = [aDecoder decodeDoubleForKey:kDQProductCategoryId];
    self.internalBaseClassDescription = [aDecoder decodeObjectForKey:kDQProductDescription];
    self.name = [aDecoder decodeObjectForKey:kDQProductName];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
    [aCoder encodeObject:_gender forKey:kDQProductGender];
    [aCoder encodeDouble:_stateId forKey:kDQProductStateId];
    [aCoder encodeDouble:_raceId forKey:kDQProductRaceId];
    [aCoder encodeDouble:_internalBaseClassIdentifier forKey:kDQProductId];
    [aCoder encodeDouble:_price forKey:kDQProductPrice];
    [aCoder encodeDouble:_sellerId forKey:kDQProductSellerId];
    [aCoder encodeBool:_sterile forKey:kDQProductSterile];
    [aCoder encodeObject:_publishDate forKey:kDQProductPublishDate];
    [aCoder encodeDouble:_categoryId forKey:kDQProductCategoryId];
    [aCoder encodeObject:_internalBaseClassDescription forKey:kDQProductDescription];
    [aCoder encodeObject:_name forKey:kDQProductName];
}

- (id)copyWithZone:(NSZone *)zone
{
    DQProduct *copy = [[DQProduct alloc] init];
    
    if (copy) {
        
        copy.gender = [self.gender copyWithZone:zone];
        copy.stateId = self.stateId;
        copy.raceId = self.raceId;
        copy.internalBaseClassIdentifier = self.internalBaseClassIdentifier;
        copy.price = self.price;
        copy.sellerId = self.sellerId;
        copy.sterile = self.sterile;
        copy.publishDate = [self.publishDate copyWithZone:zone];
        copy.categoryId = self.categoryId;
        copy.internalBaseClassDescription = [self.internalBaseClassDescription copyWithZone:zone];
        copy.name = [self.name copyWithZone:zone];
    }
    
    return copy;
}


@end
