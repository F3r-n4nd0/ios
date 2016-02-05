//
//  WDMainMenuRightViewController.m
//  WallaDog
//
//  Created by Fernando Luna on 2/3/16.
//  Copyright © 2016 Dancing Queen. All rights reserved.
//

#import "WDMainMenuRightViewController.h"
#import "WDAccordionRightHeaderView.h"
#import "WDMenuTableViewCell.h"
#import "WDMainMenuRightViewModel.h"
#import "WDMainViewModel.h"


@interface WDMainMenuRightViewController ()
<FZAccordionTableViewDelegate,
UITableViewDataSource,
UITableViewDelegate,
WDMainMenuRightViewModelDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageViewUser;
@property (weak, nonatomic) IBOutlet UILabel *labelTitleAccount;
@property (weak, nonatomic) IBOutlet UILabel *LabelSubTitleAccount;
@property (weak, nonatomic) IBOutlet FZAccordionTableView *tableView;

@property (nonatomic, strong) WDMainMenuRightViewModel *mainMenuRightViewModel;

@end

@implementation WDMainMenuRightViewController

#pragma mark - Life Cycle

- (instancetype)initWithRightViewModel:(WDMainMenuRightViewModel*) rightViewModel {
    if(self = [super init]) {
        rightViewModel.delegate = self;
        _mainMenuRightViewModel = rightViewModel;
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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Configure UI

-(void)configureUserUIView {
    [self.imageViewUser.layer setCornerRadius:27.5];
}

#pragma mark - Table Menu

- (void)loadMenu {
    UINib *cellNIb = [UINib nibWithNibName:[WDMenuTableViewCell reuseIdentifier] bundle:nil];
    [self.tableView registerNib:cellNIb forCellReuseIdentifier:[WDMenuTableViewCell reuseIdentifier]];
    UINib *headerNib = [UINib nibWithNibName:[WDAccordionRightHeaderView reuseIdentifier] bundle:nil];
    [self.tableView registerNib:headerNib forHeaderFooterViewReuseIdentifier:[WDAccordionRightHeaderView reuseIdentifier]];
}


#pragma mark Delegate UITableViewDataSource, UITableViewDelegate


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.mainMenuRightViewModel.countMenuList;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.mainMenuRightViewModel countSubMenuList:section];
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
    [cell.labelDescription  setText:[self.mainMenuRightViewModel textSubMenuDescriptionFromIndexPath:indexPath]];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    WDAccordionRightHeaderView *headerView = (WDAccordionRightHeaderView*) [tableView dequeueReusableHeaderFooterViewWithIdentifier:[WDAccordionRightHeaderView reuseIdentifier]];
    [headerView setImage:[self.mainMenuRightViewModel imageMenu:section] text:[self.mainMenuRightViewModel textMenuDescription:section]];
    return headerView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.mainMenuRightViewModel  selectSubMenu:indexPath];
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.mainMenuRightViewModel  deselectSubMenu:indexPath];
}

#pragma mark Delegate FZAccordionTableViewDelegate

- (void)tableView:(FZAccordionTableView *)tableView willOpenSection:(NSInteger)section withHeader:(UITableViewHeaderFooterView *)header {
    [self.mainMenuRightViewModel selectMenu:section];
}

- (void)tableView:(FZAccordionTableView *)tableView didOpenSection:(NSInteger)section withHeader:(UITableViewHeaderFooterView *)header {
    
}

- (void)tableView:(FZAccordionTableView *)tableView willCloseSection:(NSInteger)section withHeader:(UITableViewHeaderFooterView *)header {
    
}

- (void)tableView:(FZAccordionTableView *)tableView didCloseSection:(NSInteger)section withHeader:(UITableViewHeaderFooterView *)header {
    
}

#pragma mark - Delegate

#pragma mark WDMainMenuLeftViewModelDelegate

- (void)updateMenuSection:(NSInteger) section {
    [self.tableView reloadSections:[[NSIndexSet alloc] initWithIndex:section] withRowAnimation:UITableViewRowAnimationAutomatic];
}


@end
