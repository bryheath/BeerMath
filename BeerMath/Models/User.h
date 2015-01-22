//
//  User.h
//  BeerMath
//
//  Created by Bryan Heath on 1/15/15.
//  Copyright (c) 2015 Bryan Heath. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ConsumedDrink;

@interface User : NSManagedObject

@property (nonatomic, retain) NSNumber * dontAsk;
@property (nonatomic, retain) NSNumber * gender;
@property (nonatomic, retain) NSDate * startTime;
@property (nonatomic, retain) NSNumber * userID;
@property (nonatomic, retain) NSString * userName;
@property (nonatomic, retain) NSDecimalNumber * userWeight;
@property (nonatomic, retain) NSSet *consumedDrinks;
@end

@interface User (CoreDataGeneratedAccessors)

- (void)addConsumedDrinksObject:(ConsumedDrink *)value;
- (void)removeConsumedDrinksObject:(ConsumedDrink *)value;
- (void)addConsumedDrinks:(NSSet *)values;
- (void)removeConsumedDrinks:(NSSet *)values;

@end
