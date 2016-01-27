//
//  WDAddItemViewController.m
//  WallaDog
//
//  Created by Fernando Luna on 12/21/15.
//  Copyright © 2015 Dancing Queen. All rights reserved.
//

#import "WDAddItemViewController.h"

@interface WDAddItemViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView1;
@property (weak, nonatomic) IBOutlet UIImageView *imageView2;
@property (weak, nonatomic) IBOutlet UIImageView *imageView3;
@property (weak, nonatomic) IBOutlet UIImageView *imageView4;
@property (weak, nonatomic) IBOutlet UIView *viewDataItem;
@property (weak, nonatomic) IBOutlet UIButton *buttonListItems;

@end

@implementation WDAddItemViewController


#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadDefaultUIView];
}


#pragma mark - Configure UI

-(void)loadDefaultUIView {
    
    [self.imageView1.layer setCornerRadius:15];
    [self.imageView2.layer setCornerRadius:15];
    [self.imageView3.layer setCornerRadius:15];
    [self.imageView4.layer setCornerRadius:15];
    [self.viewDataItem.layer setCornerRadius:15];
    [self.buttonListItems.layer setCornerRadius:15];
}

#pragma mark - Actions

- (IBAction)touchUpInsideCancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}



@end
