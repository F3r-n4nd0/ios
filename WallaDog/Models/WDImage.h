//
//	Image.h
//
//	Create by Fernando on 24/1/2016
//	Copyright © 2016. All rights reserved.
//

//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

#import <UIKit/UIKit.h>

@interface WDImage : NSObject

@property (nonatomic, assign) NSInteger idField;
@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) NSString * photoThumbnailUrl;
@property (nonatomic, strong) NSString * photoUrl;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;

- (NSURL*)urlPhotoUrl;
- (NSURL*)urlPhotoThumbnailUrl;

@end