//
//  WDMainCollectionViewCell.h
//  WallaDog
//
//  Created by Fernando Luna on 12/20/15.
//  Copyright © 2015 Dancing Queen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WDMainCollectionViewCell : UICollectionViewCell

+ (NSString*)reuseIdentifier;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *labelDescription;
@property (weak, nonatomic) IBOutlet UILabel *labelPrice;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;


@end
