//
//  WDMainMenuLeftViewController.m
//  WallaDog
//
//  Created by Fernando Luna on 12/6/15.
//  Copyright © 2015 Dancing Queen. All rights reserved.
//
@import FZAccordionTableView;
@import SDWebImage;

#import "WDMainMenuLeftViewController.h"
#import "WDAccordionHeaderView.h"
#import "WDMenuTableViewCell.h"
#import "WDMainMenuLeftViewModel.h"
#import "WDMainViewModel.h"


@interface WDMainMenuLeftViewController ()
<FZAccordionTableViewDelegate,
UITableViewDataSource,
UITableViewDelegate,
WDMainMenuLeftViewModelDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageViewUser;
@property (weak, nonatomic) IBOutlet UILabel *labelTitleAccount;
@property (weak, nonatomic) IBOutlet UILabel *LabelSubTitleAccount;
@property (weak, nonatomic) IBOutlet FZAccordionTableView *tableView;

@property (nonatomic, strong) WDMainMenuLeftViewModel *mainMenuLeftViewModel;

@end

@implementation WDMainMenuLeftViewController

- (instancetype)initWithMainViewModel:(WDMainViewModel*) mainViewModel {
    if(self = [super init]) {
        _mainMenuLeftViewModel = [[WDMainMenuLeftViewModel alloc] initWithDelgate:self
                                                                    mainViewModel:mainViewModel];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureUserUIView];
    [self loadMenu];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self updateCurrentUser];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Configure UI

-(void)configureUserUIView {
    [self.imageViewUser.layer setCornerRadius:27.5];
}

#pragma mark - Table Menu

- (void)loadMenu {
    UINib *cellNIb = [UINib nibWithNibName:[WDMenuTableViewCell reuseIdentifier] bundle:nil];
    [self.tableView registerNib:cellNIb forCellReuseIdentifier:[WDMenuTableViewCell reuseIdentifier]];
    UINib *headerNib = [UINib nibWithNibName:[WDAccordionHeaderView reuseIdentifier] bundle:nil];
    [self.tableView registerNib:headerNib forHeaderFooterViewReuseIdentifier:[WDAccordionHeaderView reuseIdentifier]];
}


#pragma mark Delegate UITableViewDataSource, UITableViewDelegate


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.mainMenuLeftViewModel.countMenuList;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.mainMenuLeftViewModel countSubMenuList:section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self tableView:tableView heightForRowAtIndexPath:indexPath];
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section {
    return [self tableView:tableView heightForHeaderInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WDMenuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[WDMenuTableViewCell reuseIdentifier] forIndexPath:indexPath];
    [cell.labelDescription  setText:[self.mainMenuLeftViewModel textSubMenuDescriptionFromIndexPath:indexPath]];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    WDAccordionHeaderView *headerView = (WDAccordionHeaderView*) [tableView dequeueReusableHeaderFooterViewWithIdentifier:[WDAccordionHeaderView reuseIdentifier]];
    [headerView setImage:[self.mainMenuLeftViewModel imageMenu:section] text:[self.mainMenuLeftViewModel textMenuDescription:section]];
    return headerView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.mainMenuLeftViewModel  selectSubMenu:indexPath];
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.mainMenuLeftViewModel  deselectSubMenu:indexPath];
}

#pragma mark Delegate FZAccordionTableViewDelegate

- (void)tableView:(FZAccordionTableView *)tableView willOpenSection:(NSInteger)section withHeader:(UITableViewHeaderFooterView *)header {
    [self.mainMenuLeftViewModel selectMenu:section];
}

- (void)tableView:(FZAccordionTableView *)tableView didOpenSection:(NSInteger)section withHeader:(UITableViewHeaderFooterView *)header {
    
}

- (void)tableView:(FZAccordionTableView *)tableView willCloseSection:(NSInteger)section withHeader:(UITableViewHeaderFooterView *)header {
    
}

- (void)tableView:(FZAccordionTableView *)tableView didCloseSection:(NSInteger)section withHeader:(UITableViewHeaderFooterView *)header {
    
}

#pragma mark - Actions

- (IBAction)selectAccountView:(id)sender {
    [self.mainMenuLeftViewModel selectAccountUser];
}

#pragma mark - Delefate

#pragma mark WDMainMenuLeftViewModelDelegate

- (void)updateMenuSection:(NSInteger) section {
    [self.tableView reloadSections:[[NSIndexSet alloc] initWithIndex:section] withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (void)updateCurrentUser {
    [self.imageViewUser sd_setImageWithURL:self.mainMenuLeftViewModel.urlAvatarThumbnailUser placeholderImage:[UIImage imageNamed:@"ImageUserDefault"]];
    [self.labelTitleAccount setText:self.mainMenuLeftViewModel.titleAccount];
    [self.LabelSubTitleAccount setText:self.mainMenuLeftViewModel.SubTitleAccount];
}
@end
