//
//  BHHomeViewController.m
//  BeerMath
//
//  Created by Bryan Heath on 1/14/15.
//  Copyright (c) 2015 Bryan Heath. All rights reserved.
//

#import "BHBACButton.h"
#import "BHHomeViewController.h"
#import "UIViewController+MMDrawerController.h"
#import "MMDrawerBarButtonItem.h"
#import "BHLeftMenuTableViewController.h"

@interface BHHomeViewController ()
@property (nonatomic, strong) IBOutlet BHBACButton *userNameButton;
@property (nonatomic, strong) IBOutlet BHBACButton *timeStartedDrinkingButton;
@property (nonatomic, strong) IBOutlet UIView *bacView;
@property (nonatomic, strong) IBOutlet UILabel *drinkingForLabel;
@end

@implementation BHHomeViewController

//=======================================================
#pragma mark - VIEW LIFECYCLE
//=======================================================

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupLeftMenuButton];
    [self setupViews];
}

//=======================================================
#pragma mark - VIEW SETUP
//=======================================================

- (void)setupViews {
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:132/255.0 green:66/255.0 blue:15/255.0 alpha:1.0];
    self.navigationController.navigationBar.titleTextAttributes =
    @{NSForegroundColorAttributeName : [UIColor whiteColor],
      NSFontAttributeName : [UIFont fontWithName:@"Optima-Bold" size:17.0]};
    self.title = @"Home";
}

-(void)setupLeftMenuButton{
    MMDrawerBarButtonItem * leftDrawerButton = [[MMDrawerBarButtonItem alloc] initWithTarget:self action:@selector(leftDrawerButtonPress:)];
    [self.navigationItem setLeftBarButtonItem:leftDrawerButton animated:YES];
}

-(void)leftDrawerButtonPress:(id)sender{
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}

//=======================================================
#pragma mark - NAVIGATION
//=======================================================
/*
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



@end
