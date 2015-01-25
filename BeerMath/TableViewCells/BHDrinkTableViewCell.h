//
//  BHDrinkTableViewCell.h
//  BeerMath
//
//  Created by Bryan Heath on 1/22/15.
//  Copyright (c) 2015 Bryan Heath. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Drink.h"

@interface BHDrinkTableViewCell : UITableViewCell

@property (nonatomic, assign) NSUInteger        index;
@property (nonatomic, assign) int               quanity;
@property (nonatomic, assign) id                delegate;

@property (nonatomic, strong) Drink             *drink;
@property (nonatomic, strong) NSNumber          *size;

@property (nonatomic, strong) IBOutlet UILabel    *quanityLabel;
@property (nonatomic, strong) IBOutlet UILabel    *nameLabel;
@property (nonatomic, strong) IBOutlet UILabel    *sizeLabel;
@property (nonatomic, strong) IBOutlet UILabel    *typeLabel;

- (IBAction)changeQuanity:(UIButton *)sender;

@end