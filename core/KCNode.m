//
//  KCNode.m
//  Casserole
//
//  Created by Olivier Gutknecht on 5/9/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "KCNode.h"
#import "KCApplicationDelegate.h"
#import "KCNetworkOperation.h"
#import "KCChefConnection.h"

@implementation KCNode
@synthesize attributes;

- (BOOL)isLeaf;  
{  
	return true;  
} 

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
				[self setAttributes:(NSDictionary*)op.result];
		}
    }
}


-(void)refresh:(id)sender
{
	NSOperationQueue* queue = [(KCApplicationDelegate*)[NSApp delegate] queue];	
	KCNetworkOperation* op = [[KCNetworkOperation alloc] init];

	NSString* urlID = [self.nodeTitle stringByReplacingOccurrencesOfString:@"." withString:@"_"]; 
	op.url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/nodes/%@.json", self.connection.serverURL, urlID]];
	op.type = @"get.node";
	op.summary = [NSString stringWithFormat:@"Refreshing node %@",self.nodeTitle];
	[op addObserver:self forKeyPath:@"isFinished" options:0 context:nil]; 
	[queue addOperation:op];
}

@end
