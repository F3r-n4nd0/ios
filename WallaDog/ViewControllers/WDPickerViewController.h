//
//  WDPickerViewController.h
//  WallaDog
//
//  Created by Fernando Luna on 2/5/16.
//  Copyright © 2016 Dancing Queen. All rights reserved.
//

@import  UIKit;

@protocol WDPickerViewControllerDelegate <NSObject>

-(void)selectData:(NSInteger)row key:(NSString*)key;

@end

@interface WDPickerViewController : UIViewController


- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithList:(NSArray<NSString *> *)list
                         key:(NSString*)key
                    delegate:(id<WDPickerViewControllerDelegate>)delegate;

@property (nonatomic, weak) id<WDPickerViewControllerDelegate> delegate;

@end
