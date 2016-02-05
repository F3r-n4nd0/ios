//
//  WDAccountViewController.m
//  WallaDog
//
//  Created by Fernando Luna on 2/3/16.
//  Copyright © 2016 Dancing Queen. All rights reserved.
//
@import SDWebImage;
@import SVProgressHUD;
@import DBCamera;
@import RSKImageCropper;

#import "WDAccountViewController.h"
#import "WDAccountViewModel.h"
#import "WDUIHelper.h"

@interface WDAccountViewController ()
<UITextFieldDelegate,
DBCameraViewControllerDelegate,
RSKImageCropViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageViewUser;
@property (weak, nonatomic) IBOutlet UILabel *labelUserName;
@property (weak, nonatomic) IBOutlet UITextField *textFieldFirstName;
@property (weak, nonatomic) IBOutlet UITextField *textFieldLastName;
@property (weak, nonatomic) IBOutlet UITextField *textFieldEmail;
@property (weak, nonatomic) IBOutlet UIButton *buttonSave;

@property (nonatomic, strong) UINavigationController *navigationCamera;
@property (nonatomic) BOOL isChangeImage;
@property (nonatomic , strong) WDAccountViewModel *accountViewModel;

@end

@implementation WDAccountViewController

#pragma mark - Life Cycle

-(instancetype)initWithProductViewModel:(WDAccountViewModel *)accountViewModel {
    if(self = [super init]) {
        _accountViewModel = accountViewModel;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureUserUIView];
    [self LoadDataUser];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Configure / Load UI

-(void)configureUserUIView {
    [self configureImageUser];
    [self configureButtonSave];
}

-(void)configureImageUser {
    [self.imageViewUser.layer setCornerRadius:self.imageViewUser.frame.size.width/2];
    [self.imageViewUser.layer setBorderWidth:3.0];
    [self.imageViewUser.layer setBorderColor:[UIColor whiteColor].CGColor];
    [self.imageViewUser.layer setShadowOffset:CGSizeMake(1, 1)];
    [self.imageViewUser.layer setShadowRadius:1.0];
    [self.imageViewUser.layer setShadowOpacity:0.7];
}

-(void)configureButtonSave {
    [self.buttonSave.layer setCornerRadius:5];
}

#pragma mark - User data

-(void)LoadDataUser {
    
    [self.imageViewUser sd_setImageWithURL:self.accountViewModel.urlAvatarlUser placeholderImage:[UIImage imageNamed:@"ImageUserDefault"] options:SDWebImageRetryFailed];
    [self.labelUserName setText:self.accountViewModel.textUserName];
    [self.textFieldFirstName setText:self.accountViewModel.textFirstName];
    [self.textFieldLastName setText:self.accountViewModel.textLastName];
    [self.textFieldEmail setText:self.accountViewModel.textEmail];
    
}

#pragma mark - actions

- (IBAction)touchUpInsideClose:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)touchInsideSave:(id)sender {
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    [self.accountViewModel saveChangeWithFirstName:self.textFieldFirstName.text
                                          lastName:self.textFieldLastName.text
                                             email:self.textFieldEmail.text
                                             image:self.isChangeImage?self.imageViewUser.image:nil
                                           success:^{
                                               [SVProgressHUD dismiss];
                                               [self dismissViewControllerAnimated:YES completion:nil];
                                           } failure:^(NSString *errorDescripcion) {
                                               [SVProgressHUD dismiss];
                                               [WDUIHelper showErrorAlertWithSubTitle:errorDescripcion];
                                           }];
}

- (IBAction)selectImageUser:(id)sender {
    DBCameraViewController *cameraController = [DBCameraViewController initWithDelegate:self];
    [cameraController setFullScreenMode];
    [cameraController setUseCameraSegue:NO];
    
    DBCameraContainerViewController *container = [[DBCameraContainerViewController alloc] initWithDelegate:self];
    [container setCameraViewController:cameraController];
    [container setFullScreenMode];
    
    self.navigationCamera = [[UINavigationController alloc] initWithRootViewController:container];
    [self.navigationCamera setNavigationBarHidden:YES];
    [self presentViewController:self.navigationCamera animated:YES completion:nil];
}


#pragma mark - delegate

#pragma mark UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}

#pragma mark DBCameraViewControllerDelegate

- (void) camera:(id)cameraViewController didFinishWithImage:(UIImage *)image withMetadata:(NSDictionary *)metadata {
    RSKImageCropViewController *imageCropVC = [[RSKImageCropViewController alloc] initWithImage:image];
    imageCropVC.delegate = self;
    [self.navigationCamera pushViewController:imageCropVC animated:YES];
}

- (void) dismissCamera:(id)cameraViewController {
    [self dismissViewControllerAnimated:NO completion:nil];
    self.navigationCamera = nil;
}

#pragma mak RSKImageCropViewControllerDelegate

- (void)imageCropViewController:(RSKImageCropViewController *)controller
                   didCropImage:(UIImage *)croppedImage
                  usingCropRect:(CGRect)cropRect
{
    self.isChangeImage = YES;
    self.imageViewUser.image = croppedImage;
    [self dismissViewControllerAnimated:NO completion:nil];
    self.navigationCamera = nil;
}

- (void)imageCropViewControllerDidCancelCrop:(RSKImageCropViewController *)controller {
    [self.navigationCamera popToRootViewControllerAnimated:YES];
}

@end
