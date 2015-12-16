//
//  WDUser.m
//  WallaDog
//
//  Created by Pepe Padilla on 15/08/12.
//  Copyright © 2015 Dancing Queen. All rights reserved.
//


#import "WDUser.h"
#import "WDDetail.h"

NSString *const kDQUserDetail = @"detail";
NSString *const kDQUserPassword = @"password";
NSString *const kDQUserId = @"id";
NSString *const kDQUserLastname = @"lastname";
NSString *const kDQUserCompany = @"company";
NSString *const kDQUserFirstname = @"firstname";
NSString *const kDQUserEmail = @"email";


@interface WDUser ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation WDUser

@synthesize detail = _detail;
@synthesize password = _password;
@synthesize internalBaseClassIdentifier = _internalBaseClassIdentifier;
@synthesize lastname = _lastname;
@synthesize company = _company;
@synthesize firstname = _firstname;
@synthesize email = _email;


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
        self.detail = [WDDetail modelObjectWithDictionary:[dict objectForKey:kDQUserDetail]];
        self.password = [self objectOrNilForKey:kDQUserPassword fromDictionary:dict];
        self.internalBaseClassIdentifier = [[self objectOrNilForKey:kDQUserId fromDictionary:dict] doubleValue];
        self.lastname = [self objectOrNilForKey:kDQUserLastname fromDictionary:dict];
        self.company = [self objectOrNilForKey:kDQUserCompany fromDictionary:dict];
        self.firstname = [self objectOrNilForKey:kDQUserFirstname fromDictionary:dict];
        self.email = [self objectOrNilForKey:kDQUserEmail fromDictionary:dict];
        
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[self.detail dictionaryRepresentation] forKey:kDQUserDetail];
    [mutableDict setValue:self.password forKey:kDQUserPassword];
    [mutableDict setValue:[NSNumber numberWithDouble:self.internalBaseClassIdentifier] forKey:kDQUserId];
    [mutableDict setValue:self.lastname forKey:kDQUserLastname];
    [mutableDict setValue:self.company forKey:kDQUserCompany];
    [mutableDict setValue:self.firstname forKey:kDQUserFirstname];
    [mutableDict setValue:self.email forKey:kDQUserEmail];
    
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
    
    self.detail = [aDecoder decodeObjectForKey:kDQUserDetail];
    self.password = [aDecoder decodeObjectForKey:kDQUserPassword];
    self.internalBaseClassIdentifier = [aDecoder decodeDoubleForKey:kDQUserId];
    self.lastname = [aDecoder decodeObjectForKey:kDQUserLastname];
    self.company = [aDecoder decodeObjectForKey:kDQUserCompany];
    self.firstname = [aDecoder decodeObjectForKey:kDQUserFirstname];
    self.email = [aDecoder decodeObjectForKey:kDQUserEmail];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
    [aCoder encodeObject:_detail forKey:kDQUserDetail];
    [aCoder encodeObject:_password forKey:kDQUserPassword];
    [aCoder encodeDouble:_internalBaseClassIdentifier forKey:kDQUserId];
    [aCoder encodeObject:_lastname forKey:kDQUserLastname];
    [aCoder encodeObject:_company forKey:kDQUserCompany];
    [aCoder encodeObject:_firstname forKey:kDQUserFirstname];
    [aCoder encodeObject:_email forKey:kDQUserEmail];
}

- (id)copyWithZone:(NSZone *)zone
{
    WDUser *copy = [[WDUser alloc] init];
    
    if (copy) {
        
        copy.detail = [self.detail copyWithZone:zone];
        copy.password = [self.password copyWithZone:zone];
        copy.internalBaseClassIdentifier = self.internalBaseClassIdentifier;
        copy.lastname = [self.lastname copyWithZone:zone];
        copy.company = [self.company copyWithZone:zone];
        copy.firstname = [self.firstname copyWithZone:zone];
        copy.email = [self.email copyWithZone:zone];
    }
    
    return copy;
}


@end
