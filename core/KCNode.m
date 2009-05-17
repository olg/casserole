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
@synthesize chefAttributes;

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
			if ([op.result isKindOfClass:[NSDictionary class]]) {
				[self setAttributes:(NSDictionary*)op.result];
				[self setChefAttributes:[self nodeTreeFromDictionary:[(NSDictionary*)op.result objectForKey:@"attributes"]]];
			}
		}
    }
}


-(NSMutableArray*)nodeTreeFromDictionary:(NSDictionary*)d
{
	NSMutableArray* result = [NSMutableArray array];
	NSArray* keys = [[d allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
	for (NSString* key in keys)
	{
		KCAttributeNode* n = [[KCAttributeNode alloc] init];
		[n setNodeTitle:key];
		id value = [d objectForKey:key];
		if ([value isKindOfClass:[NSArray class]]) {
			n.nodeType = @"Array";
			[n setIsLeaf:false];
			[n setChildren:[self nodeTreeFromArray:value]];
		}
		if ([value isKindOfClass:[NSDictionary class]]) {
			n.nodeType = @"Dictionary";
			[n setIsLeaf:false];
			[n setChildren:[self nodeTreeFromDictionary:value]];
		}
		else {
			n.nodeType = [value className];
			[n setIsLeaf:true];
			n.nodeValue = [value description];
		}
		[result addObject:n];
	}
	return result;
}

-(NSMutableArray*)nodeTreeFromArray:(NSArray*)array
{
	NSMutableArray* result = [NSMutableArray array];
	for (id value in array)
	{
		KCAttributeNode* n = [[KCAttributeNode alloc] init];
		[n setNodeTitle:@""];
		if ([value isKindOfClass:[NSArray class]]) {
			n.nodeType = @"Array";
			[n setIsLeaf:false];
			[n setChildren:[self nodeTreeFromArray:value]];
		}
		if ([value isKindOfClass:[NSDictionary class]]) {
			n.nodeType = @"Dictionary";
			[n setIsLeaf:false];
			[n setChildren:[self nodeTreeFromDictionary:value]];
		}
		else {
			n.nodeType = [value className];
			[n setIsLeaf:true];
			n.nodeValue = [value description];
		}
	}
	return result;
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

-(NSString*)iconName
{
	NSString* name = [[attributes objectForKey:@"attributes"] objectForKey:@"platform"];
	if (name!=nil)
		return name;
	else
		return NSImageNameNetwork;
}


@end
