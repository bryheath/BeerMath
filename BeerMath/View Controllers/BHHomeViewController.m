//
//  BHHomeViewController.m
//  BeerMath
//
//  Created by Bryan Heath on 1/14/15.
//  Copyright (c) 2015 Bryan Heath. All rights reserved.
//
#import "AppDelegate.h"
#import "BHBACButton.h"
#import "BHBACView.h"
#import "BHFormatter.h"
#import "BHHomeViewController.h"
#import "UIViewController+MMDrawerController.h"
#import "MMDrawerBarButtonItem.h"
#import "BHLeftMenuTableViewController.h"
#import "User.h"

@interface BHHomeViewController ()
@property (nonatomic, strong) IBOutlet BHBACButton *userNameButton;
@property (nonatomic, strong) IBOutlet BHBACButton *timeStartedDrinkingButton;
@property (strong, nonatomic) IBOutlet BHBACView *bacView;
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
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:132/255.0
                                                                           green:66/255.0
                                                                            blue:15/255.0
                                                                           alpha:1.0];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor],
                                                                    NSFontAttributeName : [UIFont fontWithName:@"Optima-Bold"
                                                                                                          size:17.0]};
    self.title = @"Home";
    [self refresh];
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

//=======================================================
#pragma mark - HELPER METHODS
//=======================================================

- (NSString *)roundHours:(float)hours {
    int intHours, intDays, intMinutes;
    NSString *roundedHours = [[NSString alloc] init];
    if (!hours || hours < 0) hours = 0.0;
    
    intDays = hours / 24;
    hours -= (24 * intDays);
    intHours = hours;
    intMinutes = (hours - intHours) * 60;
    
    if (intDays > 0) {
        roundedHours = [NSString stringWithFormat:@"%i Days, %i Hours, %i Minutes", intDays, intHours, intMinutes];
    } else if (intHours > 0 && intHours < 24) {
        roundedHours = [NSString stringWithFormat:@"%i Hours, %i Minutes", intHours, intMinutes];
    } else {
        roundedHours = [NSString stringWithFormat:@"%i Minutes", intMinutes];
    }
    return roundedHours;
}
- (void)refresh {
    id appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    User *user = [appDelegate currentUser];
    NSTimeInterval diff = [user.startTime timeIntervalSinceNow] / 3600;
    NSNumber *hours = [NSNumber numberWithFloat:diff * -1];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    dateFormat.dateFormat = @"h:mm a";
    
    if (!user.startTime) user.startTime = [NSDate new];
    
    self.drinkingForLabel.text = [self roundHours:[hours floatValue]];
    [self.timeStartedDrinkingButton setTitle:[dateFormat stringFromDate:user.startTime]
                                    forState:UIControlStateNormal];
    [self.userNameButton setTitle:user.userName forState:UIControlStateNormal];

    
    
    if ([user.consumedDrinks count] > 0) {
        NSNumber *estimatedBAC = [appDelegate calculate:hours];
        float tempBAC = [estimatedBAC floatValue];
        if (tempBAC < 0.03)                    [self.bacView.bacLabel setTextColor:[UIColor whiteColor]];
        if (tempBAC >= 0.03 && tempBAC < 0.06) [self.bacView.bacLabel setTextColor:[UIColor yellowColor]];
        if (tempBAC >= 0.06 && tempBAC < 0.08) [self.bacView.bacLabel setTextColor:[UIColor orangeColor]];
        if (tempBAC > 0.08)                    [self.bacView.bacLabel setTextColor:[UIColor redColor]];
        
        NSString *bacString = [NSString stringWithFormat:@"%@%%",
                               [[[BHFormatter sharedStore] numberFormatterWith:NSNumberFormatterDecimalStyle
                                                                   padPosition:NSNumberFormatterPadAfterSuffix
                                                             minFractionDigits:4
                                                             maxFractionDigits:4
                                                              minIntegerDigits:1
                                                              maxIntegerDigits:1]
                                stringFromNumber:[appDelegate calculate:@(2.0)]]];
        self.bacView.bacLabel.text = bacString;
        if (tempBAC > 100.0 || [self.bacView.bacLabel.text isEqualToString:@"NaN"]) {
            self.bacView.bacLabel.textColor = [UIColor whiteColor];
            self.bacView.bacLabel.text = @"0.0000%";
        }
    } else {
        self.bacView.bacLabel.textColor = [UIColor whiteColor];
        self.bacView.bacLabel.text = @"0.0000%";
    }
}

@end
