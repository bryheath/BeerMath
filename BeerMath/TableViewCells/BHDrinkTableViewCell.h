//
//  BHDrinkTableViewCell.h
//  BeerMath
//
//  Created by Bryan Heath on 1/22/15.
//  Copyright (c) 2015 Bryan Heath. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Drink.h"
#import "ConsumedDrink.h"
@interface BHDrinkTableViewCell : UITableViewCell

@property (nonatomic, strong) ConsumedDrink     *consumedDrink;
@property (nonatomic, assign) id                delegate;

- (IBAction)changeQuanity:(UIButton *)sender;

@end