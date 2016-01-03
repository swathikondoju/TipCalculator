//
//  TCSettingsViewController.h
//  TipCalculator
//
//  Created by Swathi Kondoju on 1/2/16.
//  Copyright © 2016 Swathi Kondoju. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TCSettingsViewControllerDelegate <NSObject>

- (void)tipPercentChanged:(NSInteger)selectedIndex;

@end

@interface TCSettingsViewController : UIViewController

@property (assign, nonatomic) NSInteger selectedIndex;
@property (weak, nonatomic) id delegate;

@end
