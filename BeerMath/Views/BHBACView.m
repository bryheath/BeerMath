//
//  BHBACView.m
//  BeerMath
//
//  Created by Bryan Heath on 2/5/15.
//  Copyright (c) 2015 Bryan Heath. All rights reserved.
//

#import "BHBACView.h"
#import <CoreGraphics/CoreGraphics.h>

#define kStepX 50
#define kGraphBottom 300
#define kGraphTop 0

@implementation BHBACView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    [self drawCircleWithColor:[UIColor blueColor] andThickness:5.0];
}

- (void)drawCircleWithColor:(UIColor *)color andThickness:(CGFloat)thickness
{
    CGPoint center = CGPointMake(self.frame.size.width / 2.0, self.frame.size.height / 2.0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextBeginPath(context);
    if (color) {
        CGContextSetStrokeColorWithColor(context, color.CGColor);
    } else {
        CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
    }
    if (thickness) {
        CGContextSetLineWidth(context, thickness);
    } else {
        CGContextSetLineWidth(context, 1.0);
    }
    CGContextAddArc(context, center.x, center.y, 100.0, 0, 2*M_PI, 0);
    CGContextStrokePath(context);
}


@end
