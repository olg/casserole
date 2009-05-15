//
//  KCChefConnection.m
//  Casserole
//
//  Created by Olivier Gutknecht on 09/05/09.
//  Copyright 2009 Fotonauts. All rights reserved.
//

#import "KCChefConnection.h"
#import "KCApplicationDelegate.h"
#import "KCNetworkOperation.h"
#import "KCRegistration.h"
#import "KCNode.h"


@implementation KCChefConnection
@synthesize serverURL;
@synthesize nodes;
@synthesize registrations;

-(id)init
{
	[super init];
	[self setNodes:[NSMutableArray array]];
	[self setRegistrations:[NSMutableArray array]];
	return self;
}

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
			if ([op.result isKindOfClass:[NSArray class]])
			{
				NSArray* array = (NSArray*)op.result;
				if ([op.type isEqualToString:@"get.nodes"]) {
					[self willChangeValueForKey:@"nodes"];
					[nodes removeAllObjects];
					for (NSString *element in array) {
						KCNode* node = [[KCNode alloc] init];
						node.nodeTitle = element;
						node.connection = self;
						[nodes addObject:node];
						[node refresh:self];
					}
					[self didChangeValueForKey:@"nodes"];
				}
				if ([op.type isEqualToString:@"get.registrations"]) { 
					[registrations removeAllObjects];
					for (NSDictionary *element in array) {
						KCRegistration* node = [[KCRegistration alloc] init];
						node.nodeTitle = [element objectForKey:@"name"];
						node.content = element; // We shouldn't duplicate content and nodeTitle, fix this.
						node.connection = self;
						[registrations addObject:node];
					}
				}
			}
		}
	} 
}


-(void)refresh:(id)sender
{
	NSOperationQueue* queue = [(KCApplicationDelegate*)[NSApp delegate] queue];

	KCNetworkOperation* nodesOp = [[KCNetworkOperation alloc] init];
	nodesOp.url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/nodes.json", self.serverURL]];
	nodesOp.type = @"get.nodes";
	nodesOp.summary = @"Refreshing nodes list";
	[nodesOp addObserver:self forKeyPath:@"isFinished" options:0 context:nil]; 
	[queue addOperation:nodesOp];

	KCNetworkOperation* registrationsOp = [[KCNetworkOperation alloc] init];
	registrationsOp.type = @"get.registrations";
	registrationsOp.summary = @"Refreshing registrations";
	registrationsOp.url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/registrations.json", self.serverURL]];
	[registrationsOp addObserver:self forKeyPath:@"isFinished" options:0 context:nil]; 
	[queue addOperation:registrationsOp];
}

@end
