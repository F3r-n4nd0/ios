//
//  WDSaveSearch.m
//  WallaDog
//
//  Created by Pepe Padilla on 15/08/12.
//  Copyright © 2015 Dancing Queen. All rights reserved.
//

#import "WDSavedSearch.h"


NSString *const kDQSavedSearchRaceId = @"raceId";
NSString *const kDQSavedSearchUserId = @"userId";
NSString *const kDQSavedSearchLongitude = @"longitude";
NSString *const kDQSavedSearchId = @"id";
NSString *const kDQSavedSearchKeywords = @"keywords";
NSString *const kDQSavedSearchCategoryId = @"categoryId";
NSString *const kDQSavedSearchLatitude = @"latitude";


@interface WDSavedSearch ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation WDSavedSearch

@synthesize raceId = _raceId;
@synthesize userId = _userId;
@synthesize longitude = _longitude;
@synthesize internalBaseClassIdentifier = _internalBaseClassIdentifier;
@synthesize keywords = _keywords;
@synthesize categoryId = _categoryId;
@synthesize latitude = _latitude;


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
        self.raceId = [[self objectOrNilForKey:kDQSavedSearchRaceId fromDictionary:dict] doubleValue];
        self.userId = [[self objectOrNilForKey:kDQSavedSearchUserId fromDictionary:dict] doubleValue];
        self.longitude = [[self objectOrNilForKey:kDQSavedSearchLongitude fromDictionary:dict] doubleValue];
        self.internalBaseClassIdentifier = [[self objectOrNilForKey:kDQSavedSearchId fromDictionary:dict] doubleValue];
        self.keywords = [self objectOrNilForKey:kDQSavedSearchKeywords fromDictionary:dict];
        self.categoryId = [[self objectOrNilForKey:kDQSavedSearchCategoryId fromDictionary:dict] doubleValue];
        self.latitude = [[self objectOrNilForKey:kDQSavedSearchLatitude fromDictionary:dict] doubleValue];
        
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.raceId] forKey:kDQSavedSearchRaceId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.userId] forKey:kDQSavedSearchUserId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.longitude] forKey:kDQSavedSearchLongitude];
    [mutableDict setValue:[NSNumber numberWithDouble:self.internalBaseClassIdentifier] forKey:kDQSavedSearchId];
    [mutableDict setValue:self.keywords forKey:kDQSavedSearchKeywords];
    [mutableDict setValue:[NSNumber numberWithDouble:self.categoryId] forKey:kDQSavedSearchCategoryId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.latitude] forKey:kDQSavedSearchLatitude];
    
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
    
    self.raceId = [aDecoder decodeDoubleForKey:kDQSavedSearchRaceId];
    self.userId = [aDecoder decodeDoubleForKey:kDQSavedSearchUserId];
    self.longitude = [aDecoder decodeDoubleForKey:kDQSavedSearchLongitude];
    self.internalBaseClassIdentifier = [aDecoder decodeDoubleForKey:kDQSavedSearchId];
    self.keywords = [aDecoder decodeObjectForKey:kDQSavedSearchKeywords];
    self.categoryId = [aDecoder decodeDoubleForKey:kDQSavedSearchCategoryId];
    self.latitude = [aDecoder decodeDoubleForKey:kDQSavedSearchLatitude];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
    [aCoder encodeDouble:_raceId forKey:kDQSavedSearchRaceId];
    [aCoder encodeDouble:_userId forKey:kDQSavedSearchUserId];
    [aCoder encodeDouble:_longitude forKey:kDQSavedSearchLongitude];
    [aCoder encodeDouble:_internalBaseClassIdentifier forKey:kDQSavedSearchId];
    [aCoder encodeObject:_keywords forKey:kDQSavedSearchKeywords];
    [aCoder encodeDouble:_categoryId forKey:kDQSavedSearchCategoryId];
    [aCoder encodeDouble:_latitude forKey:kDQSavedSearchLatitude];
}

- (id)copyWithZone:(NSZone *)zone
{
    WDSavedSearch *copy = [[WDSavedSearch alloc] init];
    
    if (copy) {
        
        copy.raceId = self.raceId;
        copy.userId = self.userId;
        copy.longitude = self.longitude;
        copy.internalBaseClassIdentifier = self.internalBaseClassIdentifier;
        copy.keywords = [self.keywords copyWithZone:zone];
        copy.categoryId = self.categoryId;
        copy.latitude = self.latitude;
    }
    
    return copy;
}


@end
