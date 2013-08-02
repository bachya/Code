//
//  BAPViewController.h
//  Button Fun
//
//  Created by Aaron Bach on 7/20/13.
//  Copyright (c) 2013 Aaron Bach. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BAPViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *numberField;
@property (weak, nonatomic) IBOutlet UILabel *sliderValue;
@property (weak, nonatomic) IBOutlet UISwitch *leftSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *rightSwitch;

- (IBAction)toggleControls:(UISegmentedControl *)sender;
- (IBAction)slideMe:(UISlider *)sender;
- (IBAction)textFieldDoneEditing:(id)sender;
- (IBAction)backgroundTap:(id)sender;
@end
