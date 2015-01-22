//
//  BHBACButton.m
//  BeerMath
//
//  Created by Bryan Heath on 1/15/15.
//  Copyright (c) 2015 Bryan Heath. All rights reserved.
//

#import "BHBACButton.h"

@implementation BHBACButton

#define debug 0

- (void)drawRect:(CGRect)rect {
    if (debug == 1) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
    
    // Drawing code
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context       = UIGraphicsGetCurrentContext();
    
    UIColor *borderColor = [UIColor colorWithRed:0.20f green:0.40f blue:0.90f alpha:1.00f];
    UIColor *topColor    = [UIColor colorWithRed:0.72f green:0.72f blue:0.90f alpha:1.00f];
    UIColor *bottomColor = [UIColor colorWithRed:0.27f green:0.27f blue:0.53f alpha:1.00f];
    UIColor *innerGlow   = [UIColor colorWithWhite:1.00f alpha:0.50f];
    
    NSArray *gradientColors = (@[(id)topColor.CGColor, (id)bottomColor.CGColor]);
    
    CGGradientRef gradient =
        CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)(gradientColors), NULL);
    
    NSArray *highlightedGradientColors = (@[(id)bottomColor.CGColor, (id)topColor.CGColor]);
    
    CGGradientRef highlightedGradient =
        CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)highlightedGradientColors, NULL);
    
    UIBezierPath *roundedRectPath = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:4];
    [roundedRectPath addClip];
    
    CGGradientRef background = self.highlighted ? highlightedGradient : gradient;
    
    CGContextDrawLinearGradient(context, background, CGPointMake(rect.size.width / 2,0),
                                CGPointMake(rect.size.width / 2, rect.size.height), 0);
    
    [borderColor setStroke];
    roundedRectPath.lineWidth = 2;
    [roundedRectPath stroke];
    
    UIBezierPath *innerGlowRect = [UIBezierPath bezierPathWithRoundedRect:
                                   CGRectMake(1.5, 1.5, rect.size.width - 3, rect.size.height - 3)
                                                             cornerRadius:2.5];
    [innerGlow setStroke];
    innerGlowRect.lineWidth = 1;
    [innerGlowRect stroke];
    
    CGGradientRelease(gradient);
    CGGradientRelease(highlightedGradient);
    CGColorSpaceRelease(colorSpace);
    
}
- (void)setHighlighted:(BOOL)highlighted {
    if (debug == 1) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
    [self setNeedsDisplay];
    [super setHighlighted:highlighted];
}
@end
