//
//  GiroAppDelegate.h
//  Giro
//
//  Created by Marcus Crafter on 31/05/10.
//  Copyright Red Artisan 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class StageTableViewController;

@interface GiroAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow                 * window;
	UISplitViewController    * splitViewController;
    StageTableViewController * stageViewController;
}

@property (nonatomic, retain) IBOutlet UIWindow                 * window;
@property (nonatomic, retain) IBOutlet UISplitViewController    * splitViewController;
@property (nonatomic, retain) IBOutlet StageTableViewController * stageViewController;

@end
