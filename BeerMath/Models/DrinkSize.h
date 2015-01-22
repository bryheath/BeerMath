//
//  DrinkSize.h
//  BeerMath
//
//  Created by Bryan Heath on 1/15/15.
//  Copyright (c) 2015 Bryan Heath. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ConsumedDrink;

@interface DrinkSize : NSManagedObject

@property (nonatomic, retain) NSDecimalNumber * size;
@property (nonatomic, retain) NSString * sizeDescription;
@property (nonatomic, retain) NSSet *consumedDrink;
@end

@interface DrinkSize (CoreDataGeneratedAccessors)

- (void)addConsumedDrinkObject:(ConsumedDrink *)value;
- (void)removeConsumedDrinkObject:(ConsumedDrink *)value;
- (void)addConsumedDrink:(NSSet *)values;
- (void)removeConsumedDrink:(NSSet *)values;

@end
