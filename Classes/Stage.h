//
//  Stage.h
//  Giro
//
//  Created by Marcus Crafter on 31/05/10.
//  Copyright 2010 Red Artisan. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface Stage :  NSManagedObject{
}

@property (nonatomic, retain) NSString   * link;
@property (nonatomic, retain) NSString   * name;
@property (nonatomic, retain) NSString   * image;
@property (nonatomic, retain) NSNumber   * index;
@property (nonatomic, retain) NSNumber   * distance;

@property (nonatomic, readonly) NSString * formattedName;
@property (nonatomic, readonly) NSString * formattedDistance;
@property (nonatomic, readonly) NSURL    * imageURL;
@property (nonatomic, readonly) NSURL    * linkURL;

@end



