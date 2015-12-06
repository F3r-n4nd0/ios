//
//  DQMainMenuLeftViewController.m
//  WallaDog
//
//  Created by Fernando Luna on 12/6/15.
//  Copyright © 2015 Dancing Queen. All rights reserved.
//
#import <FZAccordionTableView/FZAccordionTableView.h>

#import "DQMainMenuLeftViewController.h"
#import "DQAccordionHeaderView.h"
#import "DQMenuTableViewCell.h"


@interface DQMainMenuLeftViewController ()
<FZAccordionTableViewDelegate,
UITableViewDataSource,
UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageViewUser;
@property (weak, nonatomic) IBOutlet FZAccordionTableView *tableView;
@property (nonatomic, strong) NSArray *sectionsMenuText;
@property (nonatomic, strong) NSArray *sectionsMenuImages;

@end

@implementation DQMainMenuLeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureUserUIView];
    [self loadMenu];
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
    UINib *cellNIb = [UINib nibWithNibName:[DQMenuTableViewCell reuseIdentifier] bundle:nil];
    [self.tableView registerNib:cellNIb forCellReuseIdentifier:[DQMenuTableViewCell reuseIdentifier]];
    UINib *headerNib = [UINib nibWithNibName:[DQAccordionHeaderView reuseIdentifier] bundle:nil];
    [self.tableView registerNib:headerNib forHeaderFooterViewReuseIdentifier:[DQAccordionHeaderView reuseIdentifier]];
    self.sectionsMenuText = [self getSectionsMenuText];
    self.sectionsMenuImages = [self getSectionsMenuImages];
}

- (NSArray*)getSectionsMenuText {
    return @[@"List Item",
             @"Messages",
             @"Help"];
}
- (NSArray*)getSectionsMenuImages {
    return @[[UIImage imageNamed:@"ImageCameraIcon"],
             [UIImage imageNamed:@"ImageMessageIcon"],
             [UIImage imageNamed:@"ImageHelpIcon"]];
}

#pragma mark Delegate UITableViewDataSource, UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sectionsMenuText.count;
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[DQMenuTableViewCell reuseIdentifier] forIndexPath:indexPath];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    DQAccordionHeaderView *headerView = (DQAccordionHeaderView*) [tableView dequeueReusableHeaderFooterViewWithIdentifier:[DQAccordionHeaderView reuseIdentifier]];
    [headerView setImage:[self.sectionsMenuImages objectAtIndex:section] text:[self.sectionsMenuText objectAtIndex:section]];
    return headerView;
}

#pragma mark Delegate FZAccordionTableViewDelegate

- (void)tableView:(FZAccordionTableView *)tableView willOpenSection:(NSInteger)section withHeader:(UITableViewHeaderFooterView *)header {
    
}

- (void)tableView:(FZAccordionTableView *)tableView didOpenSection:(NSInteger)section withHeader:(UITableViewHeaderFooterView *)header {
    
}

- (void)tableView:(FZAccordionTableView *)tableView willCloseSection:(NSInteger)section withHeader:(UITableViewHeaderFooterView *)header {
    
}

- (void)tableView:(FZAccordionTableView *)tableView didCloseSection:(NSInteger)section withHeader:(UITableViewHeaderFooterView *)header {
    
}

#pragma mark - Actions


- (IBAction)selectAccountView:(id)sender {
    if([self.delegate respondsToSelector:@selector(selectMenuSection:)]) {
        [self.delegate selectMenuSection:-1];
    }
}


@end
