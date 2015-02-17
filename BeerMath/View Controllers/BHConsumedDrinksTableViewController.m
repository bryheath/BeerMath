//
//  BHConsumedDrinksTableViewController.m
//  BeerMath
//
//  Created by Bryan Heath on 1/20/15.
//  Copyright (c) 2015 Bryan Heath. All rights reserved.
//

#import "AppDelegate.h"
#import "BHConsumedDrinksTableViewController.h"
#import "BHDrinkDetailViewController.h"
#import "BHDrinkTableViewCell.h"
#import "BHLeftMenuTableViewController.h"
#import "ConsumedDrink.h"
#import "DrinkSize.h"
#import "DrinkType.h"
#import "MMDrawerBarButtonItem.h"
#import "UIViewController+MMDrawerController.h"

@interface BHConsumedDrinksTableViewController ()
@end

@implementation BHConsumedDrinksTableViewController
#define debug 0

//=======================================================
#pragma mark - VIEW LIFECYCLE
//=======================================================

- (void)viewDidLoad {
    if (debug == 1) NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    [super viewDidLoad];
    [self setupViews];
    [self setupFetch];
    [self performFetch];
}

//=======================================================
#pragma mark - VIEW SETUP
//=======================================================

- (void)setupLeftMenuButton{
    if (debug == 1) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
    MMDrawerBarButtonItem *leftDrawerButton = [[MMDrawerBarButtonItem alloc]
                                               initWithTarget:self
                                               action:@selector(leftDrawerButtonPress:)];
    [self.navigationItem setLeftBarButtonItem:leftDrawerButton animated:YES];
}
- (void)setupRightMenuButtons {
    if (debug == 1) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
    UIBarButtonItem *addBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                                  target:self
                                                                                  action:@selector(addCustomDrink)];
    UIBarButtonItem *favoriteBarButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"heart"]
                                                                          style:UIBarButtonItemStyleBordered
                                                                         target:self
                                                                         action:@selector(addFavoriteDrinks)];
    self.navigationItem.rightBarButtonItems = @[addBarButton, favoriteBarButton];
}

- (void)leftDrawerButtonPress:(id)sender{
    if (debug == 1) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}

- (void)addCustomDrink {
    if (debug == 1) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
    [self performSegueWithIdentifier:@"consumedDrinksToDrinkType" sender:nil];
}
- (void)addFavoriteDrinks {
    
}

- (void)setupViews {
    if (debug == 1) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
    if (self.navigationController) {
        self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:132/255.0
                                                                               green:66/255.0
                                                                                blue:15/255.0
                                                                               alpha:1.0];
        self.navigationController.navigationBar.titleTextAttributes =
        @{NSForegroundColorAttributeName : [UIColor whiteColor],
          NSFontAttributeName : [UIFont fontWithName:@"Optima-Bold" size:17.0]};
        
        self.navigationItem.title = @"Consumed Drinks";
        [self setupLeftMenuButton];
        [self setupRightMenuButtons];

    }
    self.tableView.rowHeight = 50;
}



//=======================================================
#pragma mark - CORE DATA
//=======================================================

- (void)setupFetch {
    if (debug == 1) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
    BHCoreDataHelper *cdh   = [(AppDelegate *)[[UIApplication sharedApplication] delegate] cdh];
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"ConsumedDrink"];
    request.predicate = [NSPredicate predicateWithFormat:@"user == %@", [(AppDelegate *)[[UIApplication sharedApplication] delegate] currentUser]];
    
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"dateCreated" ascending:YES]];
    request.fetchBatchSize  = 25;
    self.frc = [[NSFetchedResultsController alloc] initWithFetchRequest:request
                                                   managedObjectContext:cdh.context
                                                     sectionNameKeyPath:nil
                                                              cacheName:nil];
    self.frc.delegate = self;
}

//=======================================================
#pragma mark - UITABLEVIEW - DATA SOURCE
//=======================================================

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    if (debug == 1) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
    return YES;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (debug == 1) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
    
    static NSString *cellIdentifier = @"Cell";
    BHDrinkTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[BHDrinkTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                           reuseIdentifier:cellIdentifier];
    }
    cell.consumedDrink = (ConsumedDrink *)[self.frc objectAtIndexPath:indexPath];
    return cell;

}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        BHCoreDataHelper *cdh   = [(AppDelegate *)[[UIApplication sharedApplication] delegate] cdh];
        [cdh.context deleteObject:[self.frc objectAtIndexPath:indexPath]];
        [cdh saveContext];
    }
}

//=======================================================
#pragma mark - UITABLEVIEW - DELEGATE
//=======================================================

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"consumedDrinksToDetailDrink" sender:indexPath];
}

//=======================================================
#pragma mark - NAVIGATION
//=======================================================

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if (debug == 1) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    //    consumedDrinksToDetailDrink
    if ([segue.identifier isEqualToString:@"consumedDrinksToDetailDrink"]) {
        if ([segue.destinationViewController isKindOfClass:[BHDrinkDetailViewController class]]) {
            BHDrinkDetailViewController *ddvc = segue.destinationViewController;
            NSIndexPath *indexPath = sender;
            ConsumedDrink *consumedDrink = (ConsumedDrink *)[self.frc objectAtIndexPath:indexPath];
            ddvc.drink = consumedDrink.drink;
            ddvc.quanity = consumedDrink.quanity;
            ddvc.editFlag = YES;
            ddvc.drinkSize = consumedDrink.size;
            ddvc.drinkID = consumedDrink.objectID;

        }
    }
    
}

//=======================================================
#pragma mark - ACTION METHODS
//=======================================================







@end
