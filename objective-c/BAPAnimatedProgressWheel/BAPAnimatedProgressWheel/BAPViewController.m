//
//  BAPViewController.m
//  BAPAnimatedProgressWheel
//
//  Created by Aaron Bach on 8/15/13.
//  Copyright (c) 2013 Aaron Bach. All rights reserved.
//

#import "BAPAnimatedProgressWheel.h"
#import "BAPViewController.h"

@interface BAPViewController ()

@end

@implementation BAPViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)animate:(id)sender
{
    [self.progressWheel setProgress:1.0f withAnimation:TPPropertyAnimationTimingEaseOut duration:2.0f delay:0.0f];
}
@end
