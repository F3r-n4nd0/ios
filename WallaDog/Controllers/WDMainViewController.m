//
//  WDMainViewController.m
//  WallaDog
//
//  Created by Fernando Luna on 12/2/15.
//  Copyright © 2015 Dancing Queen. All rights reserved.
//
@import CHTCollectionViewWaterfallLayout;
@import SDWebImage;

#import "WDMainViewController.h"
#import "WDMainMenuLeftViewController.h"
#import "WDStartedViewController.h"
#import "WDMainCollectionViewCell.h"
#import "WDAddItemViewController.h"

@interface WDMainViewController ()
<UISearchBarDelegate,
WDMainMenuLeftViewControllerDelegate,
UICollectionViewDataSource,
UICollectionViewDelegate,
CHTCollectionViewDelegateWaterfallLayout>

@property (nonatomic, strong) UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *arrayImages;
@property (weak, nonatomic) IBOutlet UIButton *buttonCamera;
@property (weak, nonatomic) IBOutlet UIView *viewLocation;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintViewLocationTop;


@end

@implementation WDMainViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadAndConfigureUI];
}

#pragma mark - Configure / Load UI

- (void) loadAndConfigureUI {
    [self loadSliteMenu];
    [self configureCollectionView];
    [self configureSearchBar];
    [self configureCameraButton];
    [self configureLocationView];
}

- (void)configureCameraButton {
    [self.buttonCamera.layer setCornerRadius:self.buttonCamera.frame.size.height/2];
    [self.buttonCamera.layer setBorderWidth:5.0];
    [self.buttonCamera.layer setBorderColor:[UIColor whiteColor].CGColor];
    [self.buttonCamera.layer setMasksToBounds:NO];
    [self.buttonCamera.layer setShadowOffset:CGSizeMake(2, 2)];
    [self.buttonCamera.layer setShadowRadius:2.0];
    [self.buttonCamera.layer setShadowOpacity:0.7];
}

- (void)configureLocationView {
    [self.viewLocation.layer setCornerRadius:12.0];
    [self.viewLocation.layer setMasksToBounds:NO];
    [self.viewLocation.layer setShadowOffset:CGSizeMake(2, 2)];
    [self.viewLocation.layer setShadowRadius:2.0];
    [self.viewLocation.layer setShadowOpacity:0.7];
}


#pragma mark - CollectionView


- (void) configureCollectionView {
    
    UINib *nibMainCell = [UINib nibWithNibName:[WDMainCollectionViewCell reuseIdentifier] bundle:nil];
    [self.collectionView registerNib:nibMainCell forCellWithReuseIdentifier:[WDMainCollectionViewCell reuseIdentifier]];
    
    CHTCollectionViewWaterfallLayout *layoutCollectionView = (CHTCollectionViewWaterfallLayout*) self.collectionView.collectionViewLayout;
    [layoutCollectionView setSectionInset:UIEdgeInsetsMake(20.0, 15.0, 20.0, 15.0)];
    [layoutCollectionView setColumnCount:2];
    [layoutCollectionView setMinimumColumnSpacing:15.0];
    [layoutCollectionView setMinimumInteritemSpacing:15.0];

}


#pragma mark - Slite Menu

- (void) loadSliteMenu {
    WDMainMenuLeftViewController *leftMenu = [[WDMainMenuLeftViewController alloc] init];
    [SlideNavigationController sharedInstance].portraitSlideOffset = 100;
    [SlideNavigationController sharedInstance].leftMenu = leftMenu;
    
    leftMenu.delegate = self;
    
    UIButton *buttonLeft  = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [buttonLeft setImage:[UIImage imageNamed:@"ImageMenuIcon"] forState:UIControlStateNormal];
    [buttonLeft addTarget:[SlideNavigationController sharedInstance] action:@selector(toggleLeftMenu) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:buttonLeft];
    [SlideNavigationController sharedInstance].leftBarButtonItem = leftBarButtonItem;
    
    UIButton *buttonRight  = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [buttonRight setImage:[UIImage imageNamed:@"ImageMenuIcon"] forState:UIControlStateNormal];
    [buttonRight addTarget:[SlideNavigationController sharedInstance] action:@selector(toggleRightMenu) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:buttonRight];
    [SlideNavigationController sharedInstance].rightBarButtonItem = rightBarButtonItem;
    
    [self.navigationController setHidesBarsOnSwipe:YES];
}

