//
//  WDHTTPClient.m
//  WallaDog
//
//  Created by Fernando Luna on 12/22/15.
//  Copyright © 2015 Dancing Queen. All rights reserved.
//
//#import <AFOAuth2Manager/AFOAuth2Manager.h>
//#import <AFOAuth2Manager/AFHTTPRequestSerializer+OAuth2.h>

@import AFOAuth2Manager;

#import "WDHTTPClient.h"

#define URL_BASE_WALLADOG @"http://api.walladog.com/"
#define CLIENT_ID_WALLADOG @"uEAoxVEYOVmpg4Z8IAyCCEItlXO8Cf4G7RSu647d"
#define SECRET_WALLADOG @"Zc0JGu5pVUt7zNxrhQaCvit6ydr4WxMVI4nXluF9GBWgJV0rbUcR5y2uBZl3TgmLYryashJREp9AiIkbfRUVv5Cdd3n6ZX4Va3fI2cmvMwcgWRFYnrp7K8ZtwkopXrhV"
#define KEY_SAVE_TOKEN @"KEY_SAVE_TOKEN"


@interface WDHTTPClient ()

@property(nonatomic) BOOL isAutentification;

@end


@implementation WDHTTPClient

+ (WDHTTPClient *)sharedWDHTTPClient
{
    static WDHTTPClient *_sharedWeatherHTTPClient = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedWeatherHTTPClient = [[self alloc] initWithBaseURL:[NSURL URLWithString:URL_BASE_WALLADOG]];
    });
    
    return _sharedWeatherHTTPClient;
}

- (instancetype)initWithBaseURL:(NSURL *)url
{
    if (self = [super initWithBaseURL:url]) {
        _isAutentification = NO;
        [self configureAFNetworking];
        [self loadAuthentication];
    }
    
    return self;
}

- (void)configureAFNetworking {
    self.responseSerializer = [AFJSONResponseSerializer serializer];
    self.requestSerializer = [AFJSONRequestSerializer serializer];
}

- (void)loadAuthentication {
    AFOAuthCredential *credential = [AFOAuthCredential retrieveCredentialWithIdentifier:KEY_SAVE_TOKEN];
    if(credential != nil) {
        [self.requestSerializer setAuthorizationHeaderFieldWithCredential:credential];
        self.isAutentification = YES;
    }
}

-(NSURLSessionDataTask *) loadProductsWithLocationCoordinate:(CLLocationCoordinate2D) locationCoordinate
                                                filterRaceId:(NSInteger) filterRaceId
                                            filterCategoryId:(NSInteger) filterCategoryId
                                               filterStateId:(NSInteger) filterStateId
                                                  filterName:(NSString*) filterName
                                                    distance:(NSInteger) distance
                                                     success:(void (^)(id responseObject))success
                                                     failure:(void (^)(NSString *errorDescripcion))failure {
    
    NSMutableDictionary *parametersFilters = [NSMutableDictionary dictionary];
    
    if (filterName && ![filterName isEqualToString:@""])
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
    if (distance != 0)
        [parametersFilters setObject:@(distance) forKey:@"distance"];
    
    
    [parametersFilters setObject:@(20) forKey:@"limit"];
    [parametersFilters setObject:@(0) forKey:@"offset"];
    
    return [self GET:@"/api/1.0/products/" parameters:parametersFilters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success([responseObject objectForKey:@"results"]);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        id response = [error.userInfo objectForKey:AFNetworkingOperationFailingURLResponseDataErrorKey];
        NSString *myStringError = [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding];
        NSRange stringRange = {0, MIN([myStringError length], 20)};
        stringRange = [myStringError rangeOfComposedCharacterSequencesForRange:stringRange];
        NSString *shortString = [myStringError substringWithRange:stringRange];
        failure(shortString);
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
        NSRange stringRange = {0, MIN([myStringError length], 20)};
        stringRange = [myStringError rangeOfComposedCharacterSequencesForRange:stringRange];
        NSString *shortString = [myStringError substringWithRange:stringRange];
        failure(shortString);
    }];
}

-(void) getRacesSuccess:(void (^)(id responseObject))success
                     failure:(void (^)(NSString *errorDescripcion))failure {
    
    NSMutableDictionary *parametersFilters = [NSMutableDictionary dictionary];
    [parametersFilters setObject:@(20) forKey:@"limit"];
    [parametersFilters setObject:@(0) forKey:@"offset"];
    
    [self GET:@"/api/1.0/races/" parameters:parametersFilters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success([responseObject objectForKey:@"results"]);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        id response = [error.userInfo objectForKey:AFNetworkingOperationFailingURLResponseDataErrorKey];
        NSString *myStringError = [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding];
        NSRange stringRange = {0, MIN([myStringError length], 20)};
        stringRange = [myStringError rangeOfComposedCharacterSequencesForRange:stringRange];
        NSString *shortString = [myStringError substringWithRange:stringRange];
        failure(shortString);
    }];
}

