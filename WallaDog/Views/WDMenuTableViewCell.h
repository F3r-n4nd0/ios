//
//  WDMenuTableViewCell.h
//  WallaDog
//
//  Created by Fernando Luna on 12/6/15.
//  Copyright © 2015 Dancing Queen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WDMenuTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *labelDescription;

+ (NSString*)reuseIdentifier;

@end
