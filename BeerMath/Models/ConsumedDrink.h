//
//  ConsumedDrink.h
//  BeerMath
//
//  Created by Bryan Heath on 1/15/15.
//  Copyright (c) 2015 Bryan Heath. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Drink, DrinkSize, User;

@interface ConsumedDrink : NSManagedObject

@property (nonatomic, retain) NSDate * dateCreated;
@property (nonatomic, retain) NSNumber * quanity;
@property (nonatomic, retain) Drink *drink;
@property (nonatomic, retain) DrinkSize *size;
@property (nonatomic, retain) User *user;

@end
