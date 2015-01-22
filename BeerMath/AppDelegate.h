//
//  AppDelegate.h
//  BeerMath
//
//  Created by Bryan Heath on 1/14/15.
//  Copyright (c) 2015 Bryan Heath. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BHCoreDataHelper.h"

@class User, Drink, DrinkSize;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (nonatomic, strong) UIWindow *window;
@property (nonatomic, strong) User *currentUser;
@property (nonatomic, strong, readonly) BHCoreDataHelper *coreDataHelper;
- (BHCoreDataHelper *)cdh;
- (void)newDrink:(Drink *)drink withSize:(DrinkSize *)size quanity:(NSNumber *)quanity;
- (void)editDrink:(Drink *)drink withSize:(DrinkSize *)size quanity:(NSNumber *)quanity objectID:(NSManagedObjectID *)objectID;

@end

