//
//  WDState.m
//  WallaDog
//
//  Created by Pepe Padilla on 15/08/12.
//  Copyright © 2015 Dancing Queen. All rights reserved.
//

#import "WDState.h"

#import "WDState.h"


NSString *const kDQStateId = @"id";
NSString *const kDQStateName = @"name";


@interface WDState ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation WDState

@synthesize internalBaseClassIdentifier = _internalBaseClassIdentifier;
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
        self.internalBaseClassIdentifier = [[self objectOrNilForKey:kDQStateId fromDictionary:dict] doubleValue];
        self.name = [self objectOrNilForKey:kDQStateName fromDictionary:dict];
        
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.internalBaseClassIdentifier] forKey:kDQStateId];
    [mutableDict setValue:self.name forKey:kDQStateName];
    
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
    
    self.internalBaseClassIdentifier = [aDecoder decodeDoubleForKey:kDQStateId];
    self.name = [aDecoder decodeObjectForKey:kDQStateName];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
    [aCoder encodeDouble:_internalBaseClassIdentifier forKey:kDQStateId];
    [aCoder encodeObject:_name forKey:kDQStateName];
}

- (id)copyWithZone:(NSZone *)zone
{
    WDState *copy = [[WDState alloc] init];
    
    if (copy) {
        
        copy.internalBaseClassIdentifier = self.internalBaseClassIdentifier;
        copy.name = [self.name copyWithZone:zone];
    }
    
    return copy;
}


@end