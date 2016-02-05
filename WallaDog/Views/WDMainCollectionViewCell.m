//
//  WDMainCollectionViewCell.m
//  WallaDog
//
//  Created by Fernando Luna on 12/20/15.
//  Copyright © 2015 Dancing Queen. All rights reserved.
//

#import "WDMainCollectionViewCell.h"

@interface WDMainCollectionViewCell()

@property (weak, nonatomic) IBOutlet UIView *viewItem;


@end

@implementation WDMainCollectionViewCell


+ (NSString*)reuseIdentifier {
  return @"WDMainCollectionViewCell";
}

- (void)awakeFromNib {
    
    [self.viewItem.layer setCornerRadius:10.0];
    
}

@end
