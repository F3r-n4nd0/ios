//
//  WDProductViewModel.m
//  WallaDog
//
//  Created by Fernando Luna on 1/26/16.
//  Copyright © 2016 Dancing Queen. All rights reserved.
//

#import "WDProductViewModel.h"
#import "WDProduct.h"

@interface WDProductViewModel()

@property (nonatomic, strong) WDProduct *product;

@end


@implementation WDProductViewModel

#pragma mark - Life Cycle

- (instancetype)initWithProduct:(WDProduct*)product {
    if(self = [super init]) {
        _product = product;
    }
    return self;
}

#pragma mark - publioc methods

- (NSInteger)countImages {
    if(!self.product)
        return 0;
    return self.product.images.count;
}

- (NSURL*)urlimageSeller {
    if(!self.product)
        return nil;
    return [self.product urlImageFromIndex:index];
}

- (NSURL*)urlimageFromIndex:(NSInteger)index {
    if(!self.product)
        return nil;
    return [self.product urlImageFromIndex:index];
}

- (NSString*)textTitle {
    if(!self.product)
        return @"";
    return self.product.name;
}

- (NSString*)textDetail {
    if(!self.product)
        return @"";
    return self.product.descriptionField;
}

- (NSString*)textPrice {
    if(!self.product)
        return @"";
    return self.product.pricePresentation;
}

- (NSURL*)urlAvatarSellerThumbnail {
    if(!self.product)
        return nil;
    return self.product.urlSellerAvatarThumbnail;
}

- (NSString*)textSellerDescripcion {
    if(!self.product)
        return nil;
    return self.product.textSellerDescription;
}

- (double)doubleLatitude{
    if(!self.product)
        return 0;
    return [self.product.latitude doubleValue];
}

- (double)doubleLongitude{
    if(!self.product)
        return 0;
    return [self.product.longitude doubleValue];
}


@end
