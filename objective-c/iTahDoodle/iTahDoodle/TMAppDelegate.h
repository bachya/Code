//
//  TMAppDelegate.h
//  iTahDoodle
//
//  Created by Aaron Bach on 3/11/13.
//  Copyright (c) 2013 Aaron Bach. All rights reserved.
//

#import <UIKit/UIKit.h>

NSString *docPath(void);

@interface TMAppDelegate : UIResponder <UIApplicationDelegate, UITableViewDataSource>
{
    UITableView *taskTable;
    UITextField *taskField;
    UIButton *insertButton;
    NSMutableArray *tasks;
}

@property (strong, nonatomic) UIWindow *window;

- (void)addTask:(id)sender;

@end
