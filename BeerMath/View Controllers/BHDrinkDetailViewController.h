//
//  BHDrinkDetailViewController.h
//  BeerMath
//
//  Created by Bryan Heath on 1/19/15.
//  Copyright (c) 2015 Bryan Heath. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BHCoreDataHelper.h"

@class Drink, DrinkSize;

@interface BHDrinkDetailViewController : UIViewController

@property (nonatomic, assign) BOOL editFlag;
@property (nonatomic, strong) Drink *drink;
@property (nonatomic, strong) DrinkSize *drinkSize;
@property (nonatomic, strong) NSNumber  *quanity;
@property (nonatomic, strong) NSManagedObjectID *drinkID;

@end
