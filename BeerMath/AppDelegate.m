//
//  AppDelegate.m
//  BeerMath
//
//  Created by Bryan Heath on 1/14/15.
//  Copyright (c) 2015 Bryan Heath. All rights reserved.
//

#import "AppDelegate.h"
#import "BHConstants.h"
#import "BHFormatter.h"
#import "BHHomeViewController.h"
#import "MMDrawerController.h"
#import "MMDrawerVisualState.h"
#import "BeerSize.h"
#import "WineSize.h"
#import "LiquorSize.h"
#import "Liquor.h"
#import "Beer.h"
#import "Drink.h"
#import "User.h"
#import "ConsumedDrink.h"
#import "DrinkType.h"
#import "LiquorType.h"

@interface AppDelegate ()

@end

@implementation AppDelegate
#define debug 0

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    if (debug == 1) NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    
    MMDrawerController *drawerController = (MMDrawerController*)self.window.rootViewController;
    [drawerController setMaximumLeftDrawerWidth:150.0];
//    [drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
//    [drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
    [drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
    [drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeNone];

    [self cdh];
    //[self demo];

    NSNumber *defaultUserID = [[NSUserDefaults standardUserDefaults] objectForKey:@"defaultUserID"];
    NSError *error = nil;
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    request.entity = [NSEntityDescription entityForName:@"User"
                                 inManagedObjectContext:_coreDataHelper.context];
    request.predicate = [NSPredicate predicateWithFormat:@"userID == %@", defaultUserID];
    request.fetchBatchSize = 1;
    
    NSUInteger count = [_coreDataHelper.context countForFetchRequest:request error:&error];
    
    if (count == NSNotFound) {
        NSLog(@"Error: %@", error.localizedDescription);
    } else if (count == 0) {
        self.currentUser = [self createUser:nil withWeight:nil andGender:kUserGenderMale];
        NSLog(@"userID: %@", self.currentUser.userID);
        [[NSUserDefaults standardUserDefaults] setObject:self.currentUser.userID forKey:@"defaultUserID"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    } else {
        self.currentUser = (User *)[[_coreDataHelper.context executeFetchRequest:request
                                                                           error:&error] firstObject];
    }
    //NSLog(@"%@, %@, %@, %@", self.currentUser.userName, self.currentUser.userID, self.currentUser.userWeight, self.currentUser.gender);
    return YES;
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    if (debug == 1) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
    [[self cdh] saveContext];
}
- (void)applicationWillTerminate:(UIApplication *)application {
    if (debug == 1) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
    [[self cdh] saveContext];
}
- (void)applicationDidBecomeActive:(UIApplication *)application {
    if (debug == 1) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
    
    //    [self fetchStuff];
}
- (void)demo {
    NSArray *beerSizes = @[@[@(1.5), @"oz", @"Single Shot"],
                           @[@(2.4), @"oz", @"Pong Cup"],
                           @[@(6.0), @"oz", @"Half Can"],
                           @[@(8.0), @"oz", @"Small Can"],
                           @[@(12), @"oz", @"Can/Bottle"],
                           @[@(16), @"oz", @"US Pint"],
                           @[@(24), @"oz", @"Large Mug"],
                           @[@(32), @"oz", @"Large Container"],
                           @[@(40), @"oz", @"Larger Container"]];
    
    NSArray *liquorSizes = @[@[@(0.5), @"oz", @"Splash"],
                             @[@(1.0), @"oz", @"Small"],
                             @[@(1.25), @"oz", @"Cheap"],
                             @[@(1.5), @"oz", @"Single"],
                             @[@(2.5), @"oz", @"Double Cheap"],
                             @[@(3.0), @"oz", @"Double"],
                             @[@(3.75), @"oz", @"Triple Cheap"],
                             @[@(4.5), @"oz", @"Triple"]];
    
    NSArray *wineSizes = @[@[@(4.0), @"oz", @"Small"],
                           @[@(5.0), @"oz", @"Single"],
                           @[@(8.0), @"oz", @"Full Red Glass"],
                           @[@(12.0), @"oz", @"Full White Glass"]];
    
    for (NSArray *size in beerSizes) {
        BeerSize *newSize = [NSEntityDescription insertNewObjectForEntityForName:@"BeerSize"
                                                          inManagedObjectContext:_coreDataHelper.context];
        newSize.size = size[0];
        newSize.sizeDescription = size[2];
        NSLog(@"Inserted New Managed Object for '%@, %@'", newSize.size, newSize.sizeDescription);
    }
    for (NSArray *size in liquorSizes) {
        LiquorSize *newSize = [NSEntityDescription insertNewObjectForEntityForName:@"LiquorSize"
                                                            inManagedObjectContext:_coreDataHelper.context];
        newSize.size = size[0];
        newSize.sizeDescription = size[2];
        NSLog(@"Inserted New Managed Object for '%@, %@'", newSize.size, newSize.sizeDescription);
    }
    for (NSArray *size in wineSizes) {
        WineSize *newSize = [NSEntityDescription insertNewObjectForEntityForName:@"WineSize"
                                                          inManagedObjectContext:_coreDataHelper.context];
        newSize.size = size[0];
        newSize.sizeDescription = size[2];
        NSLog(@"Inserted New Managed Object for '%@, %@'", newSize.size, newSize.sizeDescription);
    }
    
    NSDictionary *beerDictionary = [[NSDictionary alloc] initWithContentsOfFile:
                                    [[NSBundle mainBundle] pathForResource:@"Beers" ofType:@"plist"]];
    NSDictionary *vodkaDictionary = [[NSDictionary alloc] initWithContentsOfFile:
                                     [[NSBundle mainBundle] pathForResource:@"Vodka" ofType:@"plist"]];
    NSDictionary *tequilaDictionary = [[NSDictionary alloc] initWithContentsOfFile:
                                       [[NSBundle mainBundle] pathForResource:@"Tequila" ofType:@"plist"]];
    NSDictionary *liqueurDictionary = [[NSDictionary alloc] initWithContentsOfFile:
                                       [[NSBundle mainBundle] pathForResource:@"Liqueur" ofType:@"plist"]];
    NSDictionary *rumDictionary = [[NSDictionary alloc] initWithContentsOfFile:
                                   [[NSBundle mainBundle] pathForResource:@"Rum" ofType:@"plist"]];
    NSDictionary *ginDictionary = [[NSDictionary alloc] initWithContentsOfFile:
                                   [[NSBundle mainBundle] pathForResource:@"Gin" ofType:@"plist"]];
    NSDictionary *whiskeyDictionary = [[NSDictionary alloc] initWithContentsOfFile:
                                       [[NSBundle mainBundle] pathForResource:@"Whiskey" ofType:@"plist"]];
    //NSDictionary *genericsDictionary = [[NSDictionary alloc] initWithContentsOfFile:
    //[[NSBundle mainBundle] pathForResource:@"Generics" ofType:@"plist"]];
    NSArray *arrayOfDictionaries = @[vodkaDictionary, tequilaDictionary, liqueurDictionary, rumDictionary, ginDictionary, whiskeyDictionary];
    
    [beerDictionary enumerateKeysAndObjectsUsingBlock:^(id beerKey, NSDictionary *beer, BOOL *stop) {
        NSLog(@"beer: %@", beerKey);
        NSLog(@"beerObj: %@", beer);
        Beer *newBeer = [NSEntityDescription insertNewObjectForEntityForName:@"Beer"
                                                      inManagedObjectContext:_coreDataHelper.context];
        newBeer.drinkName = [beer objectForKey:@"drinkName"];
        newBeer.drinkOrigin = [beer objectForKey:@"drinkOrigin"];
        newBeer.drinkABV = [beer objectForKey:@"drinkABV"];
        //===================================================================
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"DrinkType"];
        [request setPredicate:[NSPredicate predicateWithFormat:@"typeName = %@", [beer objectForKey:@"drinkType"]]];
        [request setFetchLimit:1];
        NSError *error = nil;
        NSUInteger count = [_coreDataHelper.context countForFetchRequest:request error:&error];
        if (count == NSNotFound) {
            NSLog(@"Error: %@", error.localizedDescription);
        } else if (count == 0) {
            DrinkType *newType = [NSEntityDescription insertNewObjectForEntityForName:@"DrinkType"
                                                               inManagedObjectContext:_coreDataHelper.context];
            newType.typeName = [beer objectForKey:@"drinkType"];
            newBeer.drinkType = newType;
        } else {
            DrinkType *oldType = [[_coreDataHelper.context executeFetchRequest:request error:&error] lastObject];
            newBeer.drinkType = oldType;
        }
    }];
    
    
    for (NSDictionary *dictionary in arrayOfDictionaries) {
        [dictionary enumerateKeysAndObjectsUsingBlock:^(id liquorKey, NSDictionary *liquor, BOOL *stop) {
            NSLog(@"liquor: %@", liquorKey);
            NSLog(@"obj: %@", liquor);
            Liquor *newLiquor = [NSEntityDescription insertNewObjectForEntityForName:@"Liquor"
                                                              inManagedObjectContext:_coreDataHelper.context];
            newLiquor.drinkName = [liquor objectForKey:@"drinkName"];
            newLiquor.drinkOrigin = [liquor objectForKey:@"drinkOrigin"];
            newLiquor.drinkABV = [[NSDecimalNumber alloc] initWithString:[liquor objectForKey:@"drinkABV"]];
            newLiquor.liquorProof = [NSDecimalNumber numberWithFloat:[newLiquor.drinkABV floatValue] * 2.0];
            
            //===================================================================
            NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"DrinkType"];
            [request setPredicate:[NSPredicate predicateWithFormat:@"typeName = %@", [liquor objectForKey:@"drinkType"]]];
            [request setFetchLimit:1];
            NSError *error = nil;
            NSUInteger count = [_coreDataHelper.context countForFetchRequest:request error:&error];
            if (count == NSNotFound) {
                NSLog(@"Error: %@", error.localizedDescription);
            } else if (count == 0) {
                DrinkType *newType = [NSEntityDescription insertNewObjectForEntityForName:@"DrinkType"
                                                                   inManagedObjectContext:_coreDataHelper.context];
                newType.typeName = [liquor objectForKey:@"drinkType"];
                newLiquor.drinkType = newType;
            } else {
                DrinkType *oldType = [[_coreDataHelper.context executeFetchRequest:request error:&error] lastObject];
                newLiquor.drinkType = oldType;
            }
            //===================================================================
            request = [NSFetchRequest fetchRequestWithEntityName:@"LiquorType"];
            [request setPredicate:[NSPredicate predicateWithFormat:@"subtypeName = %@", [liquor objectForKey:@"liquorType"]]];
            [request setFetchLimit:1];
            error = nil;
            count = [_coreDataHelper.context countForFetchRequest:request error:&error];
            if (count == NSNotFound) {
                NSLog(@"Error: %@", error.localizedDescription);
            } else if (count == 0) {
                LiquorType *newLiquorType = [NSEntityDescription insertNewObjectForEntityForName:@"LiquorType"
                                                                          inManagedObjectContext:_coreDataHelper.context];
                newLiquorType.subtypeName = [liquor objectForKey:@"liquorType"];
                newLiquor.liquorTypes = newLiquorType;
            } else {
                LiquorType *oldLiquorType = [[_coreDataHelper.context executeFetchRequest:request error:&error] lastObject];
                newLiquor.liquorTypes = oldLiquorType;
            }
            //===================================================================
        }];
    }
}
- (void)fetchStuff {
    NSFetchRequest *request1 = [NSFetchRequest fetchRequestWithEntityName:@"BeerSize"];
    NSArray *fetchedObjects1 = [_coreDataHelper.context executeFetchRequest:request1 error:nil];
    for (BeerSize *size in fetchedObjects1) {
        NSLog(@"%@oz, %@", size.size, size.sizeDescription);
    }
    NSFetchRequest *request2 = [NSFetchRequest fetchRequestWithEntityName:@"LiquorSize"];
    NSArray *fetchedObjects2 = [_coreDataHelper.context executeFetchRequest:request2 error:nil];
    for (LiquorSize *size in fetchedObjects2) {
        NSLog(@"%@oz, %@", size.size, size.sizeDescription);
    }
    NSFetchRequest *request3 = [NSFetchRequest fetchRequestWithEntityName:@"WineSize"];
    NSArray *fetchedObjects3 = [_coreDataHelper.context executeFetchRequest:request3 error:nil];
    for (WineSize *size in fetchedObjects3) {
        NSLog(@"%@oz, %@", size.size, size.sizeDescription);
    }
    NSFetchRequest *request4 = [NSFetchRequest fetchRequestWithEntityName:@"Drink"];
    NSArray *fetchedObjects4 = [_coreDataHelper.context executeFetchRequest:request4 error:nil];
    for (Drink *drink in fetchedObjects4) {
        NSLog(@"Drink: %@", drink.drinkName);
    }
}
- (BHCoreDataHelper *)cdh {
    if (debug == 1) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
    if (!_coreDataHelper) {
        static dispatch_once_t predicate;
        dispatch_once(&predicate, ^{
            _coreDataHelper = [[BHCoreDataHelper alloc] init];
        });
        [_coreDataHelper setupCoreData];
    }
    return _coreDataHelper;
}
- (void)newDrink:(Drink *)drink withSize:(DrinkSize *)size quanity:(NSNumber *)quanity {
    ConsumedDrink *consumedDrink = [NSEntityDescription insertNewObjectForEntityForName:@"ConsumedDrink"
                                                                 inManagedObjectContext:_coreDataHelper.context];
    consumedDrink.drink = drink;
    consumedDrink.size = size;
    consumedDrink.quanity = quanity;
    consumedDrink.dateCreated = [NSDate date];
    [self.currentUser addConsumedDrinksObject:consumedDrink];
    [self.cdh saveContext];
}
- (void)editDrink:(Drink *)drink withSize:(DrinkSize *)size quanity:(NSNumber *)quanity objectID:(NSManagedObjectID *)objectID {
    NSError *error = nil;
    ConsumedDrink *consumedDrink = (ConsumedDrink *)[_coreDataHelper.context existingObjectWithID:objectID
                                                                                            error:&error];
    if (consumedDrink.drink != drink)
        consumedDrink.drink = drink;
    consumedDrink.size = size;
    consumedDrink.quanity = quanity;
    [self.cdh saveContext];
}
- (User *)createUser:(NSString *)name withWeight:(NSDecimalNumber *)weight andGender:(BOOL)gender {
    User *user = [NSEntityDescription insertNewObjectForEntityForName:@"User"
                                               inManagedObjectContext:_coreDataHelper.context];
    if (!name) user.userName = @"Default User";
    else user.userName = name;
    
    if (!weight) user.userWeight = [[NSDecimalNumber alloc] initWithFloat:150.0];
    else user.userWeight = weight;
    
    if (!gender) user.gender = [NSNumber numberWithBool:YES]; //Male
    else user.gender = [NSNumber numberWithBool:gender];
    
    user.startTime = [NSDate date];
    user.dontAsk   = [NSNumber numberWithBool:YES];
    user.userID = [[NSNumber alloc] initWithUnsignedInt:(u_int32_t)arc4random()];

    return user;
}

