//
//  BHFormatter.h
//  BeerMath
//
//  Created by Bryan Heath on 1/14/15.
//  Copyright (c) 2015 Bryan Heath. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BHFormatter : NSObject

+ (BHFormatter *)sharedStore;

- (NSNumberFormatter *)numberFormatterWith:(NSNumberFormatterStyle)formatterStyle
                               padPosition:(NSNumberFormatterPadPosition)paddingPosition
                         minFractionDigits:(NSUInteger)minimumFractionDigits
                         maxFractionDigits:(NSUInteger)maximumFractionDigits
                          minIntegerDigits:(NSUInteger)minimumIntegerDigits
                          maxIntegerDigits:(NSUInteger)maximumIntegerDigits;

@end
