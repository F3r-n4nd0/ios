//
//  WDProductViewController.m
//  WallaDog
//
//  Created by Fernando Luna on 1/24/16.
//  Copyright © 2016 Dancing Queen. All rights reserved.
//
@import SVProgressHUD;

@import SDWebImage;
@import iCarousel;

#import "WDProductViewController.h"
#import "WDProductViewModel.h"
#import "WDImageProductView.h"
#import "WDUIHelper.h"

@interface WDProductViewController ()
<iCarouselDataSource,
iCarouselDelegate,
MKMapViewDelegate
>

@property (weak, nonatomic) IBOutlet UIView *viewContent;
@property (weak, nonatomic) IBOutlet iCarousel *viewCarousel;
@property (weak, nonatomic) IBOutlet UILabel *labelTitle;
@property (weak, nonatomic) IBOutlet UITextView *textViewDetail;
@property (weak, nonatomic) IBOutlet MKMapView *mapKit;
@property (weak, nonatomic) IBOutlet UILabel *labelPrice;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewUser;
@property (weak, nonatomic) IBOutlet UILabel *labelUserDescription;
@property (weak, nonatomic) IBOutlet UIButton *buttonContact;

@property (nonatomic , strong) WDProductViewModel *productViewModel;

@end

@implementation WDProductViewController

#pragma mark - Life Cycle

-(instancetype)initWithProductViewModel:(WDProductViewModel*)productViewModel {
    if(self = [super init]) {
        _productViewModel = productViewModel;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureViewcontrollerUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Configure / Load UI

- (void)configureViewcontrollerUI {
    [self.navigationController setNavigationBarHidden:YES];
    [self configureContenView];
    [self configureCarousel];
    [self configureImageViewUser];
    [self loadCurrentProduct];
}

- (void)configureContenView {
    [self.viewContent.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [self.viewContent.layer setCornerRadius:20];
    [self.viewContent.layer setBorderWidth:1];
}

- (void)configureCarousel {
    [self.viewCarousel setType:iCarouselTypeRotary];
    if(self.productViewModel.countImages == 1) {
        [self.viewCarousel setScrollEnabled:NO];
    }
}

- (void)configureImageViewUser {
    [self.imageViewUser.layer setCornerRadius:self.imageViewUser.frame.size.width/2];
    [self.imageViewUser.layer setBorderWidth:2.0];
    [self.imageViewUser.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [self.imageViewUser.layer setShadowOffset:CGSizeMake(1, 1)];
    [self.imageViewUser.layer setShadowRadius:1.0];
    [self.imageViewUser.layer setShadowOpacity:0.7];
}

-(void)loadCurrentProduct {
    [self.labelTitle setText:[self.productViewModel textTitle]];
    [self.textViewDetail setText:[self.productViewModel textDetail]];
    [self.labelPrice setText:[self.productViewModel textPrice]];
    [self.imageViewUser sd_setImageWithURL:[self.productViewModel urlAvatarSellerThumbnail] placeholderImage:[UIImage imageNamed:@"ImageUserDefault"] options:SDWebImageRetryFailed];
    [self.labelUserDescription setText:[self.productViewModel textSellerDescripcion]];
    MKCoordinateRegion mapRegion;
    mapRegion.center.latitude = [self.productViewModel doubleLatitude];
    mapRegion.center.longitude = [self.productViewModel doubleLongitude];
    mapRegion.span.latitudeDelta = 0.005;
    mapRegion.span.longitudeDelta = 0.005;
    self.mapKit.region = mapRegion;
    MKPointAnnotation *pointAnnotation = [[MKPointAnnotation alloc] init];
    [pointAnnotation setCoordinate:CLLocationCoordinate2DMake([self.productViewModel doubleLatitude], [self.productViewModel doubleLongitude])];
    [self.mapKit addAnnotation:pointAnnotation];
}

#pragma mark - Actions

- (IBAction)touchUpInsideCloseButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)touchInsideButtonContact:(id)sender {
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    [self.productViewModel contactSellerComplitionBLock:^{
        [SVProgressHUD dismiss];
        [self dismissViewControllerAnimated:YES completion:nil];        
    } complitionError:^(NSString *error) {
        [SVProgressHUD dismiss];
        [WDUIHelper showErrorAlertWithSubTitle:error];
    }];
}


#pragma mark - Delegate

#pragma mark iCarouselDataSource

- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel {
    return self.productViewModel.countImages;
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(nullable UIView *)view {
    NSURL *urlImage = [self.productViewModel urlimageFromIndex:index];
    if (view == nil)
    {
        NSArray* nibViews = [[NSBundle mainBundle] loadNibNamed:[WDImageProductView nameXibIdentifier]
                                                          owner:self
                                                        options:nil];
        WDImageProductView *viewImage = [nibViews firstObject];
        [viewImage setFrame: CGRectMake(0, 0, self.viewCarousel.frame.size.width, self.viewCarousel.frame.size.height) ];
        viewImage.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [viewImage.imageView sd_setImageWithURL:urlImage
                placeholderImage:[UIImage imageNamed:@"pawprints"] options:SDWebImageRetryFailed
                        progress:^(NSInteger receivedSize, NSInteger expectedSize)
         {
             if (expectedSize > 0)
                 [viewImage.progressView setProgress:((float)receivedSize / (float)expectedSize)];
         } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL)
         {
             [viewImage.progressView setHidden:YES];
             if (error)
                 NSLog(@"Error load image : %@", imageURL);
         }];
        view = viewImage;
        
    }
    return view;
}

@end
