//
//  Drink.h
//  BeerMath
//
//  Created by Bryan Heath on 1/15/15.
//  Copyright (c) 2015 Bryan Heath. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ConsumedDrink, DrinkType;

@interface Drink : NSManagedObject

@property (nonatomic, retain) NSDecimalNumber * drinkABV;
@property (nonatomic, retain) NSString * drinkName;
@property (nonatomic, retain) NSString * drinkOrigin;
@property (nonatomic, retain) NSSet *consumedDrink;
@property (nonatomic, retain) DrinkType *drinkType;
@end

@interface Drink (CoreDataGeneratedAccessors)

- (void)addConsumedDrinkObject:(ConsumedDrink *)value;
- (void)removeConsumedDrinkObject:(ConsumedDrink *)value;
- (void)addConsumedDrink:(NSSet *)values;
- (void)removeConsumedDrink:(NSSet *)values;

@end
