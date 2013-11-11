//
//  BAPAnimatedProgressWheel.m
//  BAPAnimatedProgressWheel
//
//  Created by Aaron Bach on 8/15/13.
//  Copyright (c) 2013 Aaron Bach. All rights reserved.
//

#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)

#import "BAPAnimatedProgressWheel.h"
#import "TPPropertyAnimation.h"
#import <QuartzCore/QuartzCore.h>

@interface BAPAnimatedProgressWheel()

@property (nonatomic) BOOL isComplete;

@end

@implementation BAPAnimatedProgressWheel

- (void)drawRect:(CGRect)rect
{
    CGPoint center = CGPointMake(rect.size.width/2, rect.size.height/2);
    CGFloat radius = MIN(rect.size.width, rect.size.height)/2;
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    [path moveToPoint:center];
    [path addArcWithCenter:center
                    radius:radius
                startAngle:0 - M_PI_2 // zero degrees is east, not north, so subtract pi/2
                  endAngle:2 * M_PI * self.progress - M_PI_2 // ditto
                 clockwise:YES];
    [path closePath];
    
    if (self.progress == 1.0f) {
        switch (self.completionIcon) {
            case kSymbolCheckmark: {
                
                /*
                 First draw a tick that looks like this:
                 
                 A---F
                 |   |
                 |   E-------D
                 |           |
                 B-----------C
                 
                 (Remember: (0,0) is top left)
                 */
                
                UIBezierPath *tickPath = [UIBezierPath bezierPath];
                CGFloat tickWidth = radius/3;
                [tickPath moveToPoint:CGPointMake(0, 0)];                            // A
                [tickPath addLineToPoint:CGPointMake(0, tickWidth * 2)];             // B
                [tickPath addLineToPoint:CGPointMake(tickWidth * 3, tickWidth * 2)]; // C
                [tickPath addLineToPoint:CGPointMake(tickWidth * 3, tickWidth)];     // D
                [tickPath addLineToPoint:CGPointMake(tickWidth, tickWidth)];         // E
                [tickPath addLineToPoint:CGPointMake(tickWidth, 0)];                 // F
                [tickPath closePath];
                
                // Now rotate it through -45 degrees...
                [tickPath applyTransform:CGAffineTransformMakeRotation(-M_PI_4)];
                
                // ...and move it into the right place.
                [tickPath applyTransform:CGAffineTransformMakeTranslation(radius * 0.43, radius)];
                
                // Account for non-square views
                CGFloat xOffset = rect.size.width/2 - radius;
                CGFloat yOffset = rect.size.height/2 - radius;
                [tickPath applyTransform:CGAffineTransformMakeTranslation(xOffset, yOffset)];
                
                // Add the tick path to the existing circle path
                [path appendPath:tickPath];
                
                break;

            }
            case kSymbolXMark: {
                
                /*
                 First draw a tick that looks like this:
                 
                    A---L
                    |   |
                 C--B   K--J
                 |         |
                 D--E   H--I
                    |   |
                    F---G
                 
                 (Remember: (0,0) is top left)
                 */
                
                UIBezierPath *xPath = [UIBezierPath bezierPath];
                CGFloat tickWidth = radius/2.5;
                
                [xPath moveToPoint:CGPointMake(tickWidth, 0.0f)];                     // A
                [xPath addLineToPoint:CGPointMake(tickWidth, tickWidth)];             // B
                [xPath addLineToPoint:CGPointMake(0.0f, tickWidth)];                  // C
                [xPath addLineToPoint:CGPointMake(0.0f, tickWidth * 2)];              // D
                [xPath addLineToPoint:CGPointMake(tickWidth, tickWidth * 2)];         // E
                [xPath addLineToPoint:CGPointMake(tickWidth, tickWidth * 3)];         // F
                [xPath addLineToPoint:CGPointMake(tickWidth * 2, tickWidth * 3)];     // G
                [xPath addLineToPoint:CGPointMake(tickWidth * 2, tickWidth * 2)];     // H
                [xPath addLineToPoint:CGPointMake(tickWidth * 3, tickWidth * 2)];     // I
                [xPath addLineToPoint:CGPointMake(tickWidth * 3, tickWidth)];         // J
                [xPath addLineToPoint:CGPointMake(tickWidth * 2, tickWidth)];         // K
                [xPath addLineToPoint:CGPointMake(tickWidth * 2, 0.0f)];              // L
                
                [xPath applyTransform:CGAffineTransformMakeRotation(-M_PI_4)];
                [xPath applyTransform:CGAffineTransformMakeTranslation(radius * 0.17, radius)];
                
                CGFloat xOffset = rect.size.width/2 - radius;
                CGFloat yOffset = rect.size.height/2 - radius;
                [xPath applyTransform:CGAffineTransformMakeTranslation(xOffset, yOffset)];
                
                [path appendPath:xPath];
                
                break;
            }
            default:
                break;
        }
        
        _isComplete = YES;
    };
    
    path.usesEvenOddFillRule = YES;
    [self.fillColor setFill];
    [path fill];
}

- (void)initProperties
{
    self.fillColor = [UIColor blackColor];
    self.progress = 0.0f;
    self.progressColor = [UIColor whiteColor];
    
    // Unless otherwise specified, the default is
    // to show a checkmark upon completion.
    self.completionIcon = kSymbolCheckmark;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initProperties];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initProperties];
    }
    return self;
}

- (void)setProgress:(CGFloat)progress
{
    if (progress > 1.0f) {
        progress = 1.0f;
    }
    
    if (_progress != progress) {
        _progress = progress;
        [self setNeedsDisplay];
    }
    
}

- (void)setProgress:(CGFloat)progress
      withAnimation:(TPPropertyAnimationTiming)animation
           duration:(CGFloat)duration
              delay:(CGFloat)delay
{
    TPPropertyAnimation *anim = [TPPropertyAnimation propertyAnimationWithKeyPath:@"progress"];
    anim.fromValue = @(_progress);
    anim.toValue = @(progress);
    anim.duration =duration;
    anim.startDelay = delay;
    anim.timing = animation;
    [anim beginWithTarget:self];
}

@end
