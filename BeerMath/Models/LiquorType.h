//
//  LiquorType.h
//  BeerMath
//
//  Created by Bryan Heath on 1/15/15.
//  Copyright (c) 2015 Bryan Heath. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Liquor;

@interface LiquorType : NSManagedObject

@property (nonatomic, retain) NSString * subtypeName;
@property (nonatomic, retain) NSSet *liquors;
@end

@interface LiquorType (CoreDataGeneratedAccessors)

- (void)addLiquorsObject:(Liquor *)value;
- (void)removeLiquorsObject:(Liquor *)value;
- (void)addLiquors:(NSSet *)values;
- (void)removeLiquors:(NSSet *)values;

@end
