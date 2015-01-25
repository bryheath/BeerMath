//
//  BHDrinkTableViewCell.m
//  BeerMath
//
//  Created by Bryan Heath on 1/22/15.
//  Copyright (c) 2015 Bryan Heath. All rights reserved.
//

#import "BHDrinkTableViewCell.h"

@implementation BHDrinkTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)changeQuanity:(UIButton *)sender {
//    if ([[sender currentTitle] isEqualToString:@"-"] && (self.quanity >= 1)) {
//        self.quanity--;
//        [[BAC sharedStore] editDrink:self.drink
//                            withSize:self.size
//                             quanity:[NSNumber numberWithInt:self.quanity]
//                               index:self.index];
//        [self.delegate refresh];
//    } else if ([[sender currentTitle] isEqualToString:@"+"]) {
//        if (self.quanity <= 99) {
//            self.quanity++;
//            [[BAC sharedStore] editDrink:self.drink
//                                withSize:self.size
//                                 quanity:[NSNumber numberWithInt:self.quanity]
//                                   index:self.index];
//            [self.delegate refresh];
//        }
//    }
}

@end
