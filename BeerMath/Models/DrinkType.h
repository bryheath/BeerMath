//
//  DrinkType.h
//  BeerMath
//
//  Created by Bryan Heath on 1/15/15.
//  Copyright (c) 2015 Bryan Heath. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Drink;

@interface DrinkType : NSManagedObject

@property (nonatomic, retain) NSString * typeName;
@property (nonatomic, retain) NSSet *drinks;
@end

@interface DrinkType (CoreDataGeneratedAccessors)

- (void)addDrinksObject:(Drink *)value;
- (void)removeDrinksObject:(Drink *)value;
- (void)addDrinks:(NSSet *)values;
- (void)removeDrinks:(NSSet *)values;

@end
