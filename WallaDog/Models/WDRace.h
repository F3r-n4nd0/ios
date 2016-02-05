//
//	WDRace.h
//
//	Create by Fernando on 4/2/2016
//	Copyright © 2016. All rights reserved.
//

//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

#import <UIKit/UIKit.h>

@interface WDRace : NSObject

@property (nonatomic, assign) NSInteger idField;
@property (nonatomic, strong) NSString * name;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end