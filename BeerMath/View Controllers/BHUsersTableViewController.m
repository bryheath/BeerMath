//
//  BHUsersTableViewController.m
//  BeerMath
//
//  Created by Bryan Heath on 1/25/15.
//  Copyright (c) 2015 Bryan Heath. All rights reserved.
//

#import "AppDelegate.h"
#import "BHCoreDataHelper.h"
#import "BHUsersTableViewController.h"
#import "BHUserDetailViewController.h"
#import "MMDrawerBarButtonItem.h"
#import "UIViewController+MMDrawerController.h"
#import "User.h"


@interface BHUsersTableViewController ()

@end

@implementation BHUsersTableViewController
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
    [self setupViews];
}
- (void)viewWillAppear:(BOOL)animated {
    [[self tableView] reloadData];
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
- (void)leftDrawerButtonPress:(id)sender {
    if (debug == 1) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}

- (void)setupRightMenuButton {
    if (debug == 1) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
    UIBarButtonItem *addBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                                  target:self
                                                                                  action:@selector(rightDrawerButtonPress:)];
    
    self.navigationItem.rightBarButtonItem = addBarButton;
}

- (void)rightDrawerButtonPress:(id)sender {
    if (debug == 1) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
    [self performSegueWithIdentifier:@"usersToUserDetail" sender:sender];
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
        
        self.navigationItem.title = @"Users";
        [self setupLeftMenuButton];
        [self setupRightMenuButton];
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
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"User"];
    
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"userName" ascending:YES]];
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
    User *cellUser = (User *)[self.frc objectAtIndexPath:indexPath];
    User *currentUser = [(AppDelegate *)[[UIApplication sharedApplication] delegate] currentUser];
    
    if (cellUser == currentUser) {
        return NO;
    } else {
        return YES;
    }
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
    User *user = (User *)[self.frc objectAtIndexPath:indexPath];
    if (user == [(AppDelegate *)[[UIApplication sharedApplication] delegate] currentUser]) {
        cell.backgroundColor     = [UIColor colorWithRed:0.00 green:0.00 blue:0.66 alpha:1.0];
        cell.textLabel.font      = [UIFont fontWithName:@"Optima-BoldItalic" size:17.0];
    } else {
        cell.backgroundColor     = [UIColor clearColor];
        cell.textLabel.font      = [UIFont fontWithName:@"Optima-Bold" size:17.0];
    }
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.text      = user.userName;
    
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
    if (debug == 1) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
    [self performSegueWithIdentifier:@"usersToUserDetail" sender:indexPath];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

//=======================================================
#pragma mark - NAVIGATION
//=======================================================
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if (debug == 1) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
    if ([segue.identifier isEqualToString:@"usersToUserDetail"]) {
        if ([segue.destinationViewController isKindOfClass:[BHUserDetailViewController class]]) {
            BHUserDetailViewController *userDetailVC = segue.destinationViewController;
            
            //Insert Statement to Load Type, sent to drinkListTVC
            if ([sender isMemberOfClass:[NSIndexPath class]]) {
                NSIndexPath *indexPath = sender;
                userDetailVC.user = (User *)[self.frc objectAtIndexPath:indexPath];
            } else if ([sender isMemberOfClass:[UIBarButtonItem class]]) {
                
                userDetailVC.isNewUser = YES;
            }

            
        }
    }
}

@end
