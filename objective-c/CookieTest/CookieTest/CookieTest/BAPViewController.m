//
//  BAPViewController.m
//  CookieTest
//
//  Created by Aaron Bach on 8/6/13.
//  Copyright (c) 2013 Aaron Bach. All rights reserved.
//

#import "BAPViewController.h"

@interface BAPViewController ()

@end

@implementation BAPViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)pushButtpn:(id)sender
{
    [self performSegueWithIdentifier:@"ShowWebView" sender:self];
}

@end
