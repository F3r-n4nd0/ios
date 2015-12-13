//
//  WDStartedViewController.m
//  WallaDog
//
//  Created by Fernando Luna on 12/6/15.
//  Copyright © 2015 Dancing Queen. All rights reserved.
//

#import "WDStartedViewController.h"
#import "WDArrowView.h"

@interface WDStartedViewController ()

@property (weak, nonatomic) IBOutlet WDArrowView *viewArrowDetail;
@property (weak, nonatomic) IBOutlet UIButton *buttonLogIn;
@property (weak, nonatomic) IBOutlet UIButton *buttonSignUp;

@end

@implementation WDStartedViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
  
}

#pragma mark - Actions

- (IBAction)touchUpInsideCancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];    
}

- (IBAction)touchUpInsideLogIn:(id)sender {
    CGFloat tmp =  self.buttonLogIn.frame.origin.x + (self.buttonLogIn.frame.size.width/2) - self.viewArrowDetail.frame.origin.x;
    [self.viewArrowDetail changePositionArrow:tmp];
}

- (IBAction)touchUpInsideSignUp:(id)sender {
    CGFloat tmp =  self.buttonSignUp.frame.origin.x + (self.buttonSignUp.frame.size.width/2) - self.viewArrowDetail.frame.origin.x;
    [self.viewArrowDetail changePositionArrow:tmp];
}


@end
