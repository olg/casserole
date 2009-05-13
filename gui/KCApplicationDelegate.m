//
//  KCApplicationDelegate.m
//  Casserole
//
//  Created by Olivier Gutknecht on 06/05/09.
//  Copyright 2009 Fotonauts. All rights reserved.
//

#import "KCApplicationDelegate.h"
#import "KCLoginWindowController.h"
#import "KCValueTransformers.h"

@implementation KCApplicationDelegate
@synthesize queue;

+ (void)initialize {
    KCStringArrayTransformer *fileSizeTransformer = [[[KCStringArrayTransformer alloc] init] autorelease];
    [NSValueTransformer setValueTransformer:fileSizeTransformer forName:@"KCStringArrayTransformer"];
}


- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
	[self setQueue:[[NSOperationQueue alloc] init]];
	KCLoginWindowController *c = [[KCLoginWindowController alloc] initWithWindowNibName:@"LoginWindow"];
	[c showWindow:self];
}


-(void)openURL:(id)sender
{
	NSLog(@"s:%@",sender);
	NSString* text = [sender title];
	NSURL* url = [NSURL URLWithString:text];
	[[NSWorkspace sharedWorkspace] openURL:url];
}

-(void)refresh:(id)sender
{
}

@end
