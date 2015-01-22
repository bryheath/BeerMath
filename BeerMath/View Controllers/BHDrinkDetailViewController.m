//
//  BHDrinkDetailViewController.m
//  BeerMath
//
//  Created by Bryan Heath on 1/19/15.
//  Copyright (c) 2015 Bryan Heath. All rights reserved.
//

#import "BHDrinkDetailViewController.h"
#import "Drink.h"
#import "Beer.h"
#import "Liquor.h"
#import "Wine.h"
#import "DrinkType.h"
#import "BeerType.h"
#import "LiquorType.h"
#import "WineType.h"
#import "AppDelegate.h"
#import "BeerSize.h"
#import "WineSize.h"
#import "LiquorSize.h"
#import "DrinkSize.h"

@interface BHDrinkDetailViewController() <NSFetchedResultsControllerDelegate>
@property (nonatomic, strong) IBOutlet UILabel *nameLabel;
@property (nonatomic, strong) IBOutlet UILabel *originLabel;
@property (nonatomic, strong) IBOutlet UILabel *abvLabel;
@property (nonatomic, strong) IBOutlet UILabel *typeLabel;
@property (nonatomic, strong) IBOutlet UIButton *consumeButton;
@property (nonatomic, strong) NSArray *sizesArray;
@property (nonatomic, strong) IBOutlet UIPickerView *pickerView;
@property (nonatomic, strong) NSFetchedResultsController *frc;
@property (nonatomic, strong) NSFetchRequest *request;
@property (nonatomic, strong) NSMutableArray *numDrinks;

@end
@implementation BHDrinkDetailViewController
#define debug 0

//=======================================================
#pragma mark - CORE DATA
//=======================================================

- (NSArray *)sizesArray {
    if (debug == 1) NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    
    if (!_sizesArray) {
        BHCoreDataHelper *cdh = [(AppDelegate *)[[UIApplication sharedApplication] delegate] cdh];
        _sizesArray = [[NSArray alloc] initWithArray:[cdh.context executeFetchRequest:self.request error:nil]];
    }
    return _sizesArray;
}
- (NSFetchRequest *)request {
    if (debug == 1) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
        NSLog(@"self.drink: %@", [self.drink class]);
    }
    
    if (!_request) {
        if ([self.drink isKindOfClass:[Beer class]]) {
            if (debug == 1) NSLog(@"Beer");
            _request = [NSFetchRequest fetchRequestWithEntityName:@"BeerSize"];
        } else if ([self.drink isKindOfClass:[Liquor class]]) {
            if (debug == 1) NSLog(@"Liquor");
            _request = [NSFetchRequest fetchRequestWithEntityName:@"LiquorSize"];
        } else if ([self.drink isKindOfClass:[Wine class]]) {
            if (debug == 1) NSLog(@"Wine");
            _request = [NSFetchRequest fetchRequestWithEntityName:@"WineSize"];
        } else {
            if (debug == 1) NSLog(@"Drink");
            _request = [NSFetchRequest fetchRequestWithEntityName:@"DrinkSize"];
        }
        _request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"size" ascending:YES]];
        self.frc.delegate = self;
    }
    return _request;
}
- (NSMutableArray *)numDrinks {
    if (debug == 1) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
    if (!_numDrinks) {
        _numDrinks = [[NSMutableArray alloc] init];
    }
    return _numDrinks;
}

//=======================================================
#pragma mark - VIEW LIFECYCLE
//=======================================================

- (void)viewDidLoad {
    if (debug == 1) NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    [super viewDidLoad];
    [self setupViews];
}

//=======================================================
#pragma mark - VIEW SETUP
//=======================================================

