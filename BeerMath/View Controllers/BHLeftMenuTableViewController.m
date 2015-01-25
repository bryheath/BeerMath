//
//  BHLeftMenuTableViewController.m
//  BeerMath
//
//  Created by Bryan Heath on 1/14/15.
//  Copyright (c) 2015 Bryan Heath. All rights reserved.
//

#import "BHLeftMenuTableViewController.h"
#import "UIViewController+MMDrawerController.h"

@interface BHLeftMenuTableViewController ()
@property (nonatomic) int currentIndex;
@property (nonatomic, strong) NSArray *titles;
@end

@implementation BHLeftMenuTableViewController
#define debug 0

//=======================================================
#pragma mark - VIEW LIFECYCLE
//=======================================================

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.titles = @[@"Home", @"Drinks", @"Users", @"History", @"Settings", @"Share", @"About"];
    self.currentIndex = 0;
}

//=======================================================
#pragma mark - UITABLEVIEW - DATA SOURCE
//=======================================================

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (debug == 1) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (debug == 1) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
    return [self.titles count];
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
    cell.textLabel.text = self.titles[indexPath.row];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (debug == 1) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
    
    if (self.currentIndex == indexPath.row) {
        [self.mm_drawerController closeDrawerAnimated:YES completion:nil];
        return;
    }
    
    UIViewController *centerViewController;
    switch (indexPath.row) {
        case 0:
            centerViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"homeNavigationViewController"];
            break;
        case 1: // Add Drinks
            centerViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"drinksNavigationViewController"];
            break;
        case 2: // Switch Users
            centerViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"usersNavigationViewController"];
            break;
        case 3: // History
            break;
        case 4: // App Settings
            break;
        case 5: // Share
            break;
        case 6: // About
            centerViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"aboutNavigationViewController"];
            break;
        default:
            break;
    }
    
    if (centerViewController) {
        self.currentIndex = (int)indexPath.row;
        [self.mm_drawerController setCenterViewController:centerViewController withCloseAnimation:YES completion:nil];
    } else {
        [self.mm_drawerController closeDrawerAnimated:YES completion:nil];
    }
}


@end
