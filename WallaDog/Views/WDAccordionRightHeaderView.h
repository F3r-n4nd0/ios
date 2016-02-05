//
//  WDAccordionRightHeaderView.h
//  WallaDog
//
//  Created by Fernando Luna on 2/3/16.
//  Copyright © 2016 Dancing Queen. All rights reserved.
//

#import <FZAccordionTableView/FZAccordionTableView.h>

@interface WDAccordionRightHeaderView : FZAccordionTableViewHeaderView

+ (NSString*)reuseIdentifier;

-(void)setImage:(UIImage*)image
           text:(NSString*)text;


@end
