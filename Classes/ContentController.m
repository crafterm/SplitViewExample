//
//  ContentController.m
//  Giro
//
//  Created by Marcus Crafter on 5/02/10.
//  Copyright 2010 Red Artisan. All rights reserved.
//

#import "ContentController.h"
#import "ContentLoader.h"

@interface ContentController ()
- (NSFetchedResultsController *)resultsControllerForEntity:(NSString *)entityName;
- (NSString *)applicationDocumentsDirectory;
@end

@implementation ContentController

#pragma mark -
#pragma mark Singleton access

+ (ContentController *)sharedInstance {
    static ContentController * instance = nil;
    if (!instance) {
        instance = [[ContentController alloc] init];

        ContentLoader * loader = [[ContentLoader alloc] initWithContentController:instance];
        [loader loadStages];
        [loader release];

        NSError * error;
        BOOL saved = [instance.managedObjectContext save:&error];

        if (!saved) {
            NSLog(@"Error %@", [error localizedDescription]);

            NSArray * details = [[error userInfo] objectForKey:NSDetailedErrorsKey];
            if (details != nil && [details count] > 0) {
                for (NSError * detail in details) {
                    NSLog(@"  DetailedError: %@", [detail userInfo]);
                }
            } else {
                NSLog(@"  %@", [error userInfo]);
            }
        }
    }
    return instance;
}

#pragma mark -
#pragma mark Store content methods

- (void)addStageWithIndex:(NSNumber *)index
                     name:(NSString *)name
                    image:(NSString *)image
                     link:(NSString *)link
                 distance:(NSNumber *)distance {

    id object = [NSEntityDescription insertNewObjectForEntityForName:@"Stage" inManagedObjectContext:self.managedObjectContext];

    [object setValue:index    forKey:@"index"];
    [object setValue:name     forKey:@"name"];
    [object setValue:image    forKey:@"image"];
    [object setValue:link     forKey:@"link"];
    [object setValue:distance forKey:@"distance"];
}

- (NSFetchedResultsController *)stageResultsController {
    return [self resultsControllerForEntity:@"Stage"];
}

#pragma mark -
#pragma mark Core Data helpers

- (NSFetchedResultsController *)resultsControllerForEntity:(NSString *)entityName {
    NSEntityDescription * entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:self.managedObjectContext];
    NSFetchRequest * fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:entity];

    NSSortDescriptor * sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"index" ascending:YES];
    NSArray * sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    [sortDescriptor release];
    [fetchRequest setSortDescriptors:sortDescriptors];

    NSFetchedResultsController * controller = [[[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                                                                   managedObjectContext:self.managedObjectContext
                                                                                     sectionNameKeyPath:nil
                                                                                              cacheName:entityName] autorelease];

    NSError * error;
    BOOL success = [controller performFetch:&error];

    if (!success) {
        NSLog(@"Unable to fetch %@ content: %@", entityName, error);
    }

    [fetchRequest release];
    return controller;
}

- (NSManagedObjectContext *)managedObjectContext {

    if (managedObjectContext != nil) {
        return managedObjectContext;
    }

    NSPersistentStoreCoordinator * coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        managedObjectContext = [[NSManagedObjectContext alloc] init];
        [managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return managedObjectContext;
}

- (NSManagedObjectModel *)managedObjectModel {

    if (managedObjectModel != nil) {
        return managedObjectModel;
    }
    managedObjectModel = [[NSManagedObjectModel mergedModelFromBundles:nil] retain];
    return managedObjectModel;
}


- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {

    if (persistentStoreCoordinator != nil) {
        return persistentStoreCoordinator;
    }

	NSError *error = nil;

    persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![persistentStoreCoordinator addPersistentStoreWithType:NSInMemoryStoreType configuration:nil URL:nil options:nil error:&error]) {
		/*
		 Replace this implementation with code to handle the error appropriately.

		 abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.

		 Typical reasons for an error here include:
		 * The persistent store is not accessible
		 * The schema for the persistent store is incompatible with current managed object model
		 Check the error message to determine what the actual problem was.
		 */
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		abort();
    }

    return persistentStoreCoordinator;
}

/**
 Returns the path to the application's Documents directory.
 */
- (NSString *)applicationDocumentsDirectory {
	return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}


-(void) dealloc {
    [managedObjectContext release];
    [managedObjectModel release];
    [persistentStoreCoordinator release];
    [super dealloc];
}

@end