-(void) getCurrentUserSuccess:(void (^)(id responseObject))success
                      failure:(void (^)(NSString *errorDescripcion))failure {
    
    
    [self GET:@"/api/1.0/logins/" parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        id response = [error.userInfo objectForKey:AFNetworkingOperationFailingURLResponseDataErrorKey];
        NSString *myStringError = [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding];
        NSRange stringRange = {0, MIN([myStringError length], 20)};
        stringRange = [myStringError rangeOfComposedCharacterSequencesForRange:stringRange];
        NSString *shortString = [myStringError substringWithRange:stringRange];
        failure(shortString);
    }];
}

-(void) signUpWithUserName:(NSString*)userName
                     email:(NSString*)email
                  password:(NSString*)password
                   success:(void (^)(id responseObject))success
                   failure:(void (^)(NSString *errorDescripcion))failure {
    
    NSDictionary *parameters = @{@"username":userName,
                                 @"email":email,
                                 @"password":password};
    
    [self POST:@"/api/1.0/users/" parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        id response = [error.userInfo objectForKey:AFNetworkingOperationFailingURLResponseDataErrorKey];
        NSString *myStringError = [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding];
        NSRange stringRange = {0, MIN([myStringError length], 20)};
        stringRange = [myStringError rangeOfComposedCharacterSequencesForRange:stringRange];
        NSString *shortString = [myStringError substringWithRange:stringRange];
        failure(shortString);
    }];
}

- (void)transactionProductId:(NSInteger)productId
                   success:(void (^)())success
                   failure:(void (^)(NSString *errorDescripcion))failure {
    
    NSDictionary *parameters = @{@"product":@(productId)};
    
    [self POST:@"/api/1.0/transactions/" parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        id response = [error.userInfo objectForKey:AFNetworkingOperationFailingURLResponseDataErrorKey];
        NSString *myStringError = [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding];
        NSRange stringRange = {0, MIN([myStringError length], 20)};
        stringRange = [myStringError rangeOfComposedCharacterSequencesForRange:stringRange];
        NSString *shortString = [myStringError substringWithRange:stringRange];
        failure(shortString);
    }];
}


- (void)loginAndobtainAuthorizationTokenWithUserName:(NSString*)userName
                                            password:(NSString*)password
                                     complitionBLock:(void(^)())complitionBLock
                                     complitionError:(void(^)(NSString* error))complitionError {
    
    AFOAuth2Manager *OAuth2Manager =
    [[AFOAuth2Manager alloc] initWithBaseURL:[NSURL URLWithString:URL_BASE_WALLADOG]
                                    clientID:CLIENT_ID_WALLADOG
                                      secret:SECRET_WALLADOG];
    
    [OAuth2Manager authenticateUsingOAuthWithURLString:@"/o/token/"
                                              username:userName
                                              password:password
                                                 scope:@"read write"
                                               success:^(AFOAuthCredential *credential) {
                                                   [AFOAuthCredential storeCredential:credential
                                                                       withIdentifier:KEY_SAVE_TOKEN];
                                                   [self.requestSerializer setAuthorizationHeaderFieldWithCredential:credential];
                                                   self.isAutentification = YES;
                                                   complitionBLock();
                                               }
                                               failure:^(NSError *error) {
                                                   id response = [error.userInfo objectForKey:AFNetworkingOperationFailingURLResponseDataErrorKey];
                                                   NSString *myStringError = [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding];
                                                   complitionError(myStringError);
                                               }];
    
}

