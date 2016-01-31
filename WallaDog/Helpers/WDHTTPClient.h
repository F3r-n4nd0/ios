//
//  WDHTTPClient.h
//  WallaDog
//
//  Created by Fernando Luna on 12/22/15.
//  Copyright © 2015 Dancing Queen. All rights reserved.
//
@import CoreLocation;
@import AFNetworking;

@class CLLocation;
@class WDHTTPClient;

@interface WDHTTPClient : AFHTTPSessionManager

@property(readonly) BOOL isAutentification;

+ (WDHTTPClient *)sharedWDHTTPClient;

- (instancetype)initWithBaseURL:(NSURL *)url;
- (NSURLSessionDataTask *) loadProductsWithLocationCoordinate:(CLLocationCoordinate2D) locationCoordinate
                                                filterRaceId:(NSInteger) filterRaceId
                                            filterCategoryId:(NSInteger) filterCategoryId
                                               filterStateId:(NSInteger) filterStateId
                                                  filterName:(NSString*) filterName
                                                     success:(void (^)(id responseObject))success
                                                     failure:(void (^)(NSString *errorDescripcion))failure;
- (void)getCategoriesSuccess:(void (^)(id responseObject))success
                     failure:(void (^)(NSString *errorDescripcion))failure;
- (void)signUpWithUserName:(NSString*)userName
                     email:(NSString*)email
                  password:(NSString*)password
                   success:(void (^)(id responseObject))success
                   failure:(void (^)(NSString *errorDescripcion))failure;
- (void)loginAndobtainAuthorizationTokenWithUserName:(NSString*)userName
                                            password:(NSString*)password
                                     complitionBLock:(void(^)())complitionBLock
                                     complitionError:(void(^)(NSString* error))complitionError;
- (void)getCurrentUserSuccess:(void (^)(id responseObject))success
                      failure:(void (^)(NSString *errorDescripcion))failure;
@end
