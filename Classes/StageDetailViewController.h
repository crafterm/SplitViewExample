//
//  StageDetailViewController.h
//  Giro
//
//  Created by Marcus Crafter on 31/05/10.
//  Copyright 2010 Red Artisan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageLoader.h"
#import "StageTableViewController.h"

@interface StageDetailViewController : UIViewController <ImageLoaderDelegate, UIScrollViewDelegate, PopupManagingViewController> {
    Stage                   * stage;

    UIScrollView            * scrollView;
    UIActivityIndicatorView * activityView;

    UIImageView             * stageImageView;
    ImageLoader             * imageLoader;
}

@property (nonatomic, retain) Stage                            * stage;

@property (nonatomic, retain) IBOutlet UIScrollView            * scrollView;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView * activityView;

@property (nonatomic, retain) IBOutlet UIImageView             * stageImageView;
@property (nonatomic, retain) ImageLoader                      * imageLoader;

- (id)initWithStage:(Stage *)stage;

@end
