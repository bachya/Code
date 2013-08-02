//
//  BAPViewController.h
//  SlowWorker
//
//  Created by Aaron Bach on 7/31/13.
//  Copyright (c) 2013 Aaron Bach. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BAPViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UITextView *resultsTextView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;

- (IBAction)doWork:(id)sender;
@end
