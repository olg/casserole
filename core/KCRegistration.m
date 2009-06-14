//
//  KCRegistration.m
//  Casserole
//
//  Created by Olivier Gutknecht on 09/05/09.
//  Copyright 2009 Fotonauts. All rights reserved.
//

#import "KCRegistration.h"
#import "KCApplicationDelegate.h"
#import "KCNetworkOperation.h"
#import "KCChefConnection.h"

@implementation KCRegistration
@synthesize content;

- (void)observeValueForKeyPath:(NSString *)keyPath
					  ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{
    if ([keyPath isEqual:@"isFinished"]) {
		KCNetworkOperation* op = (KCNetworkOperation*)object;
		if (op.error!=nil) {
			NSAlert* a = [NSAlert alertWithError:op.error];
			[a runModal];
		}
		else {
			if ([op.result isKindOfClass:[NSDictionary class]])
				[self setContent:(NSDictionary*)op.result];
		}
    }
}


-(void)refresh:(id)sender
{
	NSOperationQueue* queue = [(KCApplicationDelegate*)[NSApp delegate] queue];	
	KCNetworkOperation* op = [[[KCNetworkOperation alloc] init] autorelease];
	
	NSString* urlID = [self.nodeTitle stringByReplacingOccurrencesOfString:@"." withString:@"_"]; 
	op.url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/registrations/%@.json", self.connection.serverURL, urlID]];
	op.type = @"get.node";
	op.summary = [NSString stringWithFormat:@"Refreshing registration %@",self.nodeTitle];
	[op addObserver:self forKeyPath:@"isFinished" options:0 context:nil]; 
	[queue addOperation:op];
}


@end
