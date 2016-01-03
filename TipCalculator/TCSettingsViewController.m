//
//  TCSettingsViewController.m
//  TipCalculator
//
//  Created by Swathi Kondoju on 1/2/16.
//  Copyright © 2016 Swathi Kondoju. All rights reserved.
//

#import "TCSettingsViewController.h"

@interface TCSettingsViewController ()
@property (weak, nonatomic) IBOutlet UISegmentedControl *_tipPercentageControl;
@end

@implementation TCSettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
  self._tipPercentageControl.selectedSegmentIndex = self.selectedIndex;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)toggleTipPercentage:(id)sender {
  self.selectedIndex = self._tipPercentageControl.selectedSegmentIndex;
  if([self.delegate respondsToSelector:@selector(tipPercentChanged:)]) {
    [self.delegate tipPercentChanged:self.selectedIndex];
  }
}
@end
