//
//  BHCoreDataTableViewController.h
//  BeerMath
//
//  Created by Bryan Heath on 1/15/15.
//  Copyright (c) 2015 Bryan Heath. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BHCoreDataHelper.h"

@interface BHCoreDataTableViewController : UITableViewController <NSFetchedResultsControllerDelegate>
@property (nonatomic, strong) NSFetchedResultsController *frc;
- (void)performFetch;
@end
