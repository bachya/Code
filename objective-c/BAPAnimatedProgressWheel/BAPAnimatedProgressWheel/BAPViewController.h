//
//  BAPViewController.h
//  BAPAnimatedProgressWheel
//
//  Created by Aaron Bach on 8/15/13.
//  Copyright (c) 2013 Aaron Bach. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BAPAnimatedProgressWheel;

@interface BAPViewController : UIViewController
@property (weak, nonatomic) IBOutlet BAPAnimatedProgressWheel *progressWheel;

- (IBAction)animate:(id)sender;

@end
