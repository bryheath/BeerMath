//
//  BHUserDetailViewController.m
//  BeerMath
//
//  Created by Bryan Heath on 1/25/15.
//  Copyright (c) 2015 Bryan Heath. All rights reserved.
//

#import "AppDelegate.h"
#import "BHBACButton.h"
#import "BHCoreDataHelper.h"
#import "BHUserDetailViewController.h"
#import "User.h"

@interface BHUserDetailViewController ()
@property (nonatomic, strong) IBOutlet UITextField        *userNameField;
@property (nonatomic, strong) IBOutlet UITextField        *userWeightField;
@property (nonatomic, strong) IBOutlet UISegmentedControl *userGenderSegmentedControl;
@property (nonatomic, strong) IBOutlet BHBACButton        *saveButton;
@property (nonatomic, strong) IBOutlet BHBACButton        *saveAndSelectButton;
@property (nonatomic, strong) IBOutlet UIControl          *control;
@property (nonatomic, strong) BHCoreDataHelper            *cdh;
@property (nonatomic) BOOL isSaved;

- (IBAction)backgroundTapped:(id)sender;
- (IBAction)saveAndSelectButtonPressed;
- (IBAction)saveButtonPressed;
- (void)save;
- (void)refresh;
@end

@implementation BHUserDetailViewController
#define debug 0

//=======================================================
#pragma mark - VIEW LIFECYCLE
//=======================================================

- (void)viewDidLoad {
    if (debug == 1) NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    [super viewDidLoad];
    id appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    self.cdh = [appDelegate cdh];
    if (self.isNewUser) {
        self.user = [appDelegate createUser:nil
                                 withWeight:nil
                                  andGender:0];
    }
//    self.navigationController.navigationBar.topItem.title = @"Cancel";
    self.navigationController.navigationBar.topItem.hidesBackButton = YES;
    self.navigationController.navigationBar.topItem.backBarButtonItem = [[UIBarButtonItem alloc]
                                                                         initWithTitle:@"Cancel"
                                                                         style:UIBarButtonItemStylePlain
                                                                         target:nil
                                                                         action:nil];
//        self.isSaved = NO;
//    } else {
//        self.isSaved = YES;
//    }
    [self setupViews];
}
- (void)viewWillDisappear:(BOOL)animated {
    if ([self.navigationController.viewControllers indexOfObject:self]==NSNotFound) {
        if (self.isNewUser == YES) {
            NSError *error = nil;
            [self.cdh.context deleteObject:[self.cdh.context existingObjectWithID:self.user.objectID error:&error]];
        }
    }
    [super viewWillDisappear:animated];
    [self refresh];
    [self.view endEditing:YES];
}

//=======================================================
#pragma mark - VIEW SETUP
//=======================================================

- (void)setupViews {
    if (debug == 1) NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    
    if (self.navigationController) {
        self.navigationItem.title = self.user.userName;
    }
    self.userNameField.text   = self.user.userName;
    self.userWeightField.text = [NSString stringWithFormat:@"%@", self.user.userWeight];
    self.userGenderSegmentedControl.selectedSegmentIndex = [self.user.gender boolValue];
}

//=======================================================
#pragma mark - UITEXTFIELDDELEGATE
//=======================================================

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSString *candidate = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    // Ensure that the local decimal seperator is used max 1 time
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    NSString *decimalSymbol = formatter.decimalSeparator;
    if ([candidate componentsSeparatedByString:decimalSymbol].count > 2) {
        return NO;
    }
    
    // Ensure that all the characters used are number characters or decimal seperator
    NSString *validChars = [NSString stringWithFormat:@"0123456789%@", decimalSymbol];
    if ([candidate stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:validChars]].length) {
        return NO;
    }
    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

//==================================================================================================
#pragma mark - ACTIONS
//==================================================================================================

- (void)backgroundTapped:(id)sender {
    [self.view endEditing:YES];
}
- (IBAction)saveButtonPressed {
    [self save];
}
- (IBAction)saveAndSelectButtonPressed {
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] setCurrentUser:self.user];
    [self save];
}
- (void)dismissViewController {
    if (self.navigationController) {
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}
- (void)refresh {
    self.user.userName = self.userNameField.text;
    self.user.userWeight = [NSDecimalNumber decimalNumberWithString:self.userWeightField.text];
    self.user.gender = [NSNumber numberWithInteger:self.userGenderSegmentedControl.selectedSegmentIndex];
    if (self.navigationController) {
        self.navigationController.title = self.user.userName;
    }
}
- (void)save {
    [self refresh];
    [self.cdh saveContext];
    self.isNewUser = NO;
    [self dismissViewController];
}

@end
