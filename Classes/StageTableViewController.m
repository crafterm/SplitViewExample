//
//  StageTableViewController.m
//  Giro
//
//  Created by Marcus Crafter on 31/05/10.
//  Copyright 2010 Red Artisan. All rights reserved.
//

#import "StageTableViewController.h"
#import "ContentController.h"
#import "StageDetailViewController.h"

@implementation StageTableViewController

@synthesize stageResultsController, stageViewControllers, popoverButtonItem, popoverController;

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"Stages";
    self.stageResultsController = [[ContentController sharedInstance] stageResultsController];

    NSError * error = nil;

    if (![self.stageResultsController performFetch:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }

    NSUInteger stageCount = [self tableView:self.tableView numberOfRowsInSection:0];
    self.contentSizeForViewInPopover = CGSizeMake(320.0, self.tableView.rowHeight * stageCount);
    self.clearsSelectionOnViewWillAppear = NO;

    self.stageViewControllers = [NSMutableDictionary dictionary];
}

- (void)autoselectFirstStage {
    NSIndexPath * startPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView selectRowAtIndexPath:startPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    [self.tableView.delegate tableView:self.tableView didSelectRowAtIndexPath:startPath];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

#pragma mark -
#pragma mark Popup control

- (void)splitViewController:(UISplitViewController*)svc willHideViewController:(UIViewController *)aViewController withBarButtonItem:(UIBarButtonItem*)barButtonItem forPopoverController:(UIPopoverController*)pc {
    barButtonItem.title    = @"Stages";
    self.popoverController = pc;
    self.popoverButtonItem = barButtonItem;

    UINavigationController * navigationController = svc.rightSideViewController;
    UIViewController<PopupManagingViewController> * viewController = navigationController.rootViewController;
    [viewController showPopoverButtonItem:popoverButtonItem];
}

- (void)splitViewController:(UISplitViewController*)svc willShowViewController:(UIViewController *)aViewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem {
    UINavigationController * navigationController = svc.rightSideViewController;
    UIViewController<PopupManagingViewController> * viewController = navigationController.rootViewController;
    [viewController invalidatePopoverButtonItem:popoverButtonItem];

    self.popoverController = nil;
    self.popoverButtonItem = nil;
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [[self.stageResultsController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    id <NSFetchedResultsSectionInfo> sectionInfo = [[self.stageResultsController sections] objectAtIndex:section];
    return [sectionInfo numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *CellIdentifier = @"StageCell";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }

    Stage * stage = [self.stageResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = stage.name;
    cell.detailTextLabel.text = stage.formattedDistance;

    return cell;
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Stage * stage = [self.stageResultsController objectAtIndexPath:indexPath];

    // invalidate the current popover button if one is being used
    UINavigationController * currentStageNavigationController = self.splitViewController.rightSideViewController;
    UIViewController<PopupManagingViewController> * currentViewController = [currentStageNavigationController rootViewController];
    [currentViewController invalidatePopoverButtonItem:self.popoverButtonItem];

    // install the new viewcontrollers array (LHS: stage view controller, RHS: incoming detail navigation controller)

    UINavigationController * stageNavigationController = [self.stageViewControllers valueForKey:stage.name];

    if (!stageNavigationController) {
        StageDetailViewController * detailViewController = [[StageDetailViewController alloc] initWithStage:stage];
        stageNavigationController = [[UINavigationController alloc] initWithRootViewController:detailViewController];
        [detailViewController release];
        [self.stageViewControllers setValue:stageNavigationController forKey:stage.name];
        [stageNavigationController release];
    }

    self.splitViewController.viewControllers = [NSArray arrayWithObjects:self.navigationController, stageNavigationController, nil];

    // dismiss the popover if present, and add the popover button to the incoming detail view controller
    [self.popoverController dismissPopoverAnimated:YES];

    if (self.popoverButtonItem) {
        UIViewController<PopupManagingViewController> * viewController = [stageNavigationController rootViewController];
        [viewController showPopoverButtonItem:self.popoverButtonItem];
    }
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    [self.stageViewControllers removeAllObjects];
}

- (void)viewDidUnload {
    [super viewDidUnload];
    self.stageViewControllers   = nil;
    self.popoverButtonItem      = nil;
    self.popoverController      = nil;
    self.stageResultsController = nil;
}

@end

