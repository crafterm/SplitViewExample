//
//  ContentController.h
//  Giro
//
//  Created by Marcus Crafter on 5/02/10.
//  Copyright 2010 Red Artisan. All rights reserved.
//

@interface ContentController : NSObject {
    NSManagedObjectModel         * managedObjectModel;
    NSManagedObjectContext       * managedObjectContext;
    NSPersistentStoreCoordinator * persistentStoreCoordinator;
}

@property (nonatomic, retain, readonly) NSManagedObjectModel         * managedObjectModel;
@property (nonatomic, retain, readonly) NSManagedObjectContext       * managedObjectContext;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator * persistentStoreCoordinator;

+ (ContentController *)sharedInstance;

- (void)addStageWithIndex:(NSNumber *)index
                     name:(NSString *)name
                    image:(NSString *)image
                     link:(NSString *)link
                 distance:(NSNumber *)distance;

- (NSFetchedResultsController *)stageResultsController;

@end
