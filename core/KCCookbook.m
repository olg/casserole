//
//  KCCookbook.m
//  Casserole
//
//  Created by Olivier Gutknecht on 17/05/09.
//  Copyright 2009 Fotonauts. All rights reserved.
//

#import "KCCookbook.h"


@implementation KCCookbook
@synthesize recipes;
@synthesize libraries;
@synthesize attributes;
@synthesize content;
@synthesize definitions;


-(id)init
{
	[super init];

	content = [[NSMutableArray alloc] init];

	attributes = [[KCChefNode alloc] init];
	[attributes setNodeTitle:@"Attributes"];
	[attributes setIsLeaf:false];
	[attributes setConnection:self.connection];
	[content addObject:attributes];

	definitions = [[KCChefNode alloc] init];
	[definitions setNodeTitle:@"Defintions"];
	[definitions setIsLeaf:false];
	[definitions setConnection:self.connection];
	[content addObject:definitions];

	libraries = [[KCChefNode alloc] init];
	[libraries setNodeTitle:@"Libraries"];
	[libraries setIsLeaf:false];
	[libraries setConnection:self.connection];
	[content addObject:libraries];

	recipes = [[KCChefNode alloc] init];
	[recipes setNodeTitle:@"Recipes"];
	[recipes setIsLeaf:false];
	[recipes setConnection:self.connection];
	[content addObject:recipes];
	
	[self setIsLeaf:true];
	
	return self;
}

-(void)addRecipe:(NSString*)name
{
	KCChefNode* node = [self recipeForName:name];
	if (node==nil) {
		node = [[KCChefNode alloc] init];
		node.nodeTitle = name;
		node.nodeType = @"recipe";
		node.connection = self.connection;
		node.parent = self;
		[node setIsLeaf:true];
		[recipes addSortedObject:node];
		[recipes setNodeTitle:[NSString stringWithFormat:@"Recipes (%d)", [[recipes children] count]]];
	}
}

-(KCChefNode*)recipeForName:(NSString*)name
{
	// This access is inefficient, but everything will change with the new revision of the REST API.
	for (KCChefNode* c in [recipes children])
		if ([[c nodeTitle] isEqualToString:name])
			return c;
	return nil;
}

-(void)addAttribute:(NSString*)name
{
	KCChefNode* node = [self attributeForName:name];
	if (node==nil) {
		node = [[KCChefNode alloc] init];
		node.nodeTitle = name;
		node.nodeType = @"attribute";
		node.connection = self.connection;
		node.parent = self;
		[node setIsLeaf:true];
		[attributes addSortedObject:node];
		[attributes setNodeTitle:[NSString stringWithFormat:@"Attributes (%d)", [[attributes children] count]]];
	}
}

-(KCChefNode*)attributeForName:(NSString*)name
{
	// This access is inefficient, but everything will change with the new revision of the REST API.
	for (KCChefNode* c in [attributes children])
		if ([[c nodeTitle] isEqualToString:name])
			return c;
	return nil;
}

-(void)addDefinition:(NSString*)name
{
	KCChefNode* node = [self definitionForName:name];
	if (node==nil) {
		node = [[KCChefNode alloc] init];
		node.nodeTitle = name;
		node.nodeType = @"definition";
		node.connection = self.connection;
		node.parent = self;
		[node setIsLeaf:true];
		[definitions addSortedObject:node];
		[definitions setNodeTitle:[NSString stringWithFormat:@"Definitions (%d)", [[definitions children] count]]];
	}
}

-(KCChefNode*)definitionForName:(NSString*)name
{
	// This access is inefficient, but everything will change with the new revision of the REST API.
	for (KCChefNode* c in [definitions children])
		if ([[c nodeTitle] isEqualToString:name])
			return c;
	return nil;
}

-(void)addLibrary:(NSString*)name
{
	KCChefNode* node = [self libraryForName:name];
	if (node==nil) {
		node = [[KCChefNode alloc] init];
		node.nodeTitle = name;
		node.nodeType = @"library";
		node.parent = self;
		node.connection = self.connection;
		[node setIsLeaf:true];
		[libraries addSortedObject:node];
		[libraries setNodeTitle:[NSString stringWithFormat:@"Libraries (%d)", [[libraries children] count]]];
	}
}

-(KCChefNode*)libraryForName:(NSString*)name
{
	// This access is inefficient, but everything will change with the new revision of the REST API.
	for (KCChefNode* c in [libraries children])
		if ([[c nodeTitle] isEqualToString:name])
			return c;
	return nil;
}

-(NSString*)iconName
{
	return @"NSMysteryDocument";
}

@end
