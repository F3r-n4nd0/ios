//
//  DQStartedViewController.m
//  WallaDog
//
//  Created by Fernando Luna on 12/6/15.
//  Copyright © 2015 Dancing Queen. All rights reserved.
//

#import "DQStartedViewController.h"
#import "DQArrowView.h"

@interface DQStartedViewController ()

@property (weak, nonatomic) IBOutlet DQArrowView *viewArrowDetail;
@property (weak, nonatomic) IBOutlet UIButton *buttonLogIn;
@property (weak, nonatomic) IBOutlet UIButton *buttonSignUp;

@end

@implementation DQStartedViewController

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
