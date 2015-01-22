//
//  BHDrinkTableTypeViewController.m
//  BeerMath
//
//  Created by Bryan Heath on 1/15/15.
//  Copyright (c) 2015 Bryan Heath. All rights reserved.
//

#import "AppDelegate.h"
#import "BHCoreDataHelper.h"
#import "BHDrinkTypeTableViewController.h"
#import "BHDrinkListTableViewController.h"
#import "DrinkType.h"


@interface BHDrinkTypeTableViewController ()
@end

@implementation BHDrinkTypeTableViewController
#define debug 0

//=======================================================
#pragma mark - VIEW LIFECYCLE
//=======================================================

- (void)viewDidLoad {
    if (debug == 1) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
    [super viewDidLoad];
    [self setupFetch];
    [self performFetch];

}
- (void)viewWillAppear:(BOOL)animated {
    if (debug == 1) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
    if (self.navigationController) {
        self.navigationItem.title = @"Drink Types";
    }
}

//=======================================================
#pragma mark - CORE DATA
//=======================================================

- (void)setupFetch {
    if (debug == 1) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
    BHCoreDataHelper *cdh   = [(AppDelegate *)[[UIApplication sharedApplication] delegate] cdh];
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"DrinkType"];
    
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"typeName" ascending:YES]];
    request.fetchBatchSize  = 25;
    self.frc = [[NSFetchedResultsController alloc] initWithFetchRequest:request
                                                   managedObjectContext:cdh.context
                                                     sectionNameKeyPath:nil
                                                              cacheName:nil];
    self.frc.delegate = self;
}

//=======================================================
#pragma mark - NAVIGATION
//=======================================================

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if (debug == 1) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
    if ([segue.identifier isEqualToString:@"drinkTypeToDrinkList"]) {
        if ([segue.destinationViewController isKindOfClass:[BHDrinkListTableViewController class]]) {
            BHDrinkListTableViewController *drinkListTVC = segue.destinationViewController;
            
            //Insert Statement to Load Type, sent to drinkListTVC
            NSIndexPath *indexPath = sender;
            [drinkListTVC setTypeToLoad:[self.tableView cellForRowAtIndexPath:indexPath].textLabel.text];
        }
    }
}

//=======================================================
#pragma mark - UITABLEVIEW - DATA SOURCE
//=======================================================

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    if (debug == 1) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
    return NO;
}
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    if (debug == 1) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
    return nil;
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
    cell.textLabel.text      = [(DrinkType *)[self.frc objectAtIndexPath:indexPath] typeName];
    
    return cell;
}

//=======================================================
#pragma mark - UITABLEVIEW - DELEGATE
//=======================================================

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (debug == 1) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
    [self performSegueWithIdentifier:@"drinkTypeToDrinkList" sender:indexPath];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
