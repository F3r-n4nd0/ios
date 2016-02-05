//
//  WDMainViewModel.h
//  WallaDog
//
//  Created by Fernando Luna on 1/24/16.
//  Copyright © 2016 Dancing Queen. All rights reserved.
//

@import Foundation;
@import UIKit;

@class WDProductViewModel;
@class WDStartedViewModels;
@class WDAccountViewModel;
@class WDAddItemViewModel;
@class WDUser;
@class WDMainMenuRightViewModel;

@protocol WDMainViewModelDelegate <NSObject>

@required
- (void)updateListProducts;
- (void)startUploadProducts:(NSString*)action;
- (void)stopUploadProducts;
- (void)showProductviewModel:(WDProductViewModel*) productViewModel;
- (void)showStartAccount:(WDStartedViewModels*) startedViewModel;
- (void)showAddItem:(WDAddItemViewModel*) addItemViewModel;
- (void)showAccount:(WDAccountViewModel*) accountViewModel;
- (void)showMainViewHideMenus;
- (void)updateCurrentUser;
- (void)changeDistanceText:(NSString*)text;

@end

@interface WDMainViewModel : NSObject

@property (readonly) WDUser *currentUser;
@property (nonatomic, strong) WDMainMenuRightViewModel *rightViewModel;

@property (nonatomic, weak) id<WDMainViewModelDelegate> delegate;

- (instancetype) init NS_UNAVAILABLE;
- (instancetype) initWithDelgate:(id<WDMainViewModelDelegate>) delegate;

- (void)updateProductsList;
- (NSInteger)countProductsList;
- (NSURL*)urlImagePresentationFromIndexPath:(NSIndexPath*)indexPath;
- (NSURL*)urlImagePresentationThumbnailFromIndexPath:(NSIndexPath*)indexPath;
- (NSString*)textDescriptionPresentationFromIndexPath:(NSIndexPath*)indexPath;
- (NSString*)textPricePresentationFromIndexPath:(NSIndexPath*)indexPath;
- (void)changeFilterCategory:(NSInteger) categoryId;
- (void)changeFilteDistance:(NSInteger) distance;
- (void)changeFilterRaces:(NSInteger) raceId;
- (void)selectProduct:(NSIndexPath*)indexPath;
- (void)addNewItemWithImage:(UIImage*)image;
- (void)addNewItem;
- (void)showAccountUserOrCreateAccount;
- (void)showMainView;
- (void)updateUserAccountNew;
- (void)updateUserAccountNewWithUser:(WDUser*)user;
- (void)removeUserAccount;
- (void)changeNameSearch:(NSString*)filterName;
- (void)changeCalculateDistance:(NSIndexPath*)indexPath;
- (void)updateCurrentLocation;

@end
