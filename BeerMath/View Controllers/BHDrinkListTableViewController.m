//
//  BHDrinkListTableViewController.m
//  BeerMath
//
//  Created by Bryan Heath on 1/15/15.
//  Copyright (c) 2015 Bryan Heath. All rights reserved.
//

#import "AppDelegate.h"
#import "BHDrinkDetailViewController.h"
#import "BHDrinkListTableViewController.h"
#import "Drink.h"

@interface BHDrinkListTableViewController ()
- (void)typeSetup;
@end

@implementation BHDrinkListTableViewController
#define debug 0

//=======================================================
#pragma mark - CORE DATA
//=======================================================

- (void)typeSetup {
    if (debug == 1) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
    BHCoreDataHelper *cdh = [(AppDelegate *)[[UIApplication sharedApplication] delegate] cdh];
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Drink"];
    
    NSPredicate *filter = [NSPredicate predicateWithFormat:@"drinkType.typeName == %@", self.typeToLoad];
    request.predicate = filter;
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"drinkName" ascending:YES]];
    [request setFetchBatchSize:50];
    self.frc = [[NSFetchedResultsController alloc] initWithFetchRequest:request
                                                   managedObjectContext:cdh.context
                                                     sectionNameKeyPath:nil
                                                              cacheName:nil];
    self.frc.delegate = self;
}

//=======================================================
#pragma mark - VIEW LIFECYCLE
//=======================================================

- (void)viewDidLoad {
    if (debug == 1) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
    [super viewDidLoad];
    [self typeSetup];
    [self performFetch];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(performFetch)
                                                 name:@"ChangesMade"
                                               object:nil];
}

//=======================================================
#pragma mark - NAVIGATION
//=======================================================

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"drinkListToDrinkDetail"]) {
        if ([segue.destinationViewController isKindOfClass:[BHDrinkDetailViewController class]]) {
            BHDrinkDetailViewController *drinkDetailViewController = segue.destinationViewController;
            NSIndexPath *indexPath = sender;
            drinkDetailViewController.drink = [self.frc objectAtIndexPath:indexPath];
        }
    }
}

//=======================================================
#pragma mark - UITABLEVIEW
//=======================================================

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (debug == 1) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:cellIdentifier];
    }
    
    cell.backgroundColor     = [UIColor clearColor];
    cell.textLabel.font      = [UIFont boldSystemFontOfSize:17.0];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.text      = [(Drink *)[self.frc objectAtIndexPath:indexPath] drinkName];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"drinkListToDrinkDetail" sender:indexPath];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
