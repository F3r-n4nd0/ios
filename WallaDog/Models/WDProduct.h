//
//  WDProduct.h
//  WallaDog
//
//  Created by Pepe Padilla on 15/08/12.
//  Copyright © 2015 Dancing Queen. All rights reserved.
//

@import UIKit;
@class WDSeller;
@class WDImage;

@interface WDProduct : NSObject

@property (nonatomic, assign) BOOL active;
@property (nonatomic, strong) NSString * category;
@property (nonatomic, strong) NSString * categoryid;
@property (nonatomic, strong) NSString * createdAt;
@property (nonatomic, strong) NSString * descriptionField;
@property (nonatomic, strong) NSString * gender;
@property (nonatomic, assign) NSInteger idField;
@property (nonatomic, strong) NSArray<WDImage *> * images;
@property (nonatomic, strong) NSString * latitude;
@property (nonatomic, strong) NSString * longitude;
@property (nonatomic, strong) NSString * name;
@property (nonatomic, assign) CGFloat price;
@property (nonatomic, strong) NSString * race;
@property (nonatomic, strong) NSString * raceid;
@property (nonatomic, strong) WDSeller * seller;
@property (nonatomic, strong) NSString * state;
@property (nonatomic, strong) NSString * stateid;
@property (nonatomic, assign) BOOL sterile;
@property (nonatomic, strong) NSString * updatedAt;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;

- (NSURL*)urlImagePresentation;
- (NSURL*)urlImageThumbnailPresentation;
- (NSString*)pricePresentation;
- (NSURL*)urlImageFromIndex:(NSInteger) index;
- (NSURL*)urlSellerAvatarThumbnail;
- (NSString*)textSellerDescription;

@end