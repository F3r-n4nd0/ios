//
//  WDMainMenuLeftViewModel.h
//  WallaDog
//
//  Created by Fernando Luna on 1/24/16.
//  Copyright © 2016 Dancing Queen. All rights reserved.
//
@import Foundation;
@import UIKit;

@class WDMainViewModel;

@protocol WDMainMenuLeftViewModelDelegate <NSObject>

@required
- (void)updateMenuSection:(NSInteger) section;
- (void)updateCurrentUser;

@end

@interface WDMainMenuLeftViewModel : NSObject

@property (nonatomic, weak) id<WDMainMenuLeftViewModelDelegate> delegate;

- (instancetype) init NS_UNAVAILABLE;
- (instancetype) initWithDelgate:(id<WDMainMenuLeftViewModelDelegate>) delegate
                   mainViewModel:(WDMainViewModel*) mainViewModel;

- (NSInteger)countMenuList;
- (NSInteger)countSubMenuList:(NSInteger)section;
- (NSString*)textMenuDescription:(NSInteger)section;
- (UIImage*)imageMenu:(NSInteger)section;
- (NSString*)textSubMenuDescriptionFromIndexPath:(NSIndexPath*)indexPath;
- (void)selectAccountUser;
- (void)selectMenu:(NSInteger)section;
- (void)selectSubMenu:(NSIndexPath*)indexPath;
- (void)deselectSubMenu:(NSIndexPath*)indexPath;
- (NSURL*)urlAvatarThumbnailUser;
- (NSString*)titleAccount;
- (NSString*)SubTitleAccount;


@end
