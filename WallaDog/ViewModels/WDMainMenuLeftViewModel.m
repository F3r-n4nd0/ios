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
        [self updateCAtegoryeList];
    }
    return self;
}

#pragma mark - public methods

#pragma mark update data

- (void)updateCAtegoryeList {
    
    [[WDHTTPClient sharedWDHTTPClient] getCategoriesSuccess:^(id responseObject)
     {
         NSMutableArray<WDCategory *> *arrayLoadCategories = [NSMutableArray<WDCategory *> array];
         for (NSDictionary *each in responseObject) {
             WDCategory *category = [[WDCategory alloc] initWithDictionary:each];
             [arrayLoadCategories addObject:category];
         }
         self.arrayCategory = [arrayLoadCategories copy];
         [arrayLoadCategories removeAllObjects];
         if([self.delegate respondsToSelector:@selector(updateMenuSection:)])
             [self.delegate updateMenuSection:[self.arrayMenu indexOfObject:@"Categories"]];
     } failure:^(NSString *errorDescripcion) {
         
     }];
}

#pragma mark collection menu

- (NSInteger)countMenuList {
    return self.arrayMenu.count;
}

- (NSInteger)countSubMenuList:(NSInteger)section {
    
    if([[self.arrayMenu objectAtIndex:section] isEqualToString:@"Categories"]) {
        return self.arrayCategory.count;
    }
    return 0;
}

- (NSString*)textMenuDescription:(NSInteger)section {
    return [self.arrayMenu objectAtIndex:section];
}

- (UIImage*)imageMenu:(NSInteger)section {
    return [self.arrayMenuImage objectAtIndex:section];
}

- (NSString*)textSubMenuDescriptionFromIndexPath:(NSIndexPath*)indexPath {
    if([[self.arrayMenu objectAtIndex:indexPath.section] isEqualToString:@"Categories"]) {
        return [self.arrayCategory objectAtIndex:indexPath.row].name;
    }
    return @"";
}

#pragma mark selectSubMenu 

- (void)selectSubMenu:(NSIndexPath*)indexPath {
    if([[self.arrayMenu objectAtIndex:indexPath.section] isEqualToString:@"Categories"]) {
        [self.mainViewModel changeFilterCategory:[self.arrayCategory objectAtIndex:indexPath.row].internalBaseClassIdentifier];
    }
}

- (void)deselectSubMenu:(NSIndexPath*)indexPath {
    if([[self.arrayMenu objectAtIndex:indexPath.section] isEqualToString:@"Categories"]) {
         [self.mainViewModel changeFilterCategory:0];
    }
}

#pragma mark - menu data

- (void)loadMenuArray {
    self.arrayMenu = self.getSectionsMenuText;
    self.arrayMenuImage = self.getSectionsMenuImages;
}

- (NSArray*)getSectionsMenuText {
    return @[@"List Item",
             @"Messages",
             @"Categories",
             @"Help"];
}

- (NSArray*)getSectionsMenuImages {
    return @[[UIImage imageNamed:@"ImageCameraIcon"],
             [UIImage imageNamed:@"ImageMessageIcon"],
             [UIImage imageNamed:@"ImageMessageIcon"],
             [UIImage imageNamed:@"ImageHelpIcon"]];
}

@end