- (void)updateUserWithUserId:(NSInteger)userId
                   firstName:(NSString*)firstName
                    lastName:(NSString*)lastName
                       email:(NSString*)email
                   imageData:(NSData*)imageData
                   avatarUrl:(NSString*)avatarUrl
                     success:(void (^)())success
                     failure:(void (^)(NSString *errorDescripcion))failure {
    
    
    NSMutableDictionary *parametersFilters = [NSMutableDictionary dictionary];
    
    if (firstName && ![firstName isEqualToString:@""])
        [parametersFilters setObject:firstName forKey:@"first_name"];
    if (lastName && ![lastName isEqualToString:@""])
        [parametersFilters setObject:lastName forKey:@"last_name"];
    if (email && ![email isEqualToString:@""])
        [parametersFilters setObject:email forKey:@"email"];
    if(imageData)
        [parametersFilters setObject:avatarUrl forKey:@"avatar_url"];
    NSString *url = [NSString stringWithFormat:@"/api/1.0/users/%ld/",userId];
    

    [self PUT:url parameters:parametersFilters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        if(imageData)
           [formData appendPartWithFileData:imageData name:@"upload_image" fileName:@"XXXXXX.jpeg" mimeType:@"image/jpeg"];
    } progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success();
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        id response = [error.userInfo objectForKey:AFNetworkingOperationFailingURLResponseDataErrorKey];
        NSString *myStringError = [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding];
        NSRange stringRange = {0, MIN([myStringError length], 20)};
        stringRange = [myStringError rangeOfComposedCharacterSequencesForRange:stringRange];
        NSString *shortString = [myStringError substringWithRange:stringRange];
        failure(shortString);
    }];
}


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
                     failure:(void (^)(NSString *errorDescripcion))failure {
    
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    if (title && ![title isEqualToString:@""])
        [parameters setObject:title forKey:@"name"];
    if (description && ![description isEqualToString:@""])
        [parameters setObject:description forKey:@"description"];
    if (categoryId > 0)
        [parameters setObject:[NSNumber numberWithInteger:categoryId] forKey:@"category"];
    if (raceId > 0)
        [parameters setObject:[NSNumber numberWithInteger:raceId] forKey:@"race"];
    if (stateId > 0)
        [parameters setObject:[NSNumber numberWithInteger:stateId] forKey:@"state"];
    if (latitude != 0)
        [parameters setObject:[NSNumber numberWithDouble:latitude] forKey:@"latitude"];
    if (longitude != 0)
        [parameters setObject:[NSNumber numberWithDouble:longitude] forKey:@"longitude"];
    if (price != 0)
        [parameters setObject:price forKey:@"price"];
    
    
    [self POST:@"/api/1.0/products/" parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        if(image1)
            [formData appendPartWithFileData:image1 name:@"upload_image" fileName:@"IMG_1XXXXXX.jpeg" mimeType:@"image/jpeg"];
        if(image2)
            [formData appendPartWithFileData:image2 name:@"upload_image" fileName:@"IMG_2XXXXXX.jpeg" mimeType:@"image/jpeg"];
        if(image3)
            [formData appendPartWithFileData:image3 name:@"upload_image" fileName:@"IMG_3XXXXXX.jpeg" mimeType:@"image/jpeg"];
        if(image4)
            [formData appendPartWithFileData:image4 name:@"upload_image" fileName:@"IMG_4XXXXXX.jpeg" mimeType:@"image/jpeg"];
    } progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success();
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        id response = [error.userInfo objectForKey:AFNetworkingOperationFailingURLResponseDataErrorKey];
        NSString *myStringError = [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding];
        NSRange stringRange = {0, MIN([myStringError length], 20)};
        stringRange = [myStringError rangeOfComposedCharacterSequencesForRange:stringRange];
        NSString *shortString = [myStringError substringWithRange:stringRange];
        failure(shortString);
    }];
}


- (void)removeAuthorization {
    self.isAutentification = NO;
    [AFOAuthCredential deleteCredentialWithIdentifier:KEY_SAVE_TOKEN];
}



#pragma mark - add method to AFnetworking


- (NSURLSessionDataTask *)PUT:(NSString *)URLString
                    parameters:(id)parameters
     constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
                      progress:(nullable void (^)(NSProgress * _Nonnull))uploadProgress
                       success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                       failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    NSError *serializationError = nil;
    NSMutableURLRequest *request = [self.requestSerializer multipartFormRequestWithMethod:@"PUT" URLString:[[NSURL URLWithString:URLString relativeToURL:self.baseURL] absoluteString] parameters:parameters constructingBodyWithBlock:block error:&serializationError];
    if (serializationError) {
        if (failure) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wgnu"
            dispatch_async(self.completionQueue ?: dispatch_get_main_queue(), ^{
                failure(nil, serializationError);
            });
#pragma clang diagnostic pop
        }
        
        return nil;
    }
    
    __block NSURLSessionDataTask *task = [self uploadTaskWithStreamedRequest:request progress:uploadProgress completionHandler:^(NSURLResponse * __unused response, id responseObject, NSError *error) {
        if (error) {
            if (failure) {
                failure(task, error);
            }
        } else {
            if (success) {
                success(task, responseObject);
            }
        }
    }];
    
    [task resume];
    
    return task;
}


@end
