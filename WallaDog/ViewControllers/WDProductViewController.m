//
//  WDProductViewController.m
//  WallaDog
//
//  Created by Fernando Luna on 1/24/16.
//  Copyright © 2016 Dancing Queen. All rights reserved.
//
@import SDWebImage;
@import iCarousel;

#import "WDProductViewController.h"
#import "WDProductViewModel.h"
#import "WDImageProductView.h"

@interface WDProductViewController () <iCarouselDataSource,iCarouselDelegate>

@property (weak, nonatomic) IBOutlet UIView *viewContent;
@property (nonatomic , strong) WDProductViewModel *productViewModel;
@property (weak, nonatomic) IBOutlet iCarousel *viewCarousel;

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
}

- (void)configureContenView {
    [self.viewContent.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [self.viewContent.layer setCornerRadius:20];
    [self.viewContent.layer setBorderWidth:1];
}

- (void)configureCarousel {
    [self.viewCarousel setType:iCarouselTypeRotary];
}

#pragma mark - Actions
- (IBAction)touchUpInsideCloseButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
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
        [viewImage setFrame:self.viewCarousel.frame];
        viewImage.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [viewImage.imageView sd_setImageWithURL:urlImage
                placeholderImage:[UIImage imageNamed:@"pawprints"] options:0
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
