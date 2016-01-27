//
//	Seller.m
//
//	Create by Fernando on 24/1/2016
//	Copyright © 2016. All rights reserved.
//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "WDSeller.h"

@interface WDSeller ()
@end
@implementation WDSeller




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[@"avatar_thumbnail_url"] isKindOfClass:[NSNull class]]){
		self.avatarThumbnailUrl = dictionary[@"avatar_thumbnail_url"];
	}	
	if(![dictionary[@"avatar_url"] isKindOfClass:[NSNull class]]){
		self.avatarUrl = dictionary[@"avatar_url"];
	}	
	if(![dictionary[@"first_name"] isKindOfClass:[NSNull class]]){
		self.firstName = dictionary[@"first_name"];
	}	
	if(![dictionary[@"id"] isKindOfClass:[NSNull class]]){
		self.idField = [dictionary[@"id"] integerValue];
	}

	if(![dictionary[@"last_name"] isKindOfClass:[NSNull class]]){
		self.lastName = dictionary[@"last_name"];
	}	
	if(![dictionary[@"products_count"] isKindOfClass:[NSNull class]]){
		self.productsCount = [dictionary[@"products_count"] integerValue];
	}

	if(![dictionary[@"username"] isKindOfClass:[NSNull class]]){
		self.username = dictionary[@"username"];
	}	
	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	if(self.avatarThumbnailUrl != nil){
		dictionary[@"avatar_thumbnail_url"] = self.avatarThumbnailUrl;
	}
	if(self.avatarUrl != nil){
		dictionary[@"avatar_url"] = self.avatarUrl;
	}
	if(self.firstName != nil){
		dictionary[@"first_name"] = self.firstName;
	}
	dictionary[@"id"] = @(self.idField);
	if(self.lastName != nil){
		dictionary[@"last_name"] = self.lastName;
	}
	dictionary[@"products_count"] = @(self.productsCount);
	if(self.username != nil){
		dictionary[@"username"] = self.username;
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
	if(self.avatarThumbnailUrl != nil){
		[aCoder encodeObject:self.avatarThumbnailUrl forKey:@"avatar_thumbnail_url"];
	}
	if(self.avatarUrl != nil){
		[aCoder encodeObject:self.avatarUrl forKey:@"avatar_url"];
	}
	if(self.firstName != nil){
		[aCoder encodeObject:self.firstName forKey:@"first_name"];
	}
	[aCoder encodeObject:@(self.idField) forKey:@"id"];	if(self.lastName != nil){
		[aCoder encodeObject:self.lastName forKey:@"last_name"];
	}
	[aCoder encodeObject:@(self.productsCount) forKey:@"products_count"];	if(self.username != nil){
		[aCoder encodeObject:self.username forKey:@"username"];
	}

}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.avatarThumbnailUrl = [aDecoder decodeObjectForKey:@"avatar_thumbnail_url"];
	self.avatarUrl = [aDecoder decodeObjectForKey:@"avatar_url"];
	self.firstName = [aDecoder decodeObjectForKey:@"first_name"];
	self.idField = [[aDecoder decodeObjectForKey:@"id"] integerValue];
	self.lastName = [aDecoder decodeObjectForKey:@"last_name"];
	self.productsCount = [[aDecoder decodeObjectForKey:@"products_count"] integerValue];
	self.username = [aDecoder decodeObjectForKey:@"username"];
	return self;

}
@end