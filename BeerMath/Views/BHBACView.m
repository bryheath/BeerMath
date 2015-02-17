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
#define viewBuffer 5.0
#define circleOneThickness 3.0
#define circleTwoThickness 5.0
#define circleThreeThickness 1.0
#define circleFourThickness 1.0
- (void)drawRect:(CGRect)rect {
    CGFloat startingRadius = self.frame.size.width/2.0 - viewBuffer;
    //Outer Circle - Outer Border
    [self drawCircleWithStrokeColor:[UIColor blueColor]
                          fillColor:[UIColor clearColor]
                             radius:startingRadius
                       andThickness:circleOneThickness];
    //Circle Two - Clear Circle
    [self drawCircleWithStrokeColor:[UIColor clearColor]
                          fillColor:[UIColor clearColor]
                             radius:startingRadius - circleOneThickness
                       andThickness:circleTwoThickness];
    //Circle Three - Inner Border
    [self drawCircleWithStrokeColor:[UIColor greenColor]
                          fillColor:[UIColor clearColor]
                             radius:startingRadius - circleOneThickness - circleTwoThickness
                       andThickness:circleThreeThickness];
    //Circle Four - Filled Circle
    [self drawCircleWithStrokeColor:[UIColor clearColor]
                          fillColor:[UIColor blueColor]
                             radius:startingRadius - circleOneThickness - circleTwoThickness - circleThreeThickness
                       andThickness:circleFourThickness];
}

- (void)drawCircleWithStrokeColor:(UIColor *)sColor fillColor:(UIColor *)fColor radius:(CGFloat)radius andThickness:(CGFloat)thickness
{
    CGPoint center = CGPointMake(self.frame.size.width / 2.0, self.frame.size.height / 2.0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextBeginPath(context);
    if (sColor) {
        CGContextSetStrokeColorWithColor(context, sColor.CGColor);
    } else {
        CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
    }
    if (fColor) {
        CGContextSetFillColorWithColor(context, fColor.CGColor);
    }
    if (thickness) {
        CGContextSetLineWidth(context, thickness);
    } else {
        CGContextSetLineWidth(context, 1.0);
    }
    CGContextAddArc(context, center.x, center.y, radius, 0, 2*M_PI, 0);
    CGContextDrawPath(context, kCGPathFillStroke);
}


@end
