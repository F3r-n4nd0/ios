//
//  WDProductViewModel.h
//  WallaDog
//
//  Created by Fernando Luna on 1/26/16.
//  Copyright © 2016 Dancing Queen. All rights reserved.
//
@import Foundation;

@class WDProduct;

@interface WDProductViewModel : NSObject

- (instancetype)initWithProduct:(WDProduct*)product;

- (NSInteger)countImages;
- (NSURL*)urlimageFromIndex:(NSInteger)index;
- (NSString*)textTitle;
- (NSString*)textDetail;
- (NSString*)textPrice;
- (NSURL*)urlAvatarSellerThumbnail;
- (NSString*)textSellerDescripcion;
- (double)doubleLatitude;
- (double)doubleLongitude;
- (void)contactSellerComplitionBLock:(void(^)())complitionBLock
                    complitionError:(void(^)(NSString* error))complitionError;
- (BOOL)isEnableContact;
- (NSString*)textState;

@end
