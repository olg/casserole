//
//  KCCookbooksController.m
//  Cuisine
//
//  Created by Olivier Gutknecht on 09/05/09.
//  Copyright 2009 Fotonauts. All rights reserved.
//

#import "KCCookbooksController.h"
#import "KCNode.h"


@implementation KCCookbooksController
@synthesize cookbooks;

- (void)awakeFromNib
{
	NSMutableArray* a = [NSMutableArray array];
	KCNode *node;
	node = [[KCNode alloc] init];
	[node setNodeTitle:@"CouchDB"];
	[node setIsLeaf:true];
	[a addObject:node];
	node = [[KCNode alloc] init];
	[node setNodeTitle:@"Apache"];
	[node setIsLeaf:true];
	[a addObject:node];
	node = [[KCNode alloc] init];
	[node setNodeTitle:@"Passenger"];
	[node setIsLeaf:true];
	[a addObject:node];	
	[self setCookbooks:a];
}

@end
