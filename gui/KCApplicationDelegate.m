//
//  KCApplicationDelegate.m
//  Cuisine
//
//  Created by Olivier Gutknecht on 06/05/09.
//  Copyright 2009 Fotonauts. All rights reserved.
//

#import "KCApplicationDelegate.h"
#import "KCLoginWindowController.h"


@implementation KCApplicationDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
	KCLoginWindowController *c = [[KCLoginWindowController alloc] initWithWindowNibName:@"LoginWindow"];
	[c showWindow:self];
}

@end
