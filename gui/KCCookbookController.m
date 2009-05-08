//
//  KCCookbookController.m
//  Cuisine
//
//  Created by Olivier Gutknecht on 08/05/09.
//  Copyright 2009 Fotonauts. All rights reserved.
//

#import "KCCookbookController.h"
#import "KCNode.h"

@implementation KCCookbookController
@synthesize cookbookContents;
@synthesize textView;

- (void)awakeFromNib
{
	NSMutableArray* a = [NSMutableArray array];
	KCNode *node;
	KCNode *child;
	node = [[KCNode alloc] init];
	[node setNodeTitle:@"Status"];
	[a addObject:node];
	[node setIsLeaf:true];
	node = [[KCNode alloc] init];
	[node setNodeTitle:@"Nodes"];
	[a addObject:node];
	[node setIsLeaf:false];
	node = [[KCNode alloc] init];
	[node setNodeTitle:@"Cookbooks"];
	child = [[KCNode alloc] init];
	[child setNodeTitle:@"Apache2"];
	[child setIsLeaf:true];
	[node setIsLeaf:false];
	[node addObject:child];
	[a addObject:node];
	node = [[KCNode alloc] init];
	[node setNodeTitle:@"Registrations"];
	[a addObject:node];
	[node setIsLeaf:false];
	node = [[KCNode alloc] init];
	[node setNodeTitle:@"Search"];
	[node setIsLeaf:false];
	child = [[KCNode alloc] init];
	[child setNodeTitle:@"All active"];
	[child setIsLeaf:true];
	[node addObject:child];
	child = [[KCNode alloc] init];
	[child setNodeTitle:@"Backend nodes"];
	[child setIsLeaf:true];
	[node addObject:child];
	[a addObject:node];
	
	[self setCookbookContents:a];
}

@end
