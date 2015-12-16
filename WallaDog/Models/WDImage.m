//
//  WDImage.m
//  WallaDog
//
//  Created by Pepe Padilla on 15/08/12.
//  Copyright © 2015 Dancing Queen. All rights reserved.
//

#import "WDImage.h"


NSString *const kDQImageId = @"id";
NSString *const kDQImagePhotoUrl = @"photoUrl";
NSString *const kDQImageName = @"name";
NSString *const kDQImageProductId = @"productId";


@interface WDImage ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation WDImage

@synthesize internalBaseClassIdentifier = _internalBaseClassIdentifier;
@synthesize photoUrl = _photoUrl;
@synthesize name = _name;
@synthesize productId = _productId;


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
        self.internalBaseClassIdentifier = [[self objectOrNilForKey:kDQImageId fromDictionary:dict] doubleValue];
        self.photoUrl = [self objectOrNilForKey:kDQImagePhotoUrl fromDictionary:dict];
        self.name = [self objectOrNilForKey:kDQImageName fromDictionary:dict];
        self.productId = [[self objectOrNilForKey:kDQImageProductId fromDictionary:dict] doubleValue];
        
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.internalBaseClassIdentifier] forKey:kDQImageId];
    [mutableDict setValue:self.photoUrl forKey:kDQImagePhotoUrl];
    [mutableDict setValue:self.name forKey:kDQImageName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.productId] forKey:kDQImageProductId];
    
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
    
    self.internalBaseClassIdentifier = [aDecoder decodeDoubleForKey:kDQImageId];
    self.photoUrl = [aDecoder decodeObjectForKey:kDQImagePhotoUrl];
    self.name = [aDecoder decodeObjectForKey:kDQImageName];
    self.productId = [aDecoder decodeDoubleForKey:kDQImageProductId];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
    [aCoder encodeDouble:_internalBaseClassIdentifier forKey:kDQImageId];
    [aCoder encodeObject:_photoUrl forKey:kDQImagePhotoUrl];
    [aCoder encodeObject:_name forKey:kDQImageName];
    [aCoder encodeDouble:_productId forKey:kDQImageProductId];
}

- (id)copyWithZone:(NSZone *)zone
{
    WDImage *copy = [[WDImage alloc] init];
    
    if (copy) {
        
        copy.internalBaseClassIdentifier = self.internalBaseClassIdentifier;
        copy.photoUrl = [self.photoUrl copyWithZone:zone];
        copy.name = [self.name copyWithZone:zone];
        copy.productId = self.productId;
    }
    
    return copy;
}


@end