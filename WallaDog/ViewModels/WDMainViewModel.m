//
//  WDMainViewModel.m
//  WallaDog
//
//  Created by Fernando Luna on 1/24/16.
//  Copyright © 2016 Dancing Queen. All rights reserved.
//
@import CoreLocation;
@import SDWebImage;
@import CoreLocation;
@import MapKit;

#import "WDMainViewModel.h"
#import "WDHTTPClient.h"
#import "WDProduct.h"
#import "WDProductViewModel.h"

@interface WDMainViewModel() <CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic) CLLocationCoordinate2D currentLocation;
@property (nonatomic, strong) NSArray<WDProduct *> *arrayProducts;
@property (nonatomic) NSInteger filterCategoryId;
@property (nonatomic, strong) NSURLSessionDataTask *currentLoadProductTask;

@end

@implementation WDMainViewModel

#pragma mark - Life Cycle

- (instancetype) initWithDelgate:(id<WDMainViewModelDelegate>)delegate {
    if(self = [super init]) {
        _arrayProducts = [NSArray array];
        _delegate = delegate;
        [self loadLocationManager];
    }
    return self;
}

- (void)loadLocationManager {
    if (nil == self.locationManager)
        self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
    [self.locationManager startMonitoringSignificantLocationChanges];
}

#pragma mark - public methods

#pragma mark update data

- (void)updateProductsList {
    
    if([self.delegate respondsToSelector:@selector(startUploadProducts)])
        [self.delegate startUploadProducts];
    
    NSInteger filterRaceId = 0;
    NSInteger filterStateId = 0;
    NSString *filterName = @"";
    if(self.currentLoadProductTask)
       [self.currentLoadProductTask cancel];
    self.currentLoadProductTask = [[WDHTTPClient sharedWDHTTPClient] loadProductsWithLocationCoordinate:self.currentLocation
                                                                                           filterRaceId:filterRaceId
                                                                                       filterCategoryId:self.filterCategoryId
                                                                                          filterStateId:filterStateId
                                                                                             filterName:filterName
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

-(void)changeFilterCategory:(NSInteger) categoryId {
    self.filterCategoryId = categoryId;
    [self updateProductsList];
}

#pragma mark collection products

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

#pragma select product

-(void)selectProduct:(NSIndexPath*)indexPath {
    
    WDProduct *product = [self.arrayProducts objectAtIndex:indexPath.row];
    WDProductViewModel *productViewModel = [[WDProductViewModel alloc] initWithProduct:product];
    if([self.delegate respondsToSelector:@selector(showProductviewModel:)])
        [self.delegate showProductviewModel:productViewModel];
    
}


#pragma mark - Delegate

#pragma mark CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations {
    CLLocation* location = [locations lastObject];
    self.currentLocation = location.coordinate;
}


@end
