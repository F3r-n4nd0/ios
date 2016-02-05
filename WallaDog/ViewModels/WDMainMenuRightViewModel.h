//
//  WDMainMenuRightViewModel.h
//  WallaDog
//
//  Created by Fernando Luna on 2/3/16.
//  Copyright © 2016 Dancing Queen. All rights reserved.
//

@import UIKit;

@class WDMainViewModel;
@class WDCategory;
@class WDRace;

@protocol WDMainMenuRightViewModelDelegate <NSObject>

@required
- (void)updateMenuSection:(NSInteger) section;

@end

@interface WDMainMenuRightViewModel : NSObject

@property (readonly) NSArray<WDCategory *> *arrayCategory;
@property (readonly) NSArray<WDRace *> *arrayRace;

@property (nonatomic, weak) id<WDMainMenuRightViewModelDelegate> delegate;

- (instancetype) init NS_UNAVAILABLE;
- (instancetype) initWithDelgate:(id<WDMainMenuRightViewModelDelegate>) delegate
                   mainViewModel:(WDMainViewModel*) mainViewModel;


- (NSInteger)countMenuList;
- (NSInteger)countSubMenuList:(NSInteger)section;
- (NSString*)textMenuDescription:(NSInteger)section;
- (UIImage*)imageMenu:(NSInteger)section;
- (NSString*)textSubMenuDescriptionFromIndexPath:(NSIndexPath*)indexPath;
- (void)selectMenu:(NSInteger)section;
- (void)selectSubMenu:(NSIndexPath*)indexPath;
- (void)deselectSubMenu:(NSIndexPath*)indexPath;

@end
