//
//  WineType.h
//  BeerMath
//
//  Created by Bryan Heath on 1/15/15.
//  Copyright (c) 2015 Bryan Heath. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Wine;

@interface WineType : NSManagedObject

@property (nonatomic, retain) NSString * subtypeName;
@property (nonatomic, retain) NSSet *wines;
@end

@interface WineType (CoreDataGeneratedAccessors)

- (void)addWinesObject:(Wine *)value;
- (void)removeWinesObject:(Wine *)value;
- (void)addWines:(NSSet *)values;
- (void)removeWines:(NSSet *)values;

@end
