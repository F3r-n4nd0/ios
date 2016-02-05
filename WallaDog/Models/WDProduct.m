//
//  WDProduct.m
//  WallaDog
//
//  Created by Pepe Padilla on 15/08/12.
//  Copyright © 2015 Dancing Queen. All rights reserved.
//


#import "WDProduct.h"
#import "WDImage.h"
#import "WDSeller.h"

@interface WDProduct ()
@end

@implementation WDProduct

/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if(![dictionary[@"active"] isKindOfClass:[NSNull class]]){
        self.active = [dictionary[@"active"] boolValue];
    }
    
    if(![dictionary[@"category"] isKindOfClass:[NSNull class]]){
        self.category = dictionary[@"category"];
    }
    if(![dictionary[@"categoryid"] isKindOfClass:[NSNull class]]){
        self.categoryid = dictionary[@"categoryid"];
    }
    if(![dictionary[@"created_at"] isKindOfClass:[NSNull class]]){
        self.createdAt = dictionary[@"created_at"];
    }
    if(![dictionary[@"description"] isKindOfClass:[NSNull class]]){
        self.descriptionField = dictionary[@"description"];
    }
    if(![dictionary[@"gender"] isKindOfClass:[NSNull class]]){
        self.gender = dictionary[@"gender"];
    }
    if(![dictionary[@"id"] isKindOfClass:[NSNull class]]){
        self.idField = [dictionary[@"id"] integerValue];
    }
    
    if(dictionary[@"images"] != nil && [dictionary[@"images"] isKindOfClass:[NSArray class]]){
        NSArray * imagesDictionaries = dictionary[@"images"];
        NSMutableArray * imagesItems = [NSMutableArray array];
        for(NSDictionary * imagesDictionary in imagesDictionaries){
            WDImage * imagesItem = [[WDImage alloc] initWithDictionary:imagesDictionary];
            [imagesItems addObject:imagesItem];
        }
        self.images = imagesItems;
    }
    if(![dictionary[@"latitude"] isKindOfClass:[NSNull class]]){
        self.latitude = dictionary[@"latitude"];
    }
    if(![dictionary[@"longitude"] isKindOfClass:[NSNull class]]){
        self.longitude = dictionary[@"longitude"];
    }
    if(![dictionary[@"name"] isKindOfClass:[NSNull class]]){
        self.name = dictionary[@"name"];
    }
    if(![dictionary[@"price"] isKindOfClass:[NSNull class]]){
        self.price = [dictionary[@"price"] floatValue];
    }
    
    if(![dictionary[@"race"] isKindOfClass:[NSNull class]]){
        self.race = dictionary[@"race"];
    }
    if(![dictionary[@"raceid"] isKindOfClass:[NSNull class]]){
        self.raceid = dictionary[@"raceid"];
    }
    if(![dictionary[@"seller"] isKindOfClass:[NSNull class]]){
        self.seller = [[WDSeller alloc] initWithDictionary:dictionary[@"seller"]];
    }
    
    if(![dictionary[@"state"] isKindOfClass:[NSNull class]]){
        self.state = dictionary[@"state"];
    }
    if(![dictionary[@"stateid"] isKindOfClass:[NSNull class]]){
        self.stateid = dictionary[@"stateid"];
    }
    if(![dictionary[@"sterile"] isKindOfClass:[NSNull class]]){
        self.sterile = [dictionary[@"sterile"] boolValue];
    }
    
    if(![dictionary[@"updated_at"] isKindOfClass:[NSNull class]]){
        self.updatedAt = dictionary[@"updated_at"];
    }
    return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
    NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
    dictionary[@"active"] = @(self.active);
    if(self.category != nil){
        dictionary[@"category"] = self.category;
    }
    if(self.categoryid != nil){
        dictionary[@"categoryid"] = self.categoryid;
    }
    if(self.createdAt != nil){
        dictionary[@"created_at"] = self.createdAt;
    }
    if(self.descriptionField != nil){
        dictionary[@"description"] = self.descriptionField;
    }
    if(self.gender != nil){
        dictionary[@"gender"] = self.gender;
    }
    dictionary[@"id"] = @(self.idField);
    if(self.images != nil){
        NSMutableArray * dictionaryElements = [NSMutableArray array];
        for(WDImage * imagesElement in self.images){
            [dictionaryElements addObject:[imagesElement toDictionary]];
        }
        dictionary[@"images"] = dictionaryElements;
    }
    if(self.latitude != nil){
        dictionary[@"latitude"] = self.latitude;
    }
    if(self.longitude != nil){
        dictionary[@"longitude"] = self.longitude;
    }
    if(self.name != nil){
        dictionary[@"name"] = self.name;
    }
    dictionary[@"price"] = @(self.price);
    if(self.race != nil){
        dictionary[@"race"] = self.race;
    }
    if(self.raceid != nil){
        dictionary[@"raceid"] = self.raceid;
    }
    if(self.seller != nil){
        dictionary[@"seller"] = [self.seller toDictionary];
    }
    if(self.state != nil){
        dictionary[@"state"] = self.state;
    }
    if(self.stateid != nil){
        dictionary[@"stateid"] = self.stateid;
    }
    dictionary[@"sterile"] = @(self.sterile);
    if(self.updatedAt != nil){
        dictionary[@"updated_at"] = self.updatedAt;
    }
    return dictionary;
    
}

