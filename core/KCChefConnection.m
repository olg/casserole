//
//  KCChefConnection.m
//  Cuisine
//
//  Created by Olivier Gutknecht on 09/05/09.
//  Copyright 2009 Fotonauts. All rights reserved.
//

#import "KCChefConnection.h"
#import "KCApplicationDelegate.h"
#import "KCNetworkOperation.h"


@implementation KCChefConnection
@synthesize serverURL;

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
			//NSLog(@"%@ -> %@ %@ %@",op.url, op.data, op.result, op.error);
		}
	} else { 
		[super observeValueForKeyPath:keyPath ofObject:object change:change context:context]; 
	} 
}


-(void)initialFetch;
{
	NSOperationQueue* queue = [(KCApplicationDelegate*)[NSApp delegate] queue];

	KCNetworkOperation* nodesOp = [[KCNetworkOperation alloc] init];
	nodesOp.url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/nodes.json", self.serverURL]];
	[nodesOp addObserver:self forKeyPath:@"isFinished" options:0 context:nil]; 
	[queue addOperation:nodesOp];

	KCNetworkOperation* registrationsOp = [[KCNetworkOperation alloc] init];
	registrationsOp.url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/registrations.json", self.serverURL]];
	[registrationsOp addObserver:self forKeyPath:@"isFinished" options:0 context:nil]; 
	[queue addOperation:registrationsOp];
}

@end
