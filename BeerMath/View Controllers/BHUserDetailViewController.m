//
//  BHUserDetailViewController.m
//  BeerMath
//
//  Created by Bryan Heath on 1/25/15.
//  Copyright (c) 2015 Bryan Heath. All rights reserved.
//

#import "BHBACButton.h"
#import "BHUserDetailViewController.h"
#import "User.h"

@interface BHUserDetailViewController ()
@property (nonatomic, strong) IBOutlet UITextField        *userNameField;
@property (nonatomic, strong) IBOutlet UITextField        *userWeightField;
@property (nonatomic, strong) IBOutlet UISegmentedControl *userGenderSegmentedControl;
@property (nonatomic, strong) IBOutlet BHBACButton        *saveButton;
@property (nonatomic, strong) IBOutlet UIControl          *control;

- (void)backgroundTapped:(id)sender;
- (void)cancel;
- (void)save;
- (void)selectUser;
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
    [self setupViews];
}

//=======================================================
#pragma mark - VIEW SETUP
//=======================================================

- (void)setupViews {
    if (debug == 1) NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    
    if (self.navigationController) {
        self.navigationItem.title = self.user.userName;
    }
    self.userNameField.text = self.user.userName;
    self.userWeightField.text = [NSString stringWithFormat:@"%@", self.user.userWeight];
    self.userGenderSegmentedControl.selectedSegmentIndex = [self.user.gender boolValue];
}

//=======================================================
#pragma mark - UITEXTFIELDDELEGATE
//=======================================================

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
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
- (void)cancel {
    //If It was a new user, remove it, if it was a current, do nothing
    if (self.navigationController) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}
- (void)save {
    //Save Changes Here
    if (self.navigationController) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}
- (void)selectUser {
//    [self refresh];
//    [[BAC sharedStore] loadUser:[self user]];
//    [[UserStore sharedStore] saveChanges];
//    
//    [[self tabBarController] setSelectedViewController:
//     [[[self tabBarController] viewControllers] objectAtIndex:0]];
//    [[self navigationController] popViewControllerAnimated:YES];
}

- (void)refresh {
    
}

@end
