//
//  WDAddItemViewModel.h
//  WallaDog
//
//  Created by Fernando Luna on 2/4/16.
//  Copyright © 2016 Dancing Queen. All rights reserved.
//

@import UIKit;

@class WDMainViewModel;
@class WDCategory;
@class WDRace;

@interface WDAddItemViewModel : NSObject

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithMainViewModel:(WDMainViewModel*)mainViewModel
                      arrayCategories:(NSArray<WDCategory*>*)arrayCategories
                           arrayRaces:(NSArray<WDRace*>*)arrayRaces;
- (instancetype)initWithMainViewModel:(WDMainViewModel*)mainViewModel
                                image:(UIImage*)image
                      arrayCategories:(NSArray<WDCategory*>*)arrayCategories
                           arrayRaces:(NSArray<WDRace*>*)arrayRaces;

- (UIImage*)photImage1;
- (UIImage*)photImage2;
- (UIImage*)photImage3;
- (UIImage*)photImage4;

- (NSArray*)arrayListCategories;
- (NSArray*)arrayListRace;

- (void)savenewItemWithTitle:(NSString*)title
                 description:(NSString*)description
                       price:(NSString*)price
                      image1:(UIImage*)image1
                      image2:(UIImage*)image2
                      image3:(UIImage*)image3
                      image4:(UIImage*)image4
                     success:(void (^)())success
                     failure:(void (^)(NSString *errorDescripcion))failure;

- (NSString*)textSelectCategory;
- (NSString*)textSelectRace;

- (void)selectCategory:(NSInteger)index;
- (void)selectRace:(NSInteger)index;

@end
