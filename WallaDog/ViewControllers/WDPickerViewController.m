//
//  WDPickerViewController.m
//  WallaDog
//
//  Created by Fernando Luna on 2/5/16.
//  Copyright © 2016 Dancing Queen. All rights reserved.
//

#import "WDPickerViewController.h"

@interface WDPickerViewController ()
<UIPickerViewDataSource,
UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (nonatomic) NSInteger selectIndex;
@property (weak, nonatomic) IBOutlet UIView *viewPicker;
@property (nonatomic, strong) NSString* key;

@property (nonatomic, strong) NSArray<NSString *> *list;

@end

@implementation WDPickerViewController


- (instancetype)initWithList:(NSArray<NSString *> *)list
                         key:(NSString*)key
                    delegate:(id<WDPickerViewControllerDelegate>)delegate {
    if(self = [super init]) {
        _list = list;
        _delegate = delegate;
        _key = key;
        _selectIndex = 0;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.viewPicker.layer setCornerRadius:15];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Actions

- (IBAction)actionSelect:(id)sender {
    if([self.delegate respondsToSelector:@selector(selectData:key:)])
       [self.delegate selectData:self.selectIndex key:self.key];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)actionCanel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Delegate

#pragma mark UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.list.count;
}

#pragma mark UIPickerViewDelegate

- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [self.list objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    self.selectIndex = row;
}

@end
