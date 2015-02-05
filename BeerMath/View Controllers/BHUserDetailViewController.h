//
//  BHUserDetailViewController.h
//  BeerMath
//
//  Created by Bryan Heath on 1/25/15.
//  Copyright (c) 2015 Bryan Heath. All rights reserved.
//

#import <UIKit/UIKit.h>
@class User;

@interface BHUserDetailViewController : UIViewController <UITextFieldDelegate, UINavigationBarDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) User *user;
@property (nonatomic)         BOOL  isNewUser;

@end
