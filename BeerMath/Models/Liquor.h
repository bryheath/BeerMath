//
//  Liquor.h
//  BeerMath
//
//  Created by Bryan Heath on 1/15/15.
//  Copyright (c) 2015 Bryan Heath. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Drink.h"

@class LiquorType;

@interface Liquor : Drink

@property (nonatomic, retain) NSNumber * liquorProof;
@property (nonatomic, retain) LiquorType *liquorTypes;

@end
