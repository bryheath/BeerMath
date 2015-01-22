//
//  BHConsumedDrinksTableViewController.m
//  BeerMath
//
//  Created by Bryan Heath on 1/20/15.
//  Copyright (c) 2015 Bryan Heath. All rights reserved.
//

#import "BHConsumedDrinksTableViewController.h"
#import "UIViewController+MMDrawerController.h"
#import "MMDrawerBarButtonItem.h"
#import "BHLeftMenuTableViewController.h"

@interface BHConsumedDrinksTableViewController ()
@end

@implementation BHConsumedDrinksTableViewController
#define debug 0

//=======================================================
#pragma mark - VIEW LIFECYCLE
//=======================================================

-(void)viewDidLoad {
    if (debug == 1) NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    [super viewDidLoad];
    [self setupViews];
}

//=======================================================
#pragma mark - VIEW SETUP
//=======================================================

-(void)setupLeftMenuButton{
    if (debug == 1) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
    MMDrawerBarButtonItem *leftDrawerButton = [[MMDrawerBarButtonItem alloc]
                                               initWithTarget:self
                                               action:@selector(leftDrawerButtonPress:)];
    [self.navigationItem setLeftBarButtonItem:leftDrawerButton animated:YES];
}
-(void)leftDrawerButtonPress:(id)sender{
    if (debug == 1) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}
-(void)setupViews {
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
        UIBarButtonItem *addBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                                  target:self
                                                                                  action:@selector(addCustomDrink)];
        UIImage *image = [UIImage imageNamed:@"heart"];
        UIBarButtonItem *favoriteBarButton = [[UIBarButtonItem alloc] initWithImage:image
                                                                              style:UIBarButtonItemStyleBordered
                                                                             target:self
                                                                             action:@selector(addFavoriteDrinks)];
        self.navigationItem.rightBarButtonItems = @[addBarButton, favoriteBarButton];
    }
}

- (void)addCustomDrink {
    
}

- (void)addFavoriteDrinks {
    
}

//=======================================================
#pragma mark - NAVIGATION
//=======================================================

/*
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if (debug == 1) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



@end
