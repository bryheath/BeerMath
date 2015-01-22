//
//  BHFormatter.m
//  BeerMath
//
//  Created by Bryan Heath on 1/14/15.
//  Copyright (c) 2015 Bryan Heath. All rights reserved.
//

#import "BHFormatter.h"

@implementation BHFormatter
#define debug 0

//=======================================================
#pragma mark - sharedStore
//=======================================================

+ (BHFormatter *)sharedStore {
    if (debug == 1) NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    
    static BHFormatter *sharedStore = nil;
    if (!sharedStore)
        sharedStore = [[super allocWithZone:nil] init];
    return sharedStore;
}

+ (id)allocWithZone:(NSZone *)zone {
    if (debug == 1) NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    return [self sharedStore];
}

//=======================================================
#pragma mark - NSNumberFormatter
//=======================================================

- (NSNumberFormatter *)numberFormatterWith:(NSNumberFormatterStyle)formatterStyle
                               padPosition:(NSNumberFormatterPadPosition)paddingPosition
                         minFractionDigits:(NSUInteger)minimumFractionDigits
                         maxFractionDigits:(NSUInteger)maximumFractionDigits
                          minIntegerDigits:(NSUInteger)minimumIntegerDigits
                          maxIntegerDigits:(NSUInteger)maximumIntegerDigits {
    if (debug == 1) NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    if (formatterStyle)        formatter.numberStyle           = formatterStyle;
    if (paddingPosition)       formatter.paddingPosition       = paddingPosition;
    if (minimumFractionDigits) formatter.minimumFractionDigits = minimumFractionDigits;
    if (maximumFractionDigits) formatter.maximumFractionDigits = maximumFractionDigits;
    if (minimumIntegerDigits)  formatter.minimumIntegerDigits  = minimumIntegerDigits;
    if (maximumIntegerDigits)  formatter.maximumIntegerDigits  = maximumIntegerDigits;
    
    return formatter;
}

@end
