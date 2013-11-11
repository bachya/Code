//
//  BAPWebViewController.h
//  CookieTest
//
//  Created by Aaron Bach on 8/6/13.
//  Copyright (c) 2013 Aaron Bach. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BAPWebViewController : UIViewController <UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end
