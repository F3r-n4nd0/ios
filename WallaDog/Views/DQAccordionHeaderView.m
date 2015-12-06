//
//  DQAccordionHeaderView.m
//  WallaDog
//
//  Created by Fernando Luna on 12/6/15.
//  Copyright © 2015 Dancing Queen. All rights reserved.
//

#import "DQAccordionHeaderView.h"

@interface DQAccordionHeaderView ()

@property (weak, nonatomic) IBOutlet UIImageView *imageViewIcon;
@property (weak, nonatomic) IBOutlet UILabel *labelMenu;


@end


@implementation DQAccordionHeaderView

+ (NSString*)reuseIdentifier {
    return @"DQAccordionHeaderView";
}

-(void)setImage:(UIImage*)image
           text:(NSString*)text {
    self.imageViewIcon.image = image;
    self.labelMenu.text = text;
}

@end
