//
//  WDMainViewController.m
//  WallaDog
//
//  Created by Fernando Luna on 12/2/15.
//  Copyright © 2015 Dancing Queen. All rights reserved.
//

#import "WDMainViewController.h"
#import "WDMainMenuLeftViewController.h"
#import "WDStartedViewController.h"

@interface WDMainViewController () <
UISearchBarDelegate,
WDMainMenuLeftViewControllerDelegate>

@property (nonatomic, strong) UISearchBar *searchBar;

@end

@implementation WDMainViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self uploadSliteMenu];
    [self configureSearchBar];
}


#pragma mark - Slite Menu

- (void) uploadSliteMenu {
    WDMainMenuLeftViewController *leftMenu = [[WDMainMenuLeftViewController alloc] init];
    [SlideNavigationController sharedInstance].portraitSlideOffset = 100;
    [SlideNavigationController sharedInstance].leftMenu = leftMenu;
    
    leftMenu.delegate = self;
    
    UIButton *buttonLeft  = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [buttonLeft setImage:[UIImage imageNamed:@"menu-button"] forState:UIControlStateNormal];
    [buttonLeft addTarget:[SlideNavigationController sharedInstance] action:@selector(toggleLeftMenu) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:buttonLeft];
    [SlideNavigationController sharedInstance].leftBarButtonItem = leftBarButtonItem;
        
    UIButton *buttonRight  = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [buttonRight setImage:[UIImage imageNamed:@"menu-button"] forState:UIControlStateNormal];
    [buttonRight addTarget:[SlideNavigationController sharedInstance] action:@selector(toggleRightMenu) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:buttonRight];
    [SlideNavigationController sharedInstance].rightBarButtonItem = rightBarButtonItem;
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
        default:
            break;
    }
}

#pragma mark - XXXXXXXX

- (void)showModalLogin {
    WDStartedViewController *startedViewController = [[WDStartedViewController alloc] init];
    startedViewController.modalPresentationStyle = UIModalPresentationCustom;
    startedViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self.navigationController presentViewController:startedViewController animated:YES completion:nil];
}

@end
