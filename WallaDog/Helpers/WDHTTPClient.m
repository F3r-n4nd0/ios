//
//  WDHTTPClient.m
//  WallaDog
//
//  Created by Fernando Luna on 12/22/15.
//  Copyright © 2015 Dancing Queen. All rights reserved.
//
//@import AFOAuth2Manager;

#import "WDHTTPClient.h"
#import <CoreLocation/CLLocation.h>

@implementation WDHTTPClient

+ (WDHTTPClient *)sharedWDHTTPClient
{
    static WDHTTPClient *_sharedWeatherHTTPClient = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedWeatherHTTPClient = [[self alloc] initWithBaseURL:[NSURL URLWithString:@"http://api.walladog.com/"]];
        
    });
    
    return _sharedWeatherHTTPClient;
}

- (instancetype)initWithBaseURL:(NSURL *)url
{
    self = [super initWithBaseURL:url];
    
    if (self) {
//        AFOAuthCredential *credential = [[AFOAuthCredential alloc] initWithOAuthToken:@"TTRevzbqGiJsaXOHX5twNI8mBwEStT" tokenType:@"Bearer"];
//        //        [AFOAuthCredential retrieveCredentialWithIdentifier:@"serviceProviderIdentifier"];
//        if(credential != nil) {
//            [self.requestSerializer setAuthorizationHeaderFieldWithCredential:credential];
//        }
        self.responseSerializer = [AFJSONResponseSerializer serializer];
        self.requestSerializer = [AFJSONRequestSerializer serializer];
    }
    
    return self;
}

-(NSURLSessionDataTask *) loadProductsWithLocationCoordinate:(CLLocationCoordinate2D) locationCoordinate
                                               filterRaceId:(NSInteger) filterRaceId
                                           filterCategoryId:(NSInteger) filterCategoryId
                                              filterStateId:(NSInteger) filterStateId
                                                 filterName:(NSString*) filterName
                                                    success:(void (^)(id responseObject))success
                                                    failure:(void (^)(NSString *errorDescripcion))failure {
    
    NSMutableDictionary *parametersFilters = [NSMutableDictionary dictionary];
    
    if (![filterName isEqualToString:@""])
        [parametersFilters setObject:filterName forKey:@"name"];
    
    if (CLLocationCoordinate2DIsValid(locationCoordinate)
        && locationCoordinate.latitude != 0
        && locationCoordinate.longitude != 0) {
        [parametersFilters setObject:@(locationCoordinate.latitude) forKey:@"lat"];
        [parametersFilters setObject:@(locationCoordinate.longitude) forKey:@"lon"];
    }
    if (filterCategoryId != 0)
        [parametersFilters setObject:@(filterCategoryId) forKey:@"category"];
    
    if (filterRaceId != 0)
        [parametersFilters setObject:@(filterRaceId) forKey:@"race"];
    
    if (filterStateId != 0)
        [parametersFilters setObject:@(filterStateId) forKey:@"state"];
    
    [parametersFilters setObject:@(20) forKey:@"limit"];
    [parametersFilters setObject:@(0) forKey:@"offset"];
    
    return [self GET:@"/api/1.0/products/" parameters:parametersFilters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success([responseObject objectForKey:@"results"]);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        id response = [error.userInfo objectForKey:AFNetworkingOperationFailingURLResponseDataErrorKey];
        NSString *myStringError = [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding];
        failure(myStringError);
    }];
}

-(void) getCategoriesSuccess:(void (^)(id responseObject))success
                     failure:(void (^)(NSString *errorDescripcion))failure {
    
    NSMutableDictionary *parametersFilters = [NSMutableDictionary dictionary];
    [parametersFilters setObject:@(20) forKey:@"limit"];
    [parametersFilters setObject:@(0) forKey:@"offset"];
    
    [self GET:@"/api/1.0/categories/" parameters:parametersFilters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success([responseObject objectForKey:@"results"]);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        id response = [error.userInfo objectForKey:AFNetworkingOperationFailingURLResponseDataErrorKey];
        NSString *myStringError = [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding];
        failure(myStringError);
    }];
}

