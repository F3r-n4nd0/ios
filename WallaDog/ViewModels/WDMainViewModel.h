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
@class WDUser;

@protocol WDMainViewModelDelegate <NSObject>

@required
- (void)updateListProducts;
- (void)startUploadProducts:(NSString*)action;
- (void)stopUploadProducts;
- (void)showProductviewModel:(WDProductViewModel*) productViewModel;
- (void)showStartAccount:(WDStartedViewModels*) startedViewModel;
- (void)showMainViewHideMenus;
- (void)updateCurrentUser;

@end

@interface WDMainViewModel : NSObject

@property (readonly) WDUser *currentUser;

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
- (void)selectProduct:(NSIndexPath*)indexPath;
- (void)showAccountUserOrCreateAccount;
- (void)showMainView;
- (void)updateUserAccountNew;
- (void)removeUserAccount;

@end
