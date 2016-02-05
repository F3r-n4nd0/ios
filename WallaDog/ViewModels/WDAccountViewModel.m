//
//  WDAccountViewModel.m
//  WallaDog
//
//  Created by Fernando Luna on 2/3/16.
//  Copyright © 2016 Dancing Queen. All rights reserved.
//
@import SDWebImage;

#import "WDAccountViewModel.h"
#import "WDUser.h"
#import "WDHTTPClient.h"
#import "WDMainViewModel.h"

@interface WDAccountViewModel ()

@property(nonatomic, strong) WDUser *user;
@property(nonatomic, strong) WDMainViewModel *mainViewModel;

@end

@implementation WDAccountViewModel

#pragma mark = Cycle Life

- (instancetype)initWithUser:(WDUser*)user
               mainViewModel:(WDMainViewModel*)mainViewModel {
    if(self = [super init]){
        _user = user;
        _mainViewModel = mainViewModel;
    }
    return self;
}


#pragma mark - public methods

- (NSURL*)urlAvatarlUser {
    return self.user.urlAvatar;
}

- (NSString*)textUserName {
    return self.user.username;
}

- (NSString*)textFirstName {
    return self.user.firstName;
}

- (NSString*)textLastName {
    return self.user.lastName;
}

- (NSString*)textEmail {
    return self.user.email;
}

-(void)saveChangeWithFirstName:(NSString*)firstName
                      lastName:(NSString*)lastName
                         email:(NSString*)email
                         image:(UIImage*)image
                       success:(void (^)())success
                       failure:(void (^)(NSString *errorDescripcion))failure {
    
    NSString *newFirstName = [firstName isEqualToString:self.user.firstName]?nil:firstName;
    NSString *newLasttName = [lastName isEqualToString:self.user.lastName]?nil:lastName;
    NSString *newEmail = [email isEqualToString:self.user.email]?nil:email;
    NSData *imageData;
    NSString *avatarUrl;
    if(image) {
        imageData = [self compresImageUser:image];
        avatarUrl = [NSString stringWithFormat:@"https://s3.amazonaws.com/walladog/%@.jpeg",self.user.username];
    }

    [[WDHTTPClient sharedWDHTTPClient] updateUserWithUserId:self.user.idField
                                                  firstName:newFirstName
                                                   lastName:newLasttName
                                                      email:newEmail
                                                  imageData:imageData
                                                  avatarUrl:avatarUrl
                                                    success:^
     {
         if(newFirstName)
             self.user.firstName = newFirstName;
         if(newLasttName)
             self.user.lastName = newLasttName;
         if(newEmail)
             self.user.email = newEmail;
         if(image) {
             self.user.avatarUrl = avatarUrl;
             self.user.avatarThumbnailUrl = [NSString stringWithFormat:@"https://s3.amazonaws.com/walladog/thumbnails/%@.png",self.user.username];
             [[SDImageCache sharedImageCache] removeImageForKey:self.user.avatarUrl];
             [[SDImageCache sharedImageCache] removeImageForKey:self.user.avatarThumbnailUrl];
         }
         [self.mainViewModel updateUserAccountNewWithUser:self.user];
         success();
     } failure:failure];
}

- (NSData*)compresImageUser:(UIImage*)image {
    CGFloat compression = 1.0f;
    CGFloat maxCompression = 0.1f;
    int maxFileSize = 210 * 1024;
    NSData *imageData = UIImageJPEGRepresentation(image, compression);
    while ([imageData length] > maxFileSize && compression > maxCompression) {
        compression -= 0.1;
        imageData = UIImageJPEGRepresentation(image, compression);
    }
    return imageData;
}

@end
