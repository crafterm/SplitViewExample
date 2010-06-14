    //
//  StageArticleViewController.m
//  Giro
//
//  Created by Marcus Crafter on 3/06/10.
//  Copyright 2010 Red Artisan. All rights reserved.
//

#import "StageArticleViewController.h"


@implementation StageArticleViewController

@synthesize webView, stage;

- (id)initWithStage:(Stage *)aStage {
    if ((self = [super initWithNibName:@"StageArticleViewController" bundle:nil])) {
        self.stage = aStage;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = stage.name;
    [self.webView loadRequest:[NSURLRequest requestWithURL:self.stage.linkURL]];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

- (void)viewDidUnload {
    [super viewDidUnload];
    self.webView = nil;
}

- (void)dealloc {
    self.stage = nil;
    [super dealloc];
}


@end
