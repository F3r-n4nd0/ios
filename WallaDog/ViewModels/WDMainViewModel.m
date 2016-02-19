//
//  WDMainViewModel.m
//  WallaDog
//
//  Created by Fernando Luna on 1/24/16.
//  Copyright © 2016 Dancing Queen. All rights reserved.
//
@import CoreLocation;
@import SDWebImage;
@import MapKit;

#import "WDMainViewModel.h"
#import "WDHTTPClient.h"
#import "WDProduct.h"
#import "WDProductViewModel.h"
#import "WDStartedViewModels.h"
#import "WDUser.h"
#import "WDAccountViewModel.h"
#import "WDAddItemViewModel.h"
#import "WDMainMenuRightViewModel.h"


@interface WDMainViewModel() <CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic) CLLocationCoordinate2D currentLocation;
@property (nonatomic, strong) NSArray<WDProduct *> *arrayProducts;
@property (nonatomic) NSInteger filterCategoryId;
@property (nonatomic) NSInteger filterRaceId;
@property (nonatomic, strong) NSURLSessionDataTask *currentLoadProductTask;
@property (nonatomic, strong) NSString *filterName;
@property (nonatomic) NSInteger filterDistance;


@property (nonatomic, strong) WDUser *currentUser;

@end

@implementation WDMainViewModel

#pragma mark - Life Cycle

- (instancetype) initWithDelgate:(id<WDMainViewModelDelegate>)delegate {
    if(self = [super init]) {
        _arrayProducts = [NSArray array];
        _delegate = delegate;
        [self loadLocationManager];
        [self loadCurrentUser];
        [self loadDefaultFlters];
    }
    return self;
}

- (void)loadLocationManager {
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    if (status == kCLAuthorizationStatusDenied) {
        NSString *title;
        title = (status == kCLAuthorizationStatusDenied) ? @"Location services are off" : @"Background location is not enabled";
        NSString *message = @"To use background location you must turn on 'Always' in the Location Services Settings";
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                            message:message
                                                           delegate:self
                                                  cancelButtonTitle:@"Cancel"
                                                  otherButtonTitles:@"Settings", nil];
        [alertView show];
        return;
    }
    [self updateCurrentLocation];
   
}

- (void)updateCurrentLocation {

    if (nil == self.locationManager) {
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
        self.locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
        [self.locationManager requestWhenInUseAuthorization];
    }
    [self.locationManager startUpdatingLocation];
}

- (void)loadCurrentUser {
    if([WDHTTPClient sharedWDHTTPClient].isAutentification)
        [self updateUserAccountNew];
}


-(void)loadDefaultFlters {
    self.filterDistance = 10000;
    self.filterCategoryId = 0;
    self.filterRaceId = 0;
    self.rightViewModel = [[WDMainMenuRightViewModel alloc] initWithDelgate:nil mainViewModel:self];
}

#pragma mark - public methods

#pragma mark update data

- (void)updateProductsList {
    
    if([self.delegate respondsToSelector:@selector(startUploadProducts:)])
        [self.delegate startUploadProducts:@"Load Products"];
    
    NSInteger filterStateId = 0;

    if(self.currentLoadProductTask)
        [self.currentLoadProductTask cancel];
    self.currentLoadProductTask = [[WDHTTPClient sharedWDHTTPClient] loadProductsWithLocationCoordinate:self.currentLocation
                                                                                           filterRaceId:self.filterRaceId
                                                                                       filterCategoryId:self.filterCategoryId
                                                                                          filterStateId:filterStateId
                                                                                             filterName:self.filterName
                                                                                               distance:self.filterDistance
                                                                                                success:^(id responseObject)
                                   {
                                       NSMutableArray<WDProduct *> *arrayLoadProducts = [NSMutableArray<WDProduct *> array];
                                       for (NSDictionary *each in responseObject) {
                                           WDProduct *product = [[WDProduct alloc] initWithDictionary:each];
                                           [arrayLoadProducts addObject:product];
                                       }
                                       self.arrayProducts = [arrayLoadProducts copy];
                                       [arrayLoadProducts removeAllObjects];
                                       if([self.delegate respondsToSelector:@selector(stopUploadProducts)])
                                           [self.delegate stopUploadProducts];
                                       if([self.delegate respondsToSelector:@selector(updateListProducts)])
                                           [self.delegate updateListProducts];
                                   } failure:^(NSString *errorDescripcion) {
                                       //TODO
                                   }];
}


#pragma mark change filters

-(void)changeFilteDistance:(NSInteger) distance {
    self.filterDistance = distance;
    [self showMainView];
    [self updateProductsList];
}

-(void)changeFilterCategory:(NSInteger) categoryId {
    self.filterCategoryId = categoryId;
    [self showMainView];
    [self updateProductsList];
}


-(void)changeFilterRaces:(NSInteger) raceId {
    self.filterRaceId = raceId;
    [self showMainView];
    [self updateProductsList];
}

- (void)changeNameSearch:(NSString*)filterName {
    self.filterName = filterName;
    [self showMainView];
    [self updateProductsList];
}
#pragma mark products

- (NSInteger)countProductsList {
    return self.arrayProducts.count;
}

- (NSURL*)urlImagePresentationFromIndexPath:(NSIndexPath*)indexPath {
    return [self.arrayProducts objectAtIndex:indexPath.row].urlImagePresentation;
}

- (NSURL*)urlImagePresentationThumbnailFromIndexPath:(NSIndexPath*)indexPath {
    return [self.arrayProducts objectAtIndex:indexPath.row].urlImageThumbnailPresentation;
}

- (NSString*)textDescriptionPresentationFromIndexPath:(NSIndexPath*)indexPath {
    return [self.arrayProducts objectAtIndex:indexPath.row].name;
}

- (NSString*)textPricePresentationFromIndexPath:(NSIndexPath*)indexPath {
    return [self.arrayProducts objectAtIndex:indexPath.row].pricePresentation;
}

-(void)selectProduct:(NSIndexPath*)indexPath {
    WDProduct *product = [self.arrayProducts objectAtIndex:indexPath.row];
    WDProductViewModel *productViewModel = [[WDProductViewModel alloc] initWithProduct:product];
    if([self.delegate respondsToSelector:@selector(showProductviewModel:)])
        [self.delegate showProductviewModel:productViewModel];
}

- (void)addNewItemWithImage:(UIImage*)image {
    WDAddItemViewModel *addItemViewModel = [[WDAddItemViewModel alloc] initWithMainViewModel:self
                                                                                       image:image
                                                                             arrayCategories:self.rightViewModel.arrayCategory
                                                                                  arrayRaces:self.rightViewModel.arrayRace];
    addItemViewModel.latitude = self.currentLocation.latitude;
    addItemViewModel.longitude = self.currentLocation.longitude;
    if([self.delegate respondsToSelector:@selector(showAddItem:)])
        [self.delegate showAddItem:addItemViewModel];
}

- (void)addNewItem {
    WDAddItemViewModel *addItemViewModel = [[WDAddItemViewModel alloc] initWithMainViewModel:self
                                                                             arrayCategories:self.rightViewModel.arrayCategory
                                                                                  arrayRaces:self.rightViewModel.arrayRace];
    addItemViewModel.latitude = self.currentLocation.latitude;
    addItemViewModel.longitude = self.currentLocation.longitude;
    if([self.delegate respondsToSelector:@selector(showAddItem:)])
        [self.delegate showAddItem:addItemViewModel];
}
#pragma mark alert

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        NSURL *settingsURL = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        [[UIApplication sharedApplication] openURL:settingsURL];
    }
}

#pragma mark account

- (void)showAccountUserOrCreateAccount {
    if([WDHTTPClient sharedWDHTTPClient].isAutentification) {
        WDAccountViewModel *accountViewModel = [[WDAccountViewModel alloc] initWithUser:self.currentUser
                                                                          mainViewModel:self];
        if([self.delegate respondsToSelector:@selector(showAccount:)])
            [self.delegate showAccount:accountViewModel];
    } else {
        WDStartedViewModels *startedViewModel  = [[WDStartedViewModels alloc] initWithMainViewModel:self];
        if([self.delegate respondsToSelector:@selector(showStartAccount:)])
            [self.delegate showStartAccount:startedViewModel];
    }
}

#pragma mark change View

- (void)showMainView {
    if([self.delegate respondsToSelector:@selector(showMainViewHideMenus)])
        [self.delegate showMainViewHideMenus];
}

- (void)updateUserAccountNew {
    if([self.delegate respondsToSelector:@selector(showMainViewHideMenus)])
        [self.delegate showMainViewHideMenus];
    [[WDHTTPClient sharedWDHTTPClient] getCurrentUserSuccess:^(id responseObject) {
        WDUser *user = [[WDUser alloc] initWithDictionary:responseObject];
        self.currentUser = user;
        if([self.delegate respondsToSelector:@selector(updateCurrentUser)])
            [self.delegate updateCurrentUser];
    } failure:^(NSString *errorDescripcion) {
        [self removeUserAccount];
    }];
}

- (void)updateUserAccountNewWithUser:(WDUser*)user {
    if([self.delegate respondsToSelector:@selector(showMainViewHideMenus)])
        [self.delegate showMainViewHideMenus];
    self.currentUser = user;
    if([self.delegate respondsToSelector:@selector(updateCurrentUser)])
        [self.delegate updateCurrentUser];
}

- (void)removeUserAccount {
    [[WDHTTPClient sharedWDHTTPClient] removeAuthorization];
    self.currentUser = nil;
    if([self.delegate respondsToSelector:@selector(showMainViewHideMenus)])
        [self.delegate showMainViewHideMenus];
    if([self.delegate respondsToSelector:@selector(updateCurrentUser)])
        [self.delegate updateCurrentUser];
}

- (void)changeCalculateDistance:(NSIndexPath*)indexPath{
    if (!CLLocationCoordinate2DIsValid(self.currentLocation)) {
        if ([self.delegate respondsToSelector:@selector(changeDistanceText:)]) {
            [self.delegate changeDistanceText:@"Not have current location"];
        }
    } else {
        if(indexPath.row >= self.arrayProducts.count) {
            return;
        }
        WDProduct *product = [self.arrayProducts objectAtIndex:indexPath.row];
        CLLocation *productLocation = [[CLLocation alloc] initWithLatitude:[product.latitude doubleValue] longitude:[product.longitude doubleValue]];
        CLLocationDistance meters = [self.locationManager.location distanceFromLocation:productLocation];
        if ([self.delegate respondsToSelector:@selector(changeDistanceText:)]) {
            [self.delegate changeDistanceText:[NSString stringWithFormat:@"%.02f mi from you",meters/1000]];
        }
    }
}

#pragma mark - Delegate

#pragma mark CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations {
    [self.locationManager stopUpdatingLocation];
    CLLocation* location = [locations lastObject];
    self.currentLocation = location.coordinate;
    [self updateProductsList];
}


@end
