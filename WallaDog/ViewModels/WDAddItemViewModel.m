//
//  WDAddItemViewModel.m
//  WallaDog
//
//  Created by Fernando Luna on 2/4/16.
//  Copyright © 2016 Dancing Queen. All rights reserved.
//

#import "WDAddItemViewModel.h"
#import "WDHTTPClient.h"
#import "WDCategory.h"
#import "WDRace.h"

@interface WDAddItemViewModel ()

@property (nonatomic, strong) UIImage *image1;
@property (nonatomic, strong) UIImage *image2;
@property (nonatomic, strong) UIImage *image3;
@property (nonatomic, strong) UIImage *image4;
@property (nonatomic) NSInteger categoryId;
@property (nonatomic) NSInteger raceId;
@property (nonatomic) NSInteger stateId;
@property (nonatomic, strong) NSArray<WDCategory*> *arrayCategories;
@property (nonatomic, strong) NSArray<WDRace*> *arrayRaces;

@property (nonatomic, strong) WDMainViewModel *mainViewModel;

@end

@implementation WDAddItemViewModel

#pragma mark - Cycle Life

- (instancetype)initWithMainViewModel:(WDMainViewModel*)mainViewModel
                      arrayCategories:(NSArray<WDCategory*>*)arrayCategories
                           arrayRaces:(NSArray<WDRace*>*)arrayRaces {
    if(self = [super init]){
        _mainViewModel = mainViewModel;
        _arrayCategories = arrayCategories;
        _arrayRaces = arrayRaces;
        [self defaultData];
    }
    return self;
}

- (instancetype)initWithMainViewModel:(WDMainViewModel*)mainViewModel
                                image:(UIImage*)image
                      arrayCategories:(NSArray<WDCategory*>*)arrayCategories
                           arrayRaces:(NSArray<WDRace*>*)arrayRaces {
    if(self = [super init]){
        _mainViewModel = mainViewModel;
        _image1 = image;
        _arrayCategories = arrayCategories;
        _arrayRaces = arrayRaces;
        [self defaultData];
    }
    return self;
}


-(void)defaultData {
   self.latitude = 40.4870096;
   self.longitude = -3.661856799999999;
   self.categoryId = 1;
   self.raceId = 1;
   self.stateId = 1;
}

#pragma mark - public methods

-(UIImage*)photImage1 {
    if(!self.image1)
        return nil;
    return self.image1;
}

-(UIImage*)photImage2 {
    if(!self.image2)
        return nil;
    return self.image2;
}

-(UIImage*)photImage3 {
    if(!self.image3)
        return nil;
    return self.image3;
}

-(UIImage*)photImage4 {
    if(!self.image4)
        return nil;
    return self.image4;
}

- (NSArray*)arrayListCategories {
    NSMutableArray *arrayReuslt = [ NSMutableArray array];
    for (WDCategory *each in self.arrayCategories) {
        [arrayReuslt addObject:each.name];
    }
    return [arrayReuslt copy];
}

- (NSArray*)arrayListRace {
    NSMutableArray *arrayReuslt = [ NSMutableArray array];
    for (WDRace *each in self.arrayRaces) {
        [arrayReuslt addObject:each.name];
    }
    return [arrayReuslt copy];
}


- (void)savenewItemWithTitle:(NSString*)title
                 description:(NSString*)description
                       price:(NSString*)price
                      image1:(UIImage*)image1
                      image2:(UIImage*)image2
                      image3:(UIImage*)image3
                      image4:(UIImage*)image4
                     success:(void (^)())success
                     failure:(void (^)(NSString *errorDescripcion))failure {
    
    NSData *data1 = [self compresImagePhoto:image1];
    NSData *data2 = [self compresImagePhoto:image2];
    NSData *data3 = [self compresImagePhoto:image3];
    NSData *data4 = [self compresImagePhoto:image4];
    
    [[WDHTTPClient sharedWDHTTPClient] savenewItemWithTitle:title
                                                description:description
                                                 categoryId:self.categoryId
                                                     raceId:self.raceId
                                                    stateId:self.stateId
                                                   latitude:self.latitude
                                                  longitude:self.longitude
                                                      price:price
                                                     image1:data1
                                                     image2:data2
                                                     image3:data3
                                                     image4:data4
                                                    success:^{
        success();
    } failure:^(NSString *errorDescripcion) {
        failure(errorDescripcion);
    }];
}

- (void)selectCategory:(NSInteger)index {
    WDCategory *category = [self.arrayCategories objectAtIndex:index];
    self.categoryId = category.internalBaseClassIdentifier;
}

- (void)selectRace:(NSInteger)index {
    WDRace *race = [self.arrayRaces objectAtIndex:index];
    self.raceId = race.idField;
}

- (NSString*)textSelectCategory {
    for (WDCategory *each in self.arrayCategories) {
        if(each.internalBaseClassIdentifier == self.categoryId)
            return each.name;
    }
    return @"NONE";
}

- (NSString*)textSelectRace {
    for (WDRace *each in self.arrayRaces) {
        if(each.idField == self.raceId)
            return each.name;
    }
    return @"NONE";
}

#pragma mark - private methods

- (NSData*)compresImagePhoto:(UIImage*)image {
    if(!image)
        return nil;
    CGFloat compression = 1.0f;
    CGFloat maxCompression = 0.1f;
    int maxFileSize = 210 * 1024;
    NSData *imageData = UIImageJPEGRepresentation(image, compression);
    while ([imageData length] > maxFileSize && compression > maxCompression) {
        compression -= 0.1;
        imageData = UIImageJPEGRepresentation(image, compression);
    }
    return imageData;
}
@end
