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
                                                     distance:(NSInteger) distance
                                                     success:(void (^)(id responseObject))success
                                                     failure:(void (^)(NSString *errorDescripcion))failure;
- (void)getCategoriesSuccess:(void (^)(id responseObject))success
                     failure:(void (^)(NSString *errorDescripcion))failure;
-(void) getRacesSuccess:(void (^)(id responseObject))success
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
- (void)updateUserWithUserId:(NSInteger)userId
                   firstName:(NSString*)firstName
                    lastName:(NSString*)lastName
                       email:(NSString*)email
                   imageData:(NSData*)imageData
                   avatarUrl:(NSString*)avatarUrl
                     success:(void (^)())success
                     failure:(void (^)(NSString *errorDescripcion))failure;
- (void)savenewItemWithTitle:(NSString*)title
                 description:(NSString*)description
                  categoryId:(NSInteger)categoryId
                      raceId:(NSInteger)raceId
                     stateId:(NSInteger)stateId
                    latitude:(double)latitude
                   longitude:(double)longitude
                       price:(NSString*)price
                      image1:(NSData*)image1
                      image2:(NSData*)image2
                      image3:(NSData*)image3
                      image4:(NSData*)image4
                     success:(void (^)())success
                     failure:(void (^)(NSString *errorDescripcion))failure;
- (void)transactionProductId:(NSInteger)productId
                     success:(void (^)())success
                     failure:(void (^)(NSString *errorDescripcion))failure;
- (void)removeAuthorization;
@end
