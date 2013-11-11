//
//  BAPAnimatedProgressWheel.h
//  BAPAnimatedProgressWheel
//
//  Created by Aaron Bach on 8/15/13.
//  Copyright (c) 2013 Aaron Bach. All rights reserved.
//

#import "TPPropertyAnimation.h"
#import <UIKit/UIKit.h>

typedef enum {
    kSymbolCheckmark,
    kSymbolXMark
} SymbolType;

@interface BAPAnimatedProgressWheel : UIView

@property (nonatomic) SymbolType completionIcon;
@property (strong, nonatomic) UIColor *fillColor;
@property (nonatomic) CGFloat progress;
@property (strong, nonatomic) UIColor *progressColor;

- (void)setProgress:(CGFloat)progress
      withAnimation:(TPPropertyAnimationTiming)animation
           duration:(CGFloat)duration
              delay:(CGFloat)delay;

@end