- (BOOL)slideNavigationControllerShouldDisplayLeftMenu
{
    return YES;
}

- (BOOL)slideNavigationControllerShouldDisplayRightMenu
{
    return YES;
}

#pragma mark - Search

- (void)configureSearchBar {
    self.searchBar = [[UISearchBar alloc] init];
    self.searchBar.delegate = self;
    [self.searchBar setPlaceholder:@"Search WallaDog"];
    [self.searchBar setSearchBarStyle:UISearchBarStyleMinimal];
    [self.searchBar setTintColor:[UIColor whiteColor]];
    UITextField *searchField  = [self.searchBar valueForKey:@"_searchField"];
    [searchField setTextColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:0.6]];
    [searchField setFont:[UIFont boldSystemFontOfSize:17]];
    [searchField setValue:[UIColor colorWithRed:1 green:1 blue:1 alpha:0.2] forKeyPath:@"_placeholderLabel.textColor"];
    self.navigationItem.titleView = self.searchBar;
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    [[SlideNavigationController sharedInstance] setEnableSwipeGesture:NO];
    if([SlideNavigationController sharedInstance].isMenuOpen) {
        [[SlideNavigationController sharedInstance] closeMenuWithCompletion:nil];
    }
    self.navigationItem.rightBarButtonItem = nil;
    self.navigationItem.leftBarButtonItem = nil;
    self.searchBar.showsCancelButton = YES;
    return YES;
}

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar {
    [[SlideNavigationController sharedInstance] setEnableSwipeGesture:YES];
    self.navigationItem.rightBarButtonItem = [SlideNavigationController sharedInstance].rightBarButtonItem;
    self.navigationItem.leftBarButtonItem = [SlideNavigationController sharedInstance].leftBarButtonItem;
    self.searchBar.showsCancelButton = NO;
    return YES;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [self.searchBar setText:@""];
    [self.searchBar resignFirstResponder];
}

#pragma mark - Delegate

#pragma mark WDMainMenuLeftViewControllerDelegate

- (void)selectMenuSection:(NSInteger)section {
    switch (section) {
        case -1:
            [self showModalLogin];
            break;
        case 0:
            [self showSellItem];
            break;
        default:
            break;
    }
}


#pragma mark UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.arrayImages.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    WDMainCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[WDMainCollectionViewCell reuseIdentifier] forIndexPath:indexPath];
    [cell.imageView sd_setImageWithURL:[self.arrayImages objectAtIndex:indexPath.row] placeholderImage:[UIImage imageNamed:@"AppImage"]];
    return cell;
}

#pragma mark CollectionViewWaterfallLayoutDelegate

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)layout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSURL *urlImage = [self.arrayImages objectAtIndex:indexPath.row];
   UIImage *image = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:urlImage.absoluteString];
    return image == nil?CGSizeMake(200, 200):image.size;
}

#pragma mark UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.y <= 0) {
        [self.viewLocation setHidden:YES];
    } else {
        if(self.navigationController.navigationBarHidden) {
            self.constraintViewLocationTop.constant = 50.0;
        } else {
            self.constraintViewLocationTop.constant = 85.0;
        }
        [self.viewLocation setHidden:NO];
    }
    if (scrollView.contentOffset.y > 300) {
        [self.buttonCamera setHidden:YES];
    } else {
        [self.buttonCamera setHidden:NO];
    }
}

#pragma mark - Menu Options

- (void)showModalLogin {
    WDStartedViewController *startedViewController = [[WDStartedViewController alloc] init];
    startedViewController.modalPresentationStyle = UIModalPresentationCustom;
    startedViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self.navigationController presentViewController:startedViewController animated:YES completion:nil];
}

- (void)showSellItem {
    WDAddItemViewController *startedViewController = [[WDAddItemViewController alloc] init];
    startedViewController.modalPresentationStyle = UIModalPresentationCustom;
    startedViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self.navigationController presentViewController:startedViewController animated:YES completion:nil];
}

@end
