//
//  KCLoginWindowController.m
//  Cuisine
//
//  Created by Olivier Gutknecht on 06/05/09.
//  Copyright 2009 Fotonauts. All rights reserved.
//

#import "KCLoginWindowController.h"
#import "KCMainWindowController.h"
#import "KCNetworkOperation.h"
#import "KCApplicationDelegate.h"


@implementation KCLoginWindowController
@synthesize defaultButton;

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context 
{ 
	if([keyPath isEqual:@"isFinished"]){ 
		[object removeObserver:self forKeyPath:@"isFinished"]; 
		KCNetworkOperation* op = (KCNetworkOperation*)object;
		if (op.error!=nil) {
			NSAlert* a = [NSAlert alertWithError:op.error];
			[a runModal];
		}
		else {
			KCChefConnection* chef = [[KCChefConnection alloc] init];
			chef.serverURL = [urlField stringValue];
			[chef refresh:self];
			
			[self close];
			KCMainWindowController *c = [[KCMainWindowController alloc] initWithWindowNibName:@"MainWindow"];
			[c setChefConnection:chef];
			[c showWindow:self];
			[[c window] makeKeyAndOrderFront:self];
		}
	} else { 
		[super observeValueForKeyPath:keyPath ofObject:object change:change context:context]; 
	} 
}

-(void)connect:(id)sender
{
	NSString* urlString = [urlField stringValue];
	NSURL* url = [NSURL URLWithString:urlString];
	if (url==nil)
		return;
	
	NSOperationQueue* queue = [(KCApplicationDelegate*)[NSApp delegate] queue];
	KCNetworkOperation* op = [[KCNetworkOperation alloc] init];
	op.url =  [NSURL URLWithString:[NSString stringWithFormat:@"%@/nodes.json", [url description]]]; // This is baroque, let's fix it
	[op addObserver:self forKeyPath:@"isFinished" options:0 context:nil]; 
	[queue addOperation:op];
}


@end
