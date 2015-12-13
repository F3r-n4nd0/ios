//
//  WDMenuTableViewCell.m
//  WallaDog
//
//  Created by Fernando Luna on 12/6/15.
//  Copyright © 2015 Dancing Queen. All rights reserved.
//

#import "WDMenuTableViewCell.h"

@implementation WDMenuTableViewCell

+ (NSString*)reuseIdentifier {
    return @"WDMenuTableViewCell";
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
