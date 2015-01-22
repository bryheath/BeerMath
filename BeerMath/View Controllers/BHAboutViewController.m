//
//  BHAboutViewController.m
//  BeerMath
//
//  Created by Bryan Heath on 1/14/15.
//  Copyright (c) 2015 Bryan Heath. All rights reserved.
//

#import "BHAboutViewController.h"
#import "UIViewController+MMDrawerController.h"
#import "MMDrawerBarButtonItem.h"
#import "BHLeftMenuTableViewController.h"

@interface BHAboutViewController ()
@property (nonatomic, strong) IBOutlet UILabel *bodyLabel;
@property (nonatomic, strong) IBOutlet UILabel *smarterLabel;
@property (nonatomic, strong) IBOutlet UILabel *copyrightLabel;
@end

@implementation BHAboutViewController
#define debug 0

//=======================================================
#pragma mark - VIEW LIFECYCLE
//=======================================================

- (void)viewDidLoad {
    if (debug == 1) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
    [super viewDidLoad];
    [self setupViews];
}

//=======================================================
#pragma mark - VIEW SETUP
//=======================================================

- (void)leftDrawerButtonPress:(id)sender{
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}
- (void)setupLeftMenuButton{
    MMDrawerBarButtonItem * leftDrawerButton = [[MMDrawerBarButtonItem alloc] initWithTarget:self action:@selector(leftDrawerButtonPress:)];
    [self.navigationItem setLeftBarButtonItem:leftDrawerButton animated:YES];
}
- (void)setupViews {
    if (self.navigationController) {
        self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:132/255.0
                                                                               green:66/255.0
                                                                                blue:15/255.0
                                                                               alpha:1.0];
        self.navigationController.navigationBar.titleTextAttributes =
        @{NSForegroundColorAttributeName : [UIColor whiteColor],
          NSFontAttributeName : [UIFont fontWithName:@"Optima-Bold" size:17.0]};
        
        self.navigationItem.title = [NSString stringWithFormat:@"BeerMath v.%@",
                                     [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]];
        [self setupLeftMenuButton];
    }
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    dateFormat.dateFormat = @"yyyy";
    
    self.bodyLabel.text = @"BeerMath is a Blood Alcohol Content (BAC) Calculator designed to give a more accurate estimate of one's BAC based on what and how much they are consuming when calculated against your weight, gender and how long you've been drinking.  BeerMath is for entertainment purposes only. The information in the app is NOT legal advice.  Your BAC may be different and is an estimate. \n\nArtwork provided by Glyphish under a Creative Commons Attribution License";

    self.smarterLabel.text   = @"Drink Smarter, Not Harder";
    self.copyrightLabel.text = [NSString stringWithFormat:@"Bryan Heath\n©2013 - %@ All Rights Reserved",
                                [dateFormat stringFromDate:[[NSDate alloc] init]]];
    
    self.bodyLabel.numberOfLines      = 0;
    self.smarterLabel.numberOfLines   = 1;
    self.copyrightLabel.numberOfLines = 2;
    
   
}

@end
