//
//	Image.m
//
//	Create by Fernando on 24/1/2016
//	Copyright © 2016. All rights reserved.
//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "WDImage.h"

@interface WDImage ()
@end
@implementation WDImage




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[@"id"] isKindOfClass:[NSNull class]]){
		self.idField = [dictionary[@"id"] integerValue];
	}

	if(![dictionary[@"name"] isKindOfClass:[NSNull class]]){
		self.name = dictionary[@"name"];
	}	
	if(![dictionary[@"photo_thumbnail_url"] isKindOfClass:[NSNull class]]){
		self.photoThumbnailUrl = dictionary[@"photo_thumbnail_url"];
	}	
	if(![dictionary[@"photo_url"] isKindOfClass:[NSNull class]]){
		self.photoUrl = dictionary[@"photo_url"];
	}	
	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	dictionary[@"id"] = @(self.idField);
	if(self.name != nil){
		dictionary[@"name"] = self.name;
	}
	if(self.photoThumbnailUrl != nil){
		dictionary[@"photo_thumbnail_url"] = self.photoThumbnailUrl;
	}
	if(self.photoUrl != nil){
		dictionary[@"photo_url"] = self.photoUrl;
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
	[aCoder encodeObject:@(self.idField) forKey:@"id"];	if(self.name != nil){
		[aCoder encodeObject:self.name forKey:@"name"];
	}
	if(self.photoThumbnailUrl != nil){
		[aCoder encodeObject:self.photoThumbnailUrl forKey:@"photo_thumbnail_url"];
	}
	if(self.photoUrl != nil){
		[aCoder encodeObject:self.photoUrl forKey:@"photo_url"];
	}

}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.idField = [[aDecoder decodeObjectForKey:@"id"] integerValue];
	self.name = [aDecoder decodeObjectForKey:@"name"];
	self.photoThumbnailUrl = [aDecoder decodeObjectForKey:@"photo_thumbnail_url"];
	self.photoUrl = [aDecoder decodeObjectForKey:@"photo_url"];
	return self;

}

#pragma mark - custom

- (NSURL*)urlPhotoUrl {
    return [NSURL URLWithString:self.photoUrl];
}

- (NSURL*)urlPhotoThumbnailUrl {
    return [NSURL URLWithString:self.photoThumbnailUrl];    
}

@end