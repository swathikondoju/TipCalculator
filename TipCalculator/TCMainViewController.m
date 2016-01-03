//
//  TCMainViewController.m
//  TipCalculator
//
//  Created by Swathi Kondoju on 12/31/15.
//  Copyright © 2015 Swathi Kondoju. All rights reserved.
//

#import "TCMainViewController.h"
#import "TCSettingsViewController.h"
#import "AppDelegate.h"

@interface TCMainViewController () <UITextFieldDelegate, TCSettingsViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UIView *tipAmountView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *_tipPercentageControl;
@property (weak, nonatomic) IBOutlet UITextField *_billAmountTextField;
@property (weak, nonatomic) IBOutlet UILabel *_totalAmountLabel;
@property (weak, nonatomic) IBOutlet UILabel *_tipAmountLabel;
@property (assign, nonatomic) int _tipPercent;
@property (weak, nonatomic) IBOutlet UILabel *plusLabel;
@property (weak, nonatomic) IBOutlet UILabel *equalLabel;

@end

@implementation TCMainViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
  self._billAmountTextField.delegate = self;
  [self._billAmountTextField setKeyboardType:UIKeyboardTypeDecimalPad];
  [self._tipPercentageControl setSelectedSegmentIndex:0];
  self._tipPercent = 15;
  UIBarButtonItem *settingsButton = [[UIBarButtonItem alloc] initWithTitle:@"Settings" style:UIBarButtonItemStyleDone target:self action:@selector(showSettings)];
  self.navigationItem.rightBarButtonItem = settingsButton;
  self.plusLabel.text = @"";
  self.equalLabel.text = @"";

  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
}

- (void)viewWillAppear:(BOOL)animated {
  self.tipAmountView.hidden = YES;
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (IBAction)toggleTipPercentage:(id)sender {
  NSInteger selectedIndex = self._tipPercentageControl.selectedSegmentIndex;
  [self _updateTipPercentage:selectedIndex];
}

- (void)showSettings {
  TCSettingsViewController *settingsViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Settings"];
  settingsViewController.delegate = self;
  settingsViewController.selectedIndex = self._tipPercentageControl.selectedSegmentIndex;
  [self.navigationController pushViewController:settingsViewController animated:YES];
}

#pragma mark Private

- (void)_updateTipPercentage:(NSInteger)selectedIndex {
  if(selectedIndex == 0) {
    self._tipPercent = 15;
  } else if(selectedIndex == 1) {
    self._tipPercent = 20;
  } else if(selectedIndex == 2) {
    self._tipPercent = 25;
  }
  [self _updateTipForAmount:[self._billAmountTextField.text doubleValue]];
  [self._tipPercentageControl setSelectedSegmentIndex:selectedIndex];
  
}

- (void)_updateTipForAmount:(double)billAmount {
    double tip = [self _tipForAmount:billAmount];
    [self._totalAmountLabel setText:[NSString stringWithFormat:@"$%.2f", (billAmount + tip)]];
    [self._tipAmountLabel setText:[NSString stringWithFormat:@"$%.2f", tip]];
    self.plusLabel.text = @"+";
    self.equalLabel.text = @"=";
}

- (double)_tipForAmount:(double)amount {
  double tip = (amount * self._tipPercent) / 100;
  return tip;
}

#pragma mark TCSettingsViewControllerDelegate

- (void)tipPercentChanged:(NSInteger)selectedIndex {
  [self _updateTipPercentage: selectedIndex];
}

#pragma mark UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
  NSMutableString *inputAmount = [textField.text mutableCopy];
  
  if([string isEqualToString:@""]) {
    [inputAmount deleteCharactersInRange:range];
  } else {
    [inputAmount appendString:string];
  }
  
  double amount = [inputAmount doubleValue];
  [self _updateTipForAmount:amount];
  return YES;
}

#pragma mark keyboard notifications delegate

- (void)keyboardWillShow:(NSNotification *)notification {
  self.tipAmountView.hidden = NO;
}
@end