- (void)setupLabels {
    if (debug == 1) NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    
    self.nameLabel.text   = self.drink.drinkName;
    self.originLabel.text = self.drink.drinkOrigin;
    self.abvLabel.text    = [NSString stringWithFormat:@"%@%%", self.drink.drinkABV];
    self.typeLabel.text   = self.drink.drinkType.typeName;
    
    if ([self.drink isKindOfClass:[Beer class]]) {
        if (((Beer *)self.drink).beerTypes.subtypeName) {
            self.typeLabel.text = [NSString stringWithFormat:@"%@ - %@", self.drink.drinkType.typeName,
                                   ((Beer *)self.drink).beerTypes.subtypeName];
        }
    } else if ([self.drink isKindOfClass:[Liquor class]]) {
        if (((Liquor *)self.drink).liquorTypes.subtypeName) {
            self.typeLabel.text = [NSString stringWithFormat:@"%@ - %@", self.drink.drinkType.typeName,
                                   ((Liquor *)self.drink).liquorTypes.subtypeName];
        }
        if (!((Liquor *)self.drink).liquorProof) {
            ((Liquor *)self.drink).liquorProof = [NSNumber numberWithFloat:[self.drink.drinkABV floatValue] * 2.0];
        }
        self.abvLabel.text = [NSString stringWithFormat:@"%@%% (%@ Proof)", self.drink.drinkABV, ((Liquor *)self.drink).liquorProof];
    } else if ([self.drink isKindOfClass:[Wine class]]) {
        if (((Wine *)self.drink).wineTypes.subtypeName) {
            self.typeLabel.text = [NSString stringWithFormat:@"%@ - %@", self.drink.drinkType.typeName,
                                   ((Wine *)self.drink).wineTypes.subtypeName];
        }
    }

}
- (void)setupPicker {
    if (debug == 1) NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    
    // Populate Date for Drinks Quanity
    for (int i = 0; i <= 100; i++) {
        NSString *iWrapped = [NSString stringWithFormat:@"%u", i];
        [self.numDrinks addObject:iWrapped];
    }
    
    // Default Row for Drink Size
    
    NSInteger defRow = 0;
    if ([self.drink isKindOfClass:[Beer class]]) defRow = 4;
    else if ([self.drink isKindOfClass:[Liquor class]]) defRow = 3;
    
    if (self.drinkSize) {
        int count = 0;
        for (DrinkSize *drinkSize in self.sizesArray) {
            if (drinkSize.size == self.drinkSize.size) {
                [self.pickerView selectRow:count inComponent:1 animated:YES];
                break;
            }
            count++;
        }
    } else {
        [self.pickerView selectRow:defRow inComponent:1 animated:YES];
        self.drinkSize = ((DrinkSize *)self.sizesArray[defRow]);
    }
    
    // Default Row for Drink Quanity
    
    if (!self.quanity)
        self.quanity = [[NSNumber alloc] initWithInt:1];
    
    if ([self.quanity intValue] >= 0) {
        [self.pickerView selectRow:[self.quanity intValue] inComponent:0 animated:YES];
    } else {
        [self.pickerView selectRow:1 inComponent:0 animated:YES];
    }
}
- (void)setupViews {
    if (debug == 1) NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    
    if (self.navigationController) {
        self.navigationItem.title = self.drink.drinkName;
    }
    [self setupLabels];
    [self setupPicker];
}

//=======================================================
#pragma mark - UIPICKERVIEW - DATA SOURCE
//=======================================================

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    if (debug == 1) NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    return 2;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (debug == 1) NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    if (component == 0) {
        return [self.numDrinks count];
    } else if (component == 1) {
        return [self.sizesArray count];    }
    return 0;
}

//=======================================================
#pragma mark - UIPICKERVIEW - DELEGATE
//=======================================================

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    if (debug == 1) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
    if (component == 0) {
        return [[UIScreen mainScreen] bounds].size.width / 5;
    } else {
        return [[UIScreen mainScreen] bounds].size.width / 5 * 4;
    }
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row
            forComponent:(NSInteger)component {
    if (debug == 1) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
    if (component == 0) {
        return [self.numDrinks objectAtIndex:row];
    } else if (component == 1) {
        return [NSString stringWithFormat:@"%@oz: %@", ((DrinkSize *)self.sizesArray[row]).size,
                ((DrinkSize *)self.sizesArray[row]).sizeDescription];
    }
    return 0;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row
       inComponent:(NSInteger)component {
    if (debug == 1) NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    
    if (component == 0) {
        self.quanity = [NSNumber numberWithInt:[self.numDrinks[row] intValue]];
        if (debug == 1) NSLog(@"Quanity: %@", self.quanity);
    } else if (component == 1) {
        self.drinkSize = ((DrinkSize *)self.sizesArray[row]);
        if (debug == 1) NSLog(@"Size: %@", self.drinkSize.size);
    }
}

//=======================================================
#pragma mark - IBACTIONS
//=======================================================

- (IBAction)consume {
    if (debug == 1) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
        NSLog(@"self.drink: %@", self.drink);
        NSLog(@"self.drinkSize: %@", self.drinkSize);
        NSLog(@"self.quanity: %@", self.quanity);
        NSLog(@"self.drinkID: %@", self.drinkID);
    }
    if (self.editFlag) {
        [(AppDelegate *)[[UIApplication sharedApplication] delegate] editDrink:self.drink
                                                                      withSize:self.drinkSize
                                                                       quanity:self.quanity
                                                                      objectID:self.drinkID];
    } else {
        [(AppDelegate *)[[UIApplication sharedApplication] delegate] newDrink:self.drink
                                                                     withSize:self.drinkSize
                                                                      quanity:self.quanity];
    }
    if (self.navigationController) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    } else {
        NSLog(@"Where you going? :)");
    }
}

@end

