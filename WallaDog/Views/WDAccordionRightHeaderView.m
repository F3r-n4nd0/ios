//
//  WDAccordionRightHeaderView.m
//  WallaDog
//
//  Created by Fernando Luna on 2/3/16.
//  Copyright © 2016 Dancing Queen. All rights reserved.
//

#import "WDAccordionRightHeaderView.h"

@interface WDAccordionRightHeaderView ()

@property (weak, nonatomic) IBOutlet UIImageView *imageViewIcon;
@property (weak, nonatomic) IBOutlet UILabel *labelMenu;


@end

@implementation WDAccordionRightHeaderView

+ (NSString*)reuseIdentifier {
    return @"WDAccordionRightHeaderView";
}

-(void)setImage:(UIImage*)image
           text:(NSString*)text {
    self.imageViewIcon.image = image;
    self.labelMenu.text = text;
}
@end
