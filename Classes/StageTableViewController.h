//
//  StageTableViewController.h
//  Giro
//
//  Created by Marcus Crafter on 31/05/10.
//  Copyright 2010 Red Artisan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StageTableViewController : UITableViewController {
    NSFetchedResultsController * stageResultsController;

    NSMutableDictionary        * stageViewControllers;

    UIPopoverController        * popoverController;
    UIBarButtonItem            * popoverButtonItem;
}

@property (nonatomic, retain) NSFetchedResultsController * stageResultsController;

@property (nonatomic, retain) NSMutableDictionary        * stageViewControllers;

@property (nonatomic, retain) UIPopoverController        * popoverController;
@property (nonatomic, retain) UIBarButtonItem            * popoverButtonItem;

- (void)autoselectFirstStage;

@end

@protocol PopupManagingViewController
- (void)showPopoverButtonItem:(UIBarButtonItem *)barButtonItem;
- (void)invalidatePopoverButtonItem:(UIBarButtonItem *)barButtonItem;
@end
