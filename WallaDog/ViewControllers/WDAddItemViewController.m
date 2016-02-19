//
//  WDAddItemViewController.m
//  WallaDog
//
//  Created by Fernando Luna on 12/21/15.
//  Copyright © 2015 Dancing Queen. All rights reserved.
//
@import DBCamera;
@import SVProgressHUD;

#import "WDAddItemViewController.h"
#import "WDAddItemViewModel.h"
#import "WDUIHelper.h"
#import "WDPickerViewController.h"

@interface WDAddItemViewController ()
<DBCameraViewControllerDelegate,
WDPickerViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageView1;
@property (weak, nonatomic) IBOutlet UIImageView *imageView2;
@property (weak, nonatomic) IBOutlet UIImageView *imageView3;
@property (weak, nonatomic) IBOutlet UIImageView *imageView4;
@property (weak, nonatomic) IBOutlet UIView *viewDataItem;
@property (weak, nonatomic) IBOutlet UIButton *buttonListItems;
@property (weak, nonatomic) IBOutlet UITextField *textFieldTitle;
@property (weak, nonatomic) IBOutlet UITextView *textViewDetail;
@property (weak, nonatomic) IBOutlet UIButton *buttonCategory;
@property (weak, nonatomic) IBOutlet UIButton *buttonRace;
@property (weak, nonatomic) IBOutlet UITextField *textFieldPrice;

@property(nonatomic, strong) IBOutlet UIImageView *selectImageView;
@property(nonatomic, strong) UIImage *imagePlaceHolder;
@property (nonatomic, strong) WDAddItemViewModel *addItemViewModel;

@end

@implementation WDAddItemViewController


#pragma mark - Life Cycle

#pragma mark - Life Cycle

-(instancetype)initWithAddItemViewModel:(WDAddItemViewModel *)addItemViewModel {
    if(self = [super init]) {
        _addItemViewModel = addItemViewModel;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadDefaultUIView];
    [self loadData];
    [self updateSelectPickers];
}


#pragma mark - Configure UI

-(void)loadDefaultUIView {
    
    [self.imageView1.layer setCornerRadius:15];
    [self.imageView2.layer setCornerRadius:15];
    [self.imageView3.layer setCornerRadius:15];
    [self.imageView4.layer setCornerRadius:15];
    [self.viewDataItem.layer setCornerRadius:15];
    [self.buttonListItems.layer setCornerRadius:15];
    
    
    [self.textViewDetail.layer setCornerRadius:10];
    [self.textViewDetail.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [self.textViewDetail.layer setBorderWidth:1];
    
    self.imagePlaceHolder = [UIImage imageNamed:@"ImageNoCamera"];
    
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)loadData {
    if(self.addItemViewModel.photImage1)
        [self.imageView1 setImage:self.addItemViewModel.photImage1];
    else
        [self.imageView1 setImage:self.imagePlaceHolder];
    
    if(self.addItemViewModel.photImage2)
        [self.imageView2 setImage:self.addItemViewModel.photImage2];
    else
        [self.imageView2 setImage:self.imagePlaceHolder];
    
    if(self.addItemViewModel.photImage3)
        [self.imageView3 setImage:self.addItemViewModel.photImage3];
    else
        [self.imageView3 setImage:self.imagePlaceHolder];
    
    if(self.addItemViewModel.photImage4)
        [self.imageView4 setImage:self.addItemViewModel.photImage4];
    else
        [self.imageView4 setImage:self.imagePlaceHolder];
}

- (void)updateSelectPickers {
    NSString *titleCategory = [ NSString stringWithFormat:@"Category : %@", self.addItemViewModel.textSelectCategory];
    [self.buttonCategory setTitle:titleCategory forState:UIControlStateNormal];

    
    NSString *titleRace = [ NSString stringWithFormat:@"Race : %@", self.addItemViewModel.textSelectRace];
    [self.buttonRace setTitle:titleRace forState:UIControlStateNormal];
}

#pragma mark - Actions

- (IBAction)touchUpInsideCancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)selectImage:(UITapGestureRecognizer*)sender {
    
    if(![sender.view isKindOfClass:[UIImageView class]]) {
        return;
    }
    self.selectImageView = (UIImageView*)sender.view;
    
    DBCameraViewController *cameraController = [DBCameraViewController initWithDelegate:self];
    [cameraController setFullScreenMode];
    [cameraController setUseCameraSegue:NO];
    
    DBCameraContainerViewController *container = [[DBCameraContainerViewController alloc] initWithDelegate:self];
    [container setCameraViewController:cameraController];
    [container setFullScreenMode];
    
    UINavigationController *navigationCamera = [[UINavigationController alloc] initWithRootViewController:container];
    [navigationCamera setNavigationBarHidden:YES];
    [self presentViewController:navigationCamera animated:YES completion:nil];
    
}

- (IBAction)selectView:(id)sender {
    [self.view endEditing:YES];
}


- (IBAction)touchUpInsideSell:(id)sender {
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    [self.addItemViewModel savenewItemWithTitle:self.textFieldTitle.text
                                    description:self.textViewDetail.text
                                          price:self.textFieldPrice.text
                                         image1:self.imageView1.image==self.imagePlaceHolder?nil:self.imageView1.image
                                         image2:self.imageView2.image==self.imagePlaceHolder?nil:self.imageView2.image
                                         image3:self.imageView3.image==self.imagePlaceHolder?nil:self.imageView3.image
                                         image4:self.imageView4.image==self.imagePlaceHolder?nil:self.imageView4.image
                                        success:^
     {
         [SVProgressHUD dismiss];
         [self dismissViewControllerAnimated:YES completion:nil];
     } failure:^(NSString *errorDescripcion) {
         [SVProgressHUD dismiss];
         [WDUIHelper showErrorAlertWithSubTitle:errorDescripcion];
     }];
    
}

- (IBAction)touchInsideCAtegory:(id)sender {
    NSArray *list = [self.addItemViewModel arrayListCategories];
    WDPickerViewController *pickerViewController = [[WDPickerViewController alloc] initWithList:list
                                                                                            key:@"Category"
                                                                                       delegate:self];
    [pickerViewController setModalPresentationStyle:UIModalPresentationCustom];
    [pickerViewController setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
    [self.navigationController presentViewController:pickerViewController animated:YES completion:nil];
}

- (IBAction)touchInsideRace:(id)sender {
    NSArray *list = [self.addItemViewModel arrayListRace];
    WDPickerViewController *pickerViewController = [[WDPickerViewController alloc] initWithList:list
                                                                                            key:@"Race"
                                                                                        delegate:self];
    [pickerViewController setModalPresentationStyle:UIModalPresentationCustom];
    [pickerViewController setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
    [self.navigationController presentViewController:pickerViewController animated:YES completion:nil];
    
}


#pragma mark - Delegate

#pragma mark DBCameraViewControllerDelegate

- (void) camera:(id)cameraViewController didFinishWithImage:(UIImage *)image withMetadata:(NSDictionary *)metadata {
    [self.selectImageView setImage:image];
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void) dismissCamera:(id)cameraViewController {
    [self dismissViewControllerAnimated:NO completion:nil];
}

#pragma mark WDPickerViewControllerDelegate

-(void)selectData:(NSInteger)row key:(NSString*)key {
    if ([key isEqualToString:@"Category"]) {
        [self.addItemViewModel selectCategory:row];
    }
    if([key isEqualToString:@"Race"]) {
        [self.addItemViewModel selectRace:row];
    }
    [self updateSelectPickers];
}

@end
