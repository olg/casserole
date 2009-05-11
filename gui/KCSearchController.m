//
//  KCSearchController.m
//  Casserole
//
//  Created by Olivier Gutknecht on 5/7/09.
//  Copyright 2009 Fotonauts. All rights reserved.
//

#import "KCSearchController.h"
#import "KCNetworkOperation.h"
#import "KCApplicationDelegate.h"

@implementation KCSearchController
@synthesize results;

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
			[self setResults:[NSDictionary dictionary]];
			if ([op.result isKindOfClass:[NSArray class]])
			{
				NSArray* a = (NSArray*)op.result;
				if (([a count]==1) && [[a objectAtIndex:0] isKindOfClass:[NSDictionary class]])
					[self setResults:[a objectAtIndex:0]];
			}
		}
    }
}


- (IBAction)search:(id)sender;
{
	NSString* q;
	NSString* a;
	if (query==nil)
		q = @"";
	else
		q = [query stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	if (attributes==nil)
		a = @"";
	else
		a = [attributes stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

	NSOperationQueue* queue = [(KCApplicationDelegate*)[NSApp delegate] queue];
	KCNetworkOperation* op = [[KCNetworkOperation alloc] init];
	op.url =  [NSURL URLWithString:[NSString stringWithFormat:@"%@/search/node.json?q=%@&a=%@", self.chefConnection.serverURL, q, a]]; // This is baroque, let's fix it
	op.type = @"search.node";
	op.summary = @"Searching index";
	[op addObserver:self forKeyPath:@"isFinished" options:0 context:nil]; 
	[queue addOperation:op];
}


@end
