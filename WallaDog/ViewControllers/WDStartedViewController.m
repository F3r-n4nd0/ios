//
//  WDStartedViewController.m
//  WallaDog
//
//  Created by Fernando Luna on 12/6/15.
//  Copyright © 2015 Dancing Queen. All rights reserved.
//

@import SVProgressHUD;

#import "WDStartedViewController.h"
#import "WDArrowView.h"
#import "WDStartedViewModels.h"

@interface WDStartedViewController ()

@property (weak, nonatomic) IBOutlet UIButton *buttonLogInMenu;
@property (weak, nonatomic) IBOutlet UIButton *buttonSignUpMenu;
@property (weak, nonatomic) IBOutlet UIButton *buttonForgotYourPassword;
@property (weak, nonatomic) IBOutlet UIButton *buttonEnterLogIn;
@property (weak, nonatomic) IBOutlet UIButton *buttonEnterSignUp;
@property (weak, nonatomic) IBOutlet UIView *viewSignUp;
@property (weak, nonatomic) IBOutlet UIView *viewLogIn;
@property (weak, nonatomic) IBOutlet WDArrowView *viewWithArrow;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintViewLogInTop;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintViewSignUpTop;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintViewWithArrow;

@property (weak, nonatomic) IBOutlet UITextField *textFieldLogInEmail;

@property (weak, nonatomic) IBOutlet UITextField *textFieldSignUpFullName;
@property (weak, nonatomic) IBOutlet UITextField *textFieldSignUpEmail;
@property (weak, nonatomic) IBOutlet UITextField *textFieldSignUpPassword;

@property(nonatomic, strong) WDStartedViewModels *startedViewModels;

@end

@implementation WDStartedViewController

#pragma mark - Life Cycle

- (instancetype)initWithStartedViewModels:(WDStartedViewModels*)startedViewModels {
    if(self = [super init]) {
        _startedViewModels = startedViewModels;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadDefaultUIView];
    [self loadDefaultConfiguration];
}

-(void)loadDefaultConfiguration {
    [self changeToViewLogIn];
}

#pragma mark - Configure UI

-(void)loadDefaultUIView {
    [self.constraintViewSignUpTop setConstant:self.constraintViewLogInTop.constant];
    [self.buttonEnterSignUp.layer setCornerRadius:15];
    [self.buttonEnterLogIn.layer setCornerRadius:15];
}

-(void)changeToViewLogIn {
    [self.viewLogIn setHidden:NO];
    [self.viewSignUp setHidden:YES];
    [self.viewWithArrow setArrowPositionFromView:self.buttonLogInMenu];
    [self.constraintViewWithArrow setConstant:self.viewLogIn.frame.size.height + self.constraintViewLogInTop.constant];
}

-(void)changeToViewSignUp {
    [self.viewSignUp setHidden:NO];
    [self.viewLogIn setHidden:YES];
    [self.viewWithArrow setArrowPositionFromView:self.buttonSignUpMenu];
    [self.constraintViewWithArrow setConstant:self.viewSignUp.frame.size.height + self.constraintViewLogInTop.constant];
}

#pragma mark - Actions

- (IBAction)touchUpInsideCancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];    
}

- (IBAction)touchUpInsideLogInMenu:(id)sender {
    if(!self.viewLogIn.hidden) {
        return;
    }
    [self changeToViewLogIn];
}

- (IBAction)touchUpInsideSignUpMenu:(id)sender {
    if(!self.viewSignUp.hidden) {
        return;
    }
    [self changeToViewSignUp];
}

- (IBAction)touchUpInsideEnterLogIn:(id)sender {

    NSString *fullName = self.textFieldSignUpFullName.text;
    NSString *email = self.textFieldSignUpEmail.text;
    NSString *password = self.textFieldSignUpPassword.text;
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    [self.startedViewModels signUpWithFullName:fullName email:email password:password completionBlock:^(NSError *error, NSString *alert, BOOL finished) {
         [SVProgressHUD dismiss];
        if(finished) {
            
            return;
        }
        if(error) {
            return;
        }
        if(alert) {
            
        }
    }];
}

- (IBAction)touchUpInsideEnterSignUp:(id)sender {
    
}

- (IBAction)touchUpInsideForgotPassword:(id)sender {
    
}




@end
