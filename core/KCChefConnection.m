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
#import "KCCookbook.h"


@implementation KCChefConnection
@synthesize serverURL;
@synthesize nodes;
@synthesize cookbooks;
@synthesize registrations;

// /cookbooks/varnish/recipes?id=balancer.rb

-(id)init
{
	[super init];
	[self setNodes:[NSMutableArray array]];
	[self setCookbooks:[NSMutableArray array]];
	[self setRegistrations:[NSMutableArray array]];
	return self;
}

-(void)addCookbook:(KCCookbook*)node
{
	NSSortDescriptor* sort = [[NSSortDescriptor alloc] initWithKey:@"nodeTitle" ascending:YES];
	[self willChangeValueForKey:@"cookbooks"];
	[cookbooks addObject:node];
	[cookbooks sortUsingDescriptors:[NSArray arrayWithObject:sort]];
	[self didChangeValueForKey:@"cookbooks"];
}

-(void)addNode:(KCNode*)node
{
	NSSortDescriptor* sort = [[NSSortDescriptor alloc] initWithKey:@"nodeTitle" ascending:YES];
	[self willChangeValueForKey:@"nodes"];
	[nodes addObject:node];
	[nodes sortUsingDescriptors:[NSArray arrayWithObject:sort]];
	[self didChangeValueForKey:@"nodes"];
}

-(void)processOperationResult:(KCNetworkOperation*)op
{
	NSArray* array = (NSArray*)op.result;
	if ([op.type isEqualToString:@"get.nodes"]) {
		[self willChangeValueForKey:@"nodes"];
		[nodes removeAllObjects];
		for (NSString *element in array) {
			KCNode* node = [[KCNode alloc] init];
			node.nodeTitle = element;
			node.connection = self;
			[self addNode:node];
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
	if ([op.type isEqualToString:@"get.recipes"]) {
		for (NSDictionary *element in array) {
			NSString* cookbookName = [element objectForKey:@"cookbook"];
			NSString* name = [element objectForKey:@"name"];
			KCCookbook* node = [self cookbookForName:cookbookName];
			if (node==nil) {
				node = [[KCCookbook alloc] init];
				[node setNodeTitle:cookbookName];
				node.connection = self;
				[self addCookbook:node];
			}
			[node addRecipe:name];
			// [node refreshRecipe:recipeName];
		}
	}
	if ([op.type isEqualToString:@"get.attributes"]) {
		for (NSDictionary *element in array) {
			NSString* cookbookName = [element objectForKey:@"cookbook"];
			NSString* name = [element objectForKey:@"name"];
			KCCookbook* node = [self cookbookForName:cookbookName];
			if (node==nil) {
				node = [[KCCookbook alloc] init];
				[node setNodeTitle:cookbookName];
				node.connection = self;
				[self addCookbook:node];
			}
			[node addAttribute:name];
			//						[node refreshRecipe:recipeName];
		}
	}
	if ([op.type isEqualToString:@"get.definitions"]) {
		for (NSDictionary *element in array) {
			NSString* cookbookName = [element objectForKey:@"cookbook"];
			NSString* name = [element objectForKey:@"name"];
			KCCookbook* node = [self cookbookForName:cookbookName];
			if (node==nil) {
				node = [[KCCookbook alloc] init];
				[node setNodeTitle:cookbookName];
				node.connection = self;
				[self addCookbook:node];
			}
			[node addDefinition:name];
			//						[node refreshRecipe:recipeName];
		}
	}
	if ([op.type isEqualToString:@"get.libraries"]) {
		for (NSDictionary *element in array) {
			NSString* cookbookName = [element objectForKey:@"cookbook"];
			NSString* name = [element objectForKey:@"name"];
			KCCookbook* node = [self cookbookForName:cookbookName];
			if (node==nil) {
				node = [[KCCookbook alloc] init];
				[node setNodeTitle:cookbookName];
				node.connection = self;
				[self addCookbook:node];
			}
			[node addLibrary:name];
			//						[node refreshRecipe:recipeName];
		}
	}
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
				[self performSelectorOnMainThread:@selector(processOperationResult:) withObject:op waitUntilDone:false];
		}
	}
}


-(KCCookbook*)cookbookForName:(NSString*)name
{
	// This access is inefficient, but everything will change with the new revision of the REST API.
	for (KCCookbook* c in cookbooks)
	{
		if ([[c nodeTitle] isEqualToString:name])
			return c;
	}
	return nil;
}

-(void)refresh:(id)sender
{
	[cookbooks removeAllObjects];

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

	KCNetworkOperation* cookbookOp1 = [[KCNetworkOperation alloc] init];
	cookbookOp1.type = @"get.recipes";
	cookbookOp1.summary = @"Refreshing recipes";
	cookbookOp1.url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/cookbooks/_recipe_files", self.serverURL]];
	[cookbookOp1 addObserver:self forKeyPath:@"isFinished" options:0 context:nil];
	[queue addOperation:cookbookOp1];

	KCNetworkOperation* cookbookOp2 = [[KCNetworkOperation alloc] init];
	cookbookOp2.type = @"get.attributes";
	cookbookOp2.summary = @"Refreshing attribute files";
	cookbookOp2.url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/cookbooks/_attribute_files", self.serverURL]];
	[cookbookOp2 addObserver:self forKeyPath:@"isFinished" options:0 context:nil];
	[queue addOperation:cookbookOp2];

	KCNetworkOperation* cookbookOp3 = [[KCNetworkOperation alloc] init];
	cookbookOp3.type = @"get.definitions";
	cookbookOp3.summary = @"Refreshing definitions";
	cookbookOp3.url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/cookbooks/_definition_files", self.serverURL]];
	[cookbookOp3 addObserver:self forKeyPath:@"isFinished" options:0 context:nil];
	[queue addOperation:cookbookOp3];

	KCNetworkOperation* cookbookOp4 = [[KCNetworkOperation alloc] init];
	cookbookOp4.type = @"get.libraries";
	cookbookOp4.summary = @"Refreshing libraries";
	cookbookOp4.url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/cookbooks/_library_files", self.serverURL]];
	[cookbookOp4 addObserver:self forKeyPath:@"isFinished" options:0 context:nil];
	[queue addOperation:cookbookOp4];
}

@end