//- (void)updateWeatherAtLocation:(CLLocation *)location forNumberOfDays:(NSUInteger)number
//{
//    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
//
//    parameters[@"num_of_days"] = @(number);
//    parameters[@"q"] = [NSString stringWithFormat:@"%f,%f",location.coordinate.latitude,location.coordinate.longitude];
//    parameters[@"format"] = @"json";
//    parameters[@"key"] = @"WorldWeatherOnlineAPIKey";
//
//    [self GET:@"weather.ashx" parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
//
//    } success:^(NSURLSessionDataTask *task, id responseObject) {
//        if ([self.delegate respondsToSelector:@selector(weatherHTTPClient:didUpdateWithWeather:)]) {
//            [self.delegate weatherHTTPClient:self didUpdateWithWeather:responseObject];
//        }
//    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//        if ([self.delegate respondsToSelector:@selector(weatherHTTPClient:didFailWithError:)]) {
//            [self.delegate weatherHTTPClient:self didFailWithError:error];
//        }
//    }];
//}

//- (void)testAuterization {
//    AFOAuth2Manager *OAuth2Manager =
//    [[AFOAuth2Manager alloc] initWithBaseURL:[NSURL URLWithString:@"http://api.walladog.com:8000/"]
//                                    clientID:@"uEAoxVEYOVmpg4Z8IAyCCEItlXO8Cf4G7RSu647d"
//                                      secret:@"Zc0JGu5pVUt7zNxrhQaCvit6ydr4WxMVI4nXluF9GBWgJV0rbUcR5y2uBZl3TgmLYryashJREp9AiIkbfRUVv5Cdd3n6ZX4Va3fI2cmvMwcgWRFYnrp7K8ZtwkopXrhV"];
//
//    [OAuth2Manager authenticateUsingOAuthWithURLString:@"/o/token/"
//                                              username:@"fluna"
//                                              password:@"2492357"
//                                                 scope:@"read"
//                                               success:^(AFOAuthCredential *credential) {
//                                                   [AFOAuthCredential storeCredential:credential
//                                                                       withIdentifier:@"serviceProviderIdentifier"];
//                                                   NSLog(@"Token: %@", credential.accessToken);
//                                               }
//                                               failure:^(NSError *error) {
//                                                   NSLog(@"Error: %@", error);
//                                               }];
//
//}

//- (void)test {
//    NSDictionary *parameters = @{
//        @"name": @"name test",
//        @"latitude" : @(-63.179393),
//        @"longitude" : @(-17.782488),
//        @"race": @(1),
//        @"state": @(1),
//        @"category": @(1)
//    };
//    [self POST:@"/api/1.0/products/" parameters:parameters  constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//        UIImage *image = [UIImage imageNamed:@"ImageUserIcon"];
//        [formData appendPartWithFileData:UIImagePNGRepresentation(image) name:@"upload_image" fileName:@"XXXXXXXXX.jpg" mimeType:@"image/jpeg"];
//        [formData appendPartWithFileData:UIImagePNGRepresentation(image) name:@"upload_image" fileName:@"YYYYYYYYY.jpg" mimeType:@"image/jpeg"];
//    } progress:^(NSProgress * _Nonnull uploadProgress) {
//
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        id response = [error.userInfo objectForKey:AFNetworkingOperationFailingURLResponseDataErrorKey];
//        NSString *myStringError = [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding];
//        NSLog(@"ERROR SERVER : %@", myStringError);
//    }];
//}
//
//-(NSString*) bv_jsonStringWithPrettyPrint:(BOOL) prettyPrint {
//    NSError *error;
//    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self
//                                                       options:(NSJSONWritingOptions) (prettyPrint ? NSJSONWritingPrettyPrinted : 0)
//                                                         error:&error];
//
//    if (! jsonData) {
//        NSLog(@"bv_jsonStringWithPrettyPrint: error: %@", error.localizedDescription);
//        return @"[]";
//    } else {
//        return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//    }
//}

@end
