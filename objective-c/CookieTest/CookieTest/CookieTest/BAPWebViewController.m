//
//  BAPWebViewController.m
//  CookieTest
//
//  Created by Aaron Bach on 8/6/13.
//  Copyright (c) 2013 Aaron Bach. All rights reserved.
//

#import "BAPWebViewController.h"

@interface BAPWebViewController ()

@end

@implementation BAPWebViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    NSURLRequest *r = [NSURLRequest requestWithURL:[NSURL URLWithString:@"https://accounts.google.com/ServiceLogin"]];
    [self.webView loadRequest:r];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
