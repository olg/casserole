//
//  KCMainWindowController.m
//  Cuisine
//
//  Created by Olivier Gutknecht on 06/05/09.
//  Copyright 2009 Fotonauts. All rights reserved.
//

#import "KCMainWindowController.h"
#import "KCNode.h"


@implementation KCMainWindowController

@synthesize sourceController;
@synthesize sourceContents;
@synthesize currentView;
@synthesize sourceView;

- (void)awakeFromNib
{
	NSMutableArray* a = [NSMutableArray array];
	KCNode *node;
	KCNode *child;
	node = [[KCNode alloc] init];
	[node setNodeTitle:@"Nodes"];
	[a addObject:node];
	[node setIsLeaf:false];
	node = [[KCNode alloc] init];
	[node setNodeTitle:@"Cookbooks"];
	[a addObject:node];
	[node setIsLeaf:false];
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

	[self setSourceContents:a];
}



@end
