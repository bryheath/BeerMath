//
//  BeerType.h
//  BeerMath
//
//  Created by Bryan Heath on 1/15/15.
//  Copyright (c) 2015 Bryan Heath. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Beer;

@interface BeerType : NSManagedObject

@property (nonatomic, retain) NSString * subtypeName;
@property (nonatomic, retain) NSSet *beers;
@end

@interface BeerType (CoreDataGeneratedAccessors)

- (void)addBeersObject:(Beer *)value;
- (void)removeBeersObject:(Beer *)value;
- (void)addBeers:(NSSet *)values;
- (void)removeBeers:(NSSet *)values;

@end
