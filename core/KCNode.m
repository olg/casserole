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
@synthesize chefAttributesCount;

- (BOOL)isLeaf;  
{  
	return true;  
} 

-(bool)countLeafNodes:(KCAttributeNode*)node
{
	if (![node isLeaf])
	{
		int results = 0;
		if (nodeValue!=nil)
			results = 1;
		for (KCAttributeNode* subnode in [node children])
			results += ([self countLeafNodes:subnode]);
		return results;
	}
	else
		return 1;
}

-(int)countLeafAttributes
{
	int results = 0;
	for (KCAttributeNode* node in chefAttributes)
		results += ([self countLeafNodes:node]);
	return results;
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
				[self setChefAttributesCount:[self countLeafAttributes]];
			}
		}
    }
}

-(int)countNodes:(KCAttributeNode*)node containingString:(NSString*)searchString
{
	int result = 0;
	NSString* text = [node nodeTitle];
	NSString* value = [node nodeValue];
	NSRange range1 = [text rangeOfString:searchString];
	NSRange range2 = [value rangeOfString:searchString];
	if (![node isLeaf])
	{
		for (KCAttributeNode* subnode in [node children]) {
			result += [self countNodes:subnode containingString:searchString];
		}
	}
	if (((range1.location!=NSNotFound)&&(text!=nil))||((range2.location!=NSNotFound)&&(value!=nil))) {
		result++;
	}
	return result;
}

-(int)countNodesContainingString:(NSString*)searchString
{
	int result = 0;
	for (KCAttributeNode* node in chefAttributes)
		result += [self countNodes:node containingString:searchString];
	return result;
}


-(bool)addNodes:(KCAttributeNode*)node containingString:(NSString*)searchString toArray:(NSMutableArray*)array
{
	bool found = false;
	NSString* text = [node nodeTitle];
	NSString* value = [node nodeValue];
	NSRange range1 = [text rangeOfString:searchString];
	NSRange range2 = [value rangeOfString:searchString];
	if (![node isLeaf])
	{
		for (KCAttributeNode* subnode in [node children]) {
			if ([self addNodes:subnode containingString:searchString toArray:array])
				found = true;
		}
	}
	if (found || (((range1.location!=NSNotFound)&&(text!=nil))||((range2.location!=NSNotFound)&&(value!=nil)))) {
		[array addObject:node];
		found = true;
	}
	return found;
}

-(NSArray*)attributeNodesContaining:(NSString*)searchString
{
	NSMutableArray* array = [NSMutableArray array];
	for (KCAttributeNode* node in chefAttributes)
		[self addNodes:node containingString:searchString toArray:array];
	return array;
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