/**
 * Implementation of NSCoding encoding method
 */
/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:@(self.active) forKey:@"active"];	if(self.category != nil){
        [aCoder encodeObject:self.category forKey:@"category"];
    }
    if(self.categoryid != nil){
        [aCoder encodeObject:self.categoryid forKey:@"categoryid"];
    }
    if(self.createdAt != nil){
        [aCoder encodeObject:self.createdAt forKey:@"created_at"];
    }
    if(self.descriptionField != nil){
        [aCoder encodeObject:self.descriptionField forKey:@"description"];
    }
    if(self.gender != nil){
        [aCoder encodeObject:self.gender forKey:@"gender"];
    }
    [aCoder encodeObject:@(self.idField) forKey:@"id"];	if(self.images != nil){
        [aCoder encodeObject:self.images forKey:@"images"];
    }
    if(self.latitude != nil){
        [aCoder encodeObject:self.latitude forKey:@"latitude"];
    }
    if(self.longitude != nil){
        [aCoder encodeObject:self.longitude forKey:@"longitude"];
    }
    if(self.name != nil){
        [aCoder encodeObject:self.name forKey:@"name"];
    }
    [aCoder encodeObject:@(self.price) forKey:@"price"];	if(self.race != nil){
        [aCoder encodeObject:self.race forKey:@"race"];
    }
    if(self.raceid != nil){
        [aCoder encodeObject:self.raceid forKey:@"raceid"];
    }
    if(self.seller != nil){
        [aCoder encodeObject:self.seller forKey:@"seller"];
    }
    if(self.state != nil){
        [aCoder encodeObject:self.state forKey:@"state"];
    }
    if(self.stateid != nil){
        [aCoder encodeObject:self.stateid forKey:@"stateid"];
    }
    [aCoder encodeObject:@(self.sterile) forKey:@"sterile"];	if(self.updatedAt != nil){
        [aCoder encodeObject:self.updatedAt forKey:@"updated_at"];
    }
    
}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    self.active = [[aDecoder decodeObjectForKey:@"active"] boolValue];
    self.category = [aDecoder decodeObjectForKey:@"category"];
    self.categoryid = [aDecoder decodeObjectForKey:@"categoryid"];
    self.createdAt = [aDecoder decodeObjectForKey:@"created_at"];
    self.descriptionField = [aDecoder decodeObjectForKey:@"description"];
    self.gender = [aDecoder decodeObjectForKey:@"gender"];
    self.idField = [[aDecoder decodeObjectForKey:@"id"] integerValue];
    self.images = [aDecoder decodeObjectForKey:@"images"];
    self.latitude = [aDecoder decodeObjectForKey:@"latitude"];
    self.longitude = [aDecoder decodeObjectForKey:@"longitude"];
    self.name = [aDecoder decodeObjectForKey:@"name"];
    self.price = [[aDecoder decodeObjectForKey:@"price"] floatValue];
    self.race = [aDecoder decodeObjectForKey:@"race"];
    self.raceid = [aDecoder decodeObjectForKey:@"raceid"];
    self.seller = [aDecoder decodeObjectForKey:@"seller"];
    self.state = [aDecoder decodeObjectForKey:@"state"];
    self.stateid = [aDecoder decodeObjectForKey:@"stateid"];
    self.sterile = [[aDecoder decodeObjectForKey:@"sterile"] boolValue];
    self.updatedAt = [aDecoder decodeObjectForKey:@"updated_at"];
    return self;
    
}


#pragma mark - custom

- (WDImage*)getPresentationImage {
    if(self.images && self.images.count > 0) {
        return [self.images objectAtIndex:0];
    }
    return nil;
}

- (NSURL*)urlImageFromIndex:(NSInteger) index {
    return [self.images objectAtIndex:index].urlPhotoUrl;
}


- (NSURL*)urlImagePresentation {
    return self.getPresentationImage.urlPhotoUrl;
}

- (NSURL*)urlImageThumbnailPresentation  {
    return self.getPresentationImage.urlPhotoThumbnailUrl;
}

- (NSString*)pricePresentation  {
    return [NSString stringWithFormat:@"$ %.02f",  self.price];
}

- (NSURL*)urlSellerAvatarThumbnail {
    if(!self.seller)
        return nil;
    return self.seller.urlAvatarThumbnail;
}

- (NSString*)textSellerDescription {
    if(!self.seller)
        return nil;
    return self.seller.descriptionName;
}

@end