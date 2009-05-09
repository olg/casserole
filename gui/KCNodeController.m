//
//  KCNodeController.m
//  Cuisine
//
//  Created by Olivier Gutknecht on 09/05/09.
//  Copyright 2009 Fotonauts. All rights reserved.
//

#import "KCNodeController.h"
#import "KCNode.h"


@implementation KCNodeController
@synthesize recipes;
@synthesize name;
@synthesize tags;
@synthesize attributes;

-(void)awakeFromNib
{
	[self setName:@"test1.ftnx.net"];
	[self setRecipes:@"vim,emacs,passenger,couchdb"];
	[self setTags:@"cloud1,production,load-balanced"];
	
	NSMutableArray* a = [NSMutableArray array];
	KCNode *node;
	KCNode *child;
	node = [[KCNode alloc] init];
	[node setNodeTitle:@"platform"];
	[node setNodeValue:@"ubuntu"];
	[node setIsLeaf:true];
	[a addObject:node];

	node = [[KCNode alloc] init];
	[node setNodeTitle:@"activemq"];
	[node setIsLeaf:false];

	child = [[KCNode alloc] init];
	[child setNodeTitle:@"gid"];
	[child setNodeValue:@"992"];
	[child setIsLeaf:true];
	[node addObject:child];
	
	child = [[KCNode alloc] init];
	[child setNodeTitle:@"version"];
	[child setNodeValue:@"5.1.0"];
	[child setIsLeaf:true];
	[node addObject:child];
	
	child = [[KCNode alloc] init];
	[child setNodeTitle:@"mirror_url"];
	[child setNodeValue:@"http://apache.osuosl.org/activemq"];
	[child setIsLeaf:true];
	[node addObject:child];
	
	[a addObject:node];

	
	node = [[KCNode alloc] init];
	[node setNodeTitle:@"kernel"];
	[node setIsLeaf:false];
	
	child = [[KCNode alloc] init];
	[child setNodeTitle:@"machine"];
	[child setNodeValue:@"i686"];
	[child setIsLeaf:true];
	[node addObject:child];
	
	child = [[KCNode alloc] init];
	[child setNodeTitle:@"name"];
	[child setNodeValue:@"Linux"];
	[child setIsLeaf:true];
	[node addObject:child];
	
	child = [[KCNode alloc] init];
	[child setNodeTitle:@"version"];
	[child setNodeValue:@"#42-Ubuntu SMP Fri Apr 17 02:48:10 UTC 2009"];
	[child setIsLeaf:true];
	[node addObject:child];

	child = [[KCNode alloc] init];
	[child setNodeTitle:@"release"];
	[child setNodeValue:@"2.6.28-11-server"];
	[child setIsLeaf:true];
	[node addObject:child];
	
	[a addObject:node];
	[self setAttributes:a];
	
}

@end
