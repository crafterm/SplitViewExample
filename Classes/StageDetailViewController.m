//
//  StageDetailViewController.m
//  Giro
//
//  Created by Marcus Crafter on 31/05/10.
//  Copyright 2010 Red Artisan. All rights reserved.
//

#import "StageDetailViewController.h"
#import "StageArticleViewController.h"

@interface StageDetailViewController ()
- (void)didSelectReadArticle:(id)sender;
@end

@implementation StageDetailViewController

@synthesize stage, stageImageView, imageLoader, activityView, scrollView;

- (id)initWithStage:(Stage *)aStage {
    if (self = [super initWithNibName:@"StageDetailViewController" bundle:nil]) {
        self.stage = aStage;
    }
    return self;
}

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = [NSString stringWithFormat:@"Giro d'Italia: %@", self.stage.name];

    self.view.backgroundColor = [UIColor scrollViewTexturedBackgroundColor];
    self.scrollView.maximumZoomScale = 5.0f;
    self.scrollView.minimumZoomScale = 1.0f;
    self.scrollView.delegate = self;

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Read Article" style:UIBarButtonItemStylePlain target:self action:@selector(didSelectReadArticle:)];
    self.navigationItem.backBarButtonItem  = [[UIBarButtonItem alloc] initWithTitle:[NSString stringWithFormat:@"Stage %@", self.stage.index] style:UIBarButtonItemStylePlain target:nil action:nil];

    self.imageLoader = [[ImageLoader alloc] initWithURL:self.stage.imageURL];
    self.imageLoader.delegate = self;
    [self.imageLoader start];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation duration:(NSTimeInterval)duration {
    CGRect frame = self.scrollView.frame;
    CGFloat top  = (frame.size.height - self.stageImageView.frame.size.height) / 2.0f;
    CGFloat left = (frame.size.width  - self.stageImageView.frame.size.width)  / 2.0f;
    self.scrollView.contentInset = UIEdgeInsetsMake(top, left, 0, 0);
}

#pragma mark -
#pragma mark Memory management

- (void)viewDidUnload {
    self.stageImageView = nil;
    self.imageLoader.delegate = nil;
    self.imageLoader = nil;
    self.scrollView = nil;
    [super viewDidUnload];
}

- (void)dealloc {
    self.stage = nil;
    [super dealloc];
}

#pragma mark -
#pragma mark Bar Button methods

- (void)didSelectReadArticle:(id)sender {
    StageArticleViewController * articleViewController = [[StageArticleViewController alloc] initWithStage:self.stage];
    [self.navigationController pushViewController:articleViewController animated:YES];
    [articleViewController release];
}

#pragma mark -
#pragma mark Popup control

- (void)showPopoverButtonItem:(UIBarButtonItem *)barButtonItem {
    self.navigationItem.leftBarButtonItem = barButtonItem;
}

- (void)invalidatePopoverButtonItem:(UIBarButtonItem *)barButtonItem {
    self.navigationItem.leftBarButtonItem = nil;
}

#pragma mark -
#pragma mark UIScrollViewDelegate methods

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.stageImageView;
}

#pragma mark -
#pragma mark ImageLoaderDelegate methods

- (void)imageLoaderDidFinish:(UIImage *)image {
    self.stageImageView.image = image;
    self.stageImageView.layer.borderWidth  = 1.0f;
    [self.stageImageView sizeToFit];

    [self.scrollView addSubview:self.stageImageView];
    self.scrollView.contentSize = stageImageView.frame.size;

    CGRect frame = self.scrollView.frame;
    CGFloat top  = (frame.size.height - image.size.height) / 2.0f;
    CGFloat left = (frame.size.width  - image.size.width)  / 2.0f;
    self.scrollView.contentInset = UIEdgeInsetsMake(top, left, 0, 0);

    [self.activityView stopAnimating];
}

- (void)imageLoaderDidFail:(NSError *)error withLoader:(ImageLoader *)loader {
    NSLog(@"Failed to load image %@", error);
    [self.activityView stopAnimating];
}

@end
