//
//  AppDelegate.m
//  CocoaGLDemo
//
//  Created by Ilya Mizus on 25/11/15.
//  Copyright (c) 2015 Ilya Mizus. All rights reserved.
//

#import "AppDelegate.h"
#include "CustomGLView.h"

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    [_window setCollectionBehavior:
     NSWindowCollectionBehaviorFullScreenPrimary];
    [_window setContentView:[[CustomGLView alloc] init]];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

@end
