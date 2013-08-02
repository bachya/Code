//
//  BAPViewController.m
//  Button Fun
//
//  Created by Aaron Bach on 7/20/13.
//  Copyright (c) 2013 Aaron Bach. All rights reserved.
//

#import "BAPViewController.h"


@implementation BAPViewController

- (IBAction)toggleControls:(UISegmentedControl *)sender {
}



- (IBAction)slideMe:(UISlider *)sender {
    int progress = lround(sender.value);
    self.sliderValue.text = [NSString stringWithFormat:@"%d", progress];
}

- (IBAction)textFieldDoneEditing:(id)sender {
    [sender resignFirstResponder];
}

- (IBAction)backgroundTap:(id)sender {
    [self.nameField resignFirstResponder];
    [self.numberField resignFirstResponder];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.sliderValue.text = @"50";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
