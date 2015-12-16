//
//  WDDetail.m
//  WallaDog
//
//  Created by Pepe Padilla on 15/08/12.
//  Copyright © 2015 Dancing Queen. All rights reserved.
//


#import "WDDetail.h"


NSString *const kDQDetailLatitude = @"latitude";
NSString *const kDQDetailFacebookToken = @"facebook_token";
NSString *const kDQDetailLongitude = @"longitude";
NSString *const kDQDetailAvatarUrl = @"avatar_url";


@interface WDDetail ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation WDDetail

@synthesize latitude = _latitude;
@synthesize facebookToken = _facebookToken;
@synthesize longitude = _longitude;
@synthesize avatarUrl = _avatarUrl;


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
        self.latitude = [[self objectOrNilForKey:kDQDetailLatitude fromDictionary:dict] doubleValue];
        self.facebookToken = [self objectOrNilForKey:kDQDetailFacebookToken fromDictionary:dict];
        self.longitude = [[self objectOrNilForKey:kDQDetailLongitude fromDictionary:dict] doubleValue];
        self.avatarUrl = [self objectOrNilForKey:kDQDetailAvatarUrl fromDictionary:dict];
        
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.latitude] forKey:kDQDetailLatitude];
    [mutableDict setValue:self.facebookToken forKey:kDQDetailFacebookToken];
    [mutableDict setValue:[NSNumber numberWithDouble:self.longitude] forKey:kDQDetailLongitude];
    [mutableDict setValue:self.avatarUrl forKey:kDQDetailAvatarUrl];
    
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
    
    self.latitude = [aDecoder decodeDoubleForKey:kDQDetailLatitude];
    self.facebookToken = [aDecoder decodeObjectForKey:kDQDetailFacebookToken];
    self.longitude = [aDecoder decodeDoubleForKey:kDQDetailLongitude];
    self.avatarUrl = [aDecoder decodeObjectForKey:kDQDetailAvatarUrl];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
    [aCoder encodeDouble:_latitude forKey:kDQDetailLatitude];
    [aCoder encodeObject:_facebookToken forKey:kDQDetailFacebookToken];
    [aCoder encodeDouble:_longitude forKey:kDQDetailLongitude];
    [aCoder encodeObject:_avatarUrl forKey:kDQDetailAvatarUrl];
}

- (id)copyWithZone:(NSZone *)zone
{
    WDDetail *copy = [[WDDetail alloc] init];
    
    if (copy) {
        
        copy.latitude = self.latitude;
        copy.facebookToken = [self.facebookToken copyWithZone:zone];
        copy.longitude = self.longitude;
        copy.avatarUrl = [self.avatarUrl copyWithZone:zone];
    }
    
    return copy;
}


@end
