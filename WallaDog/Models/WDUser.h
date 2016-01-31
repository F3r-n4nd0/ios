//
//	WDUser.h
//
//	Create by Fernando on 31/1/2016
//	Copyright © 2016. All rights reserved.
//

//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

@import UIKit;

@interface WDUser : NSObject <NSCoding>

@property (nonatomic, strong) NSString * avatarThumbnailUrl;
@property (nonatomic, strong) NSString * avatarUrl;
@property (nonatomic, strong) NSString * email;
@property (nonatomic, strong) NSString * firstName;
@property (nonatomic, assign) NSInteger idField;
@property (nonatomic, strong) NSString * lastName;
@property (nonatomic, assign) NSInteger productsCount;
@property (nonatomic, strong) NSString * username;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;

- (NSURL*)urlAvatarThumbnail;
- (NSURL*)urlAvatar;
- (NSString*)fullName;
- (NSString*)sellingProducts;

@end