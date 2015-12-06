//
//  DQMenuTableViewCell.m
//  WallaDog
//
//  Created by Fernando Luna on 12/6/15.
//  Copyright © 2015 Dancing Queen. All rights reserved.
//

#import "DQMenuTableViewCell.h"

@implementation DQMenuTableViewCell

+ (NSString*)reuseIdentifier {
    return @"DQMenuTableViewCell";
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
