//
//  StageArticleViewController.h
//  Giro
//
//  Created by Marcus Crafter on 3/06/10.
//  Copyright 2010 Red Artisan. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface StageArticleViewController : UIViewController {
    UIWebView * webView;

    Stage     * stage;
}

@property (nonatomic, retain) IBOutlet UIWebView * webView;

@property (nonatomic, retain) Stage              * stage;
@end
