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

- (NSURL*)urlimageFromIndex:(NSInteger)index {
    if(!self.product)
        return nil;
    return [self.product urlImageFromIndex:index];
}

@end
