//
//  WDHTTPClient.h
//  WallaDog
//
//  Created by Fernando Luna on 12/22/15.
//  Copyright © 2015 Dancing Queen. All rights reserved.
//

@import AFNetworking;
@import CoreLocation;

@class CLLocation;
@class WDHTTPClient;


@protocol WDHTTPClientDelegate <NSObject>

//-(void)weatherHTTPClient:(WDHTTPClient *)client didUpdateWithWeather:(id)weather;
//-(void)weatherHTTPClient:(WDHTTPClient *)client didFailWithError:(NSError *)error;

@end

@interface WDHTTPClient : AFHTTPSessionManager

@property (nonatomic, weak) id<WDHTTPClientDelegate>delegate;

+ (WDHTTPClient *)sharedWDHTTPClient;

- (instancetype)initWithBaseURL:(NSURL *)url;

-(NSURLSessionDataTask *) loadProductsWithLocationCoordinate:(CLLocationCoordinate2D) locationCoordinate
                                                filterRaceId:(NSInteger) filterRaceId
                                            filterCategoryId:(NSInteger) filterCategoryId
                                               filterStateId:(NSInteger) filterStateId
                                                  filterName:(NSString*) filterName
                                                     success:(void (^)(id responseObject))success
                                                     failure:(void (^)(NSString *errorDescripcion))failure;

-(void) getCategoriesSuccess:(void (^)(id responseObject))success
                     failure:(void (^)(NSString *errorDescripcion))failure;

@end
