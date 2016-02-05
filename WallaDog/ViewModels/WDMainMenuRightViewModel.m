//
//  WDMainMenuRightViewModel.m
//  WallaDog
//
//  Created by Fernando Luna on 2/3/16.
//  Copyright © 2016 Dancing Queen. All rights reserved.
//

#import "WDMainMenuRightViewModel.h"
#import "WDCategory.h"
#import "WDHTTPClient.h"
#import "WDMainViewModel.h"
#import "WDRace.h"

@interface WDMainMenuRightViewModel ()

@property (nonatomic, strong) NSArray<NSString *> *arrayMenu;
@property (nonatomic, strong) NSArray<UIImage *> *arrayMenuImage;
@property (nonatomic, strong) NSArray<WDCategory *> *arrayCategory;
@property (nonatomic, strong) NSArray<WDRace *> *arrayRace;
@property (nonatomic, strong) NSArray<NSString *> *arrayDistance;

@property (nonatomic, strong) WDMainViewModel *mainViewModel;

@end

@implementation WDMainMenuRightViewModel

#pragma mark - Life Cycle

- (instancetype) initWithDelgate:(id<WDMainMenuRightViewModelDelegate>) delegate
                   mainViewModel:(WDMainViewModel*) mainViewModel {
    if(self = [super init]) {
        _arrayMenu = [NSArray array];
        _arrayCategory = [NSArray array];
        _arrayMenuImage = [NSArray array];
        _mainViewModel = mainViewModel;
        
        _delegate = delegate;
        [self loadMenuArray];
        [self updateCategoryeList];
        [self updateRacesList];
        [self updateDistanceList];
    }
    return self;
}

#pragma mark - public methods

#pragma mark update data

- (void)updateCategoryeList {
    
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

- (void)updateRacesList {
    
    [[WDHTTPClient sharedWDHTTPClient] getRacesSuccess:^(id responseObject)
     {
         NSMutableArray<WDRace *> *arratLoadRaces = [NSMutableArray<WDRace *> array];
         for (NSDictionary *each in responseObject) {
             WDRace *race = [[WDRace alloc] initWithDictionary:each];
             [arratLoadRaces addObject:race];
         }
         self.arrayRace = [arratLoadRaces copy];
         [arratLoadRaces removeAllObjects];
         if([self.delegate respondsToSelector:@selector(updateMenuSection:)])
             [self.delegate updateMenuSection:[self.arrayMenu indexOfObject:@"Races"]];
     } failure:^(NSString *errorDescripcion) {
         
     }];
}

- (void)updateDistanceList {
    self.arrayDistance= @[@"All",
                          @"10 Kilometers",
                          @"100 Kilometers"];
}

#pragma mark collection menu

- (NSInteger)countMenuList {
    return self.arrayMenu.count;
}

- (NSInteger)countSubMenuList:(NSInteger)section {
    
    if([[self.arrayMenu objectAtIndex:section] isEqualToString:@"Categories"]) {
        return self.arrayCategory.count;
    }
    if([[self.arrayMenu objectAtIndex:section] isEqualToString:@"Races"]) {
        return self.arrayRace.count;
    }
    if([[self.arrayMenu objectAtIndex:section] isEqualToString:@"Distance"]) {
        return self.arrayDistance.count;
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
    if([[self.arrayMenu objectAtIndex:indexPath.section] isEqualToString:@"Races"]) {
        return [self.arrayRace objectAtIndex:indexPath.row].name;
    }
    if([[self.arrayMenu objectAtIndex:indexPath.section] isEqualToString:@"Distance"]) {
        return [self.arrayDistance objectAtIndex:indexPath.row];
    }
    return @"";
}

#pragma mark selectSubMenu

- (void)selectMenu:(NSInteger)section {
    //TODO IF NEED
}

- (void)selectSubMenu:(NSIndexPath*)indexPath {
    if([[self.arrayMenu objectAtIndex:indexPath.section] isEqualToString:@"Categories"])
        [self.mainViewModel changeFilterCategory:[self.arrayCategory objectAtIndex:indexPath.row].internalBaseClassIdentifier];
    if([[self.arrayMenu objectAtIndex:indexPath.section] isEqualToString:@"Races"])
        [self.mainViewModel changeFilterRaces:[self.arrayRace objectAtIndex:indexPath.row].idField];
    if([[self.arrayMenu objectAtIndex:indexPath.section] isEqualToString:@"Distance"]) {
        NSString *title = [self.arrayDistance objectAtIndex:indexPath.row];
        if([title isEqualToString:[self.arrayDistance objectAtIndex:0]]){
            [self.mainViewModel changeFilteDistance:100000000];
        } else if ([title isEqualToString:[self.arrayDistance objectAtIndex:1]]) {
            [self.mainViewModel changeFilteDistance:10];
        }else if ([title isEqualToString:[self.arrayDistance objectAtIndex:2]]) {
            [self.mainViewModel changeFilteDistance:100];
        }
    }
    
}

- (void)deselectSubMenu:(NSIndexPath*)indexPath {
    if([[self.arrayMenu objectAtIndex:indexPath.section] isEqualToString:@"Categories"])
        [self.mainViewModel changeFilterCategory:0];
}


#pragma mark - menu data

- (void)loadMenuArray {
    self.arrayMenu = self.getSectionsMenuText;
    self.arrayMenuImage = self.getSectionsMenuImages;
}

- (NSArray*)getSectionsMenuText {
    return @[@"Categories",
             @"Races",
             @"Distance"];
}

- (NSArray*)getSectionsMenuImages {
    return @[[UIImage imageNamed:@"ImageMessageIcon"],
             [UIImage imageNamed:@"ImageMessageIcon"],
             [UIImage imageNamed:@"ImageMessageIcon"]];
}

@end
