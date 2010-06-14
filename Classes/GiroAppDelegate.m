//
//  GiroAppDelegate.m
//  Giro
//
//  Created by Marcus Crafter on 31/05/10.
//  Copyright Red Artisan 2010. All rights reserved.
//

#import "GiroAppDelegate.h"
#import "StageTableViewController.h"

@implementation GiroAppDelegate

@synthesize window, splitViewController, stageViewController;


#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

	// Add the split view controller's view to the window and display.
	[window addSubview:splitViewController.view];
    [window makeKeyAndVisible];

    [self.stageViewController autoselectFirstStage];

	return YES;
}

#pragma mark -
#pragma mark Memory management

- (void)dealloc {
	[splitViewController release];
    [stageViewController release];

	[window release];
	[super dealloc];
}


@end

