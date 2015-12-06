//
//  DQAccordionHeaderView.h
//  WallaDog
//
//  Created by Fernando Luna on 12/6/15.
//  Copyright © 2015 Dancing Queen. All rights reserved.
//
#import <FZAccordionTableView/FZAccordionTableView.h>

@interface DQAccordionHeaderView : FZAccordionTableViewHeaderView

+ (NSString*)reuseIdentifier;

-(void)setImage:(UIImage*)image
           text:(NSString*)text;

@end