- (NSNumber *)calculate:(NSNumber *)timePassed {
    float estimatedBAC = 0.0000;
    float genderCoEfficent = [self.currentUser.gender isEqualToNumber:@(1)] ? 0.68 : 0.55;
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"ConsumedDrink"];
    request.predicate = [NSPredicate predicateWithFormat:@"user == %@", self.currentUser];
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"dateCreated" ascending:YES]];
    NSFetchedResultsController *frc = [[NSFetchedResultsController alloc] initWithFetchRequest:request
                                                                          managedObjectContext:self.cdh.context
                                                                            sectionNameKeyPath:nil
                                                                                     cacheName:nil];
    if (frc) {
        [frc.managedObjectContext performBlockAndWait:^{
            NSError *error = nil;
            if (![frc performFetch:&error]) {
                NSLog(@"Fetch FAILED: %@", error);
            }
        }];
    } else {
        NSLog(@"Fetch FAILED");
    }
    NSArray *consumedDrinksArray = [frc fetchedObjects];
    for (int i = 0; i < [consumedDrinksArray count]; i++) {
        ConsumedDrink *consumedDrink = consumedDrinksArray[i];
        float drinkStrength = [consumedDrink.drink.drinkABV floatValue] / 100;
        float drinkSize = [consumedDrink.size.size floatValue];
        float drinkQuanity = [consumedDrink.quanity floatValue];
        const float gramsPerML = 23.36;
        const float poundsToKilograms = 0.45359237;
        float alcohol = drinkStrength * drinkSize * drinkQuanity * gramsPerML;
        estimatedBAC += (alcohol / (([self.currentUser.userWeight floatValue] * poundsToKilograms)
                                    * genderCoEfficent * 1000)) * 80.6;
    }
    estimatedBAC -= (0.015 * [timePassed floatValue]);
    if (estimatedBAC < 0.0000) estimatedBAC = 0.0000;
    return [NSNumber numberWithFloat:estimatedBAC];
}

@end

