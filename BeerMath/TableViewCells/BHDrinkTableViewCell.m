//
//  BHDrinkTableViewCell.m
//  BeerMath
//
//  Created by Bryan Heath on 1/22/15.
//  Copyright (c) 2015 Bryan Heath. All rights reserved.
//

#import "AppDelegate.h"
#import "BHDrinkTableViewCell.h"
#import "DrinkSize.h"
#import "DrinkType.h"
#import "BHFormatter.h"

@interface BHDrinkTableViewCell()
@property (nonatomic, assign) NSUInteger        index;
@property (nonatomic, assign) int               quanity;

@property (nonatomic, strong) Drink             *drink;
@property (nonatomic, strong) NSNumber          *size;

@property (nonatomic, strong) IBOutlet UILabel    *quanityLabel;
@property (nonatomic, strong) IBOutlet UILabel    *nameLabel;
@property (nonatomic, strong) IBOutlet UILabel    *sizeLabel;
@property (nonatomic, strong) IBOutlet UILabel    *typeLabel;
@end


@implementation BHDrinkTableViewCell

- (void)setConsumedDrink:(ConsumedDrink *)consumedDrink {
    _consumedDrink = consumedDrink;
    self.drink = _consumedDrink.drink;
    self.size = _consumedDrink.size.size;
    self.quanity = [_consumedDrink.quanity intValue];
    
    NSNumberFormatter *formatter = [[BHFormatter sharedStore] numberFormatterWith:NSNumberFormatterDecimalStyle
                                                                      padPosition:NSNumberFormatterPadAfterSuffix
                                                                minFractionDigits:0
                                                                maxFractionDigits:2
                                                                 minIntegerDigits:0
                                                                 maxIntegerDigits:4];
    self.nameLabel.text    = self.drink.drinkName;
    self.sizeLabel.text    = [NSString stringWithFormat:@"%@oz", [formatter stringFromNumber: self.size]];
    self.quanityLabel.text = [NSString stringWithFormat:@"%i", self.quanity];
    self.typeLabel.text    = self.drink.drinkType.typeName;
}

- (IBAction)changeQuanity:(UIButton *)sender {
    if ([sender.currentTitle isEqualToString:@"-"] && (self.quanity >= 1)) {
        self.quanity--;
        [(AppDelegate *)[[UIApplication sharedApplication] delegate] editDrink:self.consumedDrink.drink
                                                                      withSize:self.consumedDrink.size
                                                                       quanity:[NSNumber numberWithInt:self.quanity]
                                                                      objectID:self.consumedDrink.objectID];

        [self.delegate reloadData];
    } else if ([sender.currentTitle isEqualToString:@"+"]) {
        if (self.quanity <= 99) {
            self.quanity++;
            [(AppDelegate *)[[UIApplication sharedApplication] delegate] editDrink:self.consumedDrink.drink
                                                                          withSize:self.consumedDrink.size
                                                                           quanity:[NSNumber numberWithInt:self.quanity]
                                                                          objectID:self.consumedDrink.objectID];
            [self.delegate reloadData];
        }
    }
}

@end
