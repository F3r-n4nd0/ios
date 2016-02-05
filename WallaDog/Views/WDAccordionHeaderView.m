//
//  WDAccordionHeaderView.m
//  WallaDog
//
//  Created by Fernando Luna on 12/6/15.
//  Copyright © 2015 Dancing Queen. All rights reserved.
//

#import "WDAccordionHeaderView.h"

@interface WDAccordionHeaderView ()

@property (weak, nonatomic) IBOutlet UIImageView *imageViewIcon;
@property (weak, nonatomic) IBOutlet UILabel *labelMenu;


@end


@implementation WDAccordionHeaderView

+ (NSString*)reuseIdentifier {
    return @"WDAccordionHeaderView";
}

-(void)setImage:(UIImage*)image
           text:(NSString*)text {
    self.imageViewIcon.image = image;
    self.labelMenu.text = text;
}

@end
