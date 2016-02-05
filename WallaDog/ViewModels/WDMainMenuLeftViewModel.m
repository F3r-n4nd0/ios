//
//  WDMainMenuLeftViewModel.m
//  WallaDog
//
//  Created by Fernando Luna on 1/24/16.
//  Copyright © 2016 Dancing Queen. All rights reserved.
//

#import "WDMainMenuLeftViewModel.h"
#import "WDCategory.h"
#import "WDHTTPClient.h"
#import "WDMainViewModel.h"
#import "WDUser.h"
#import "WDUIHelper.h"

@interface WDMainMenuLeftViewModel()

@property (nonatomic, strong) NSArray<NSString *> *arrayMenu;
@property (nonatomic, strong) NSArray<UIImage *> *arrayMenuImage;
@property (nonatomic, strong) NSArray<WDCategory *> *arrayCategory;

@property (nonatomic, strong) WDMainViewModel *mainViewModel;

@end


@implementation WDMainMenuLeftViewModel

#pragma mark - Life Cycle

- (instancetype) initWithDelgate:(id<WDMainMenuLeftViewModelDelegate>) delegate
                   mainViewModel:(WDMainViewModel*) mainViewModel {
    if(self = [super init]) {
        _arrayMenu = [NSArray array];
        _arrayCategory = [NSArray array];
        _arrayMenuImage = [NSArray array];
        _mainViewModel = mainViewModel;
        _delegate = delegate;
        [self loadMenuArray];
    }
    return self;
}

#pragma mark - public methods

#pragma mark user data
- (WDUser*)currentUser {
    return self.mainViewModel.currentUser;
}

- (NSURL*)urlAvatarThumbnailUser {
    if(self.currentUser)
        return self.currentUser.urlAvatarThumbnail;
    return nil;
}

- (NSString*)titleAccount {
    if(self.currentUser)
        return self.currentUser.fullName;
    return @"Sign up";
}

- (NSString*)SubTitleAccount {
    if(self.currentUser)
        return self.currentUser.sellingProducts;
    return @"or sign in";
}

#pragma mark collection menu

- (NSInteger)countMenuList {
    return self.arrayMenu.count;
}

- (NSInteger)countSubMenuList:(NSInteger)section {
    return 0;
}

- (NSString*)textMenuDescription:(NSInteger)section {
    return [self.arrayMenu objectAtIndex:section];
}

- (UIImage*)imageMenu:(NSInteger)section {
    return [self.arrayMenuImage objectAtIndex:section];
}

- (NSString*)textSubMenuDescriptionFromIndexPath:(NSIndexPath*)indexPath {
    return @"";
}

#pragma mark selectSubMenu 

- (void)selectMenu:(NSInteger)section {
    if([[self.arrayMenu objectAtIndex:section] isEqualToString:@"Close Session"]) {
        if(!self.currentUser)
            return;
        [WDUIHelper showConfirmationAlerTitle:@"Close Session" subTitle:@"You want to close your account" actionBlock:^{
            [self.mainViewModel removeUserAccount];
        }];
    }
    if([[self.arrayMenu objectAtIndex:section] isEqualToString:@"Add Item"]) {
        if(!self.currentUser) {
            [WDUIHelper showInfoAlertWithTitle:@"Add Item" subTitle:@"Need sing in or dign up first"];
            return;
        }
        [self.mainViewModel addNewItem];
    }
}

- (void)selectSubMenu:(NSIndexPath*)indexPath {

}

- (void)deselectSubMenu:(NSIndexPath*)indexPath {

}

- (void)selectAccountUser {
    if(self.mainViewModel)
       [self.mainViewModel showAccountUserOrCreateAccount];
}

#pragma mark - menu data

- (void)loadMenuArray {
    self.arrayMenu = self.getSectionsMenuText;
    self.arrayMenuImage = self.getSectionsMenuImages;
}

- (NSArray*)getSectionsMenuText {
    return @[@"Add Item",
             @"List Item",
             @"Close Session"];
}

- (NSArray*)getSectionsMenuImages {
    return @[[UIImage imageNamed:@"ImageIconLabel"],
             [UIImage imageNamed:@"ImageCameraIcon"],
             [UIImage imageNamed:@"ImageXIcon"]];
}

@end
