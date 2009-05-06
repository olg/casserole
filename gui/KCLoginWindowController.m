//
//  KCLoginWindowController.m
//  Cuisine
//
//  Created by Olivier Gutknecht on 06/05/09.
//  Copyright 2009 Fotonauts. All rights reserved.
//

#import "KCLoginWindowController.h"
#import "KCMainWindowController.h"


@implementation KCLoginWindowController

@synthesize defaultButton;


-(void)connect:(id)sender
{
	KCMainWindowController *c = [[KCMainWindowController alloc] initWithWindowNibName:@"MainWindow"];
	[c showWindow:self];
	[self close];
}

@end
