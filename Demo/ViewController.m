//
//  ViewController.m
//  ABReleaseNotesViewController
//
//  Created by Aaron Brethorst on 3/2/16.
//  Copyright © 2016 Aaron Brethorst. All rights reserved.
//

#import "ViewController.h"
#import "ABReleaseNotesViewController.h"

@interface ViewController ()
@property(nonatomic,strong) ABReleaseNotesViewController *releaseNotes;
@property(nonatomic,strong) UIWebView *webView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = NSLocalizedString(@"Just a Web View", @"");

    self.webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    self.webView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:self.webView];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.apple.com"]]];

    self.releaseNotes = [[ABReleaseNotesViewController alloc] initWithAppIdentifier:@"329380089"];

    // if this was a real app, I would set the mode property on the release notes controller to 'production':
    // self.releaseNotes.mode = ABReleaseNotesViewControllerModeProduction;
    // It is set by default to ABReleaseNotesViewControllerModeTesting, which means that it always appears:
    self.releaseNotes.mode = ABReleaseNotesViewControllerModeTesting;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    [self.releaseNotes checkForUpdates:^(BOOL updated) {
        if (updated) {
            [self presentViewController:self.releaseNotes animated:YES completion:nil];
        }
    }];
}
@end