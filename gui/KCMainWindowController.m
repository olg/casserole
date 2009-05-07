//
//  KCMainWindowController.m
//  Cuisine
//
//  Created by Olivier Gutknecht on 06/05/09.
//  Copyright 2009 Fotonauts. All rights reserved.
//

#import "KCMainWindowController.h"
#import "KCNode.h"
#import "KCRegistrationsController.h"
#import "KCSearchController.h"


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

// -------------------------------------------------------------------------------
//	outlineViewSelectionDidChange:notification
// -------------------------------------------------------------------------------


- (void)changeItemView
{
	NSArray		*selection = [sourceController selectedObjects];	
	KCNode		*node = [selection objectAtIndex:0];
	NSString	*title = [node nodeTitle];
	
	if ([currentViewController view] != nil)
		[[currentViewController view] removeFromSuperview];	// remove the current view
	
	if ([title isEqualToString:@"Search"]) 
	{
		KCRegistrationsController* registrationsController =
		[[KCRegistrationsController alloc] initWithNibName:@"Registrations" bundle:nil];
		if (registrationsController != nil) 
		{		
			currentViewController = registrationsController;	// keep track of the current view controller
			[currentViewController setTitle:@"Registrations table"];
		}
	}
	else 
	{
		KCSearchController* searchController =
		[[KCSearchController alloc] initWithNibName:@"Search" bundle:nil];
		if (searchController != nil) 
		{		
			currentViewController = searchController;	// keep track of the current view controller
			[currentViewController setTitle:@"Search"];
		}
	}

			
	[currentView addSubview: [currentViewController view]];

	// make sure we automatically resize the controller's view to the current window size
	[[currentViewController view] setFrame: [currentView bounds]];	
}
	
- (void)outlineViewSelectionDidChange:(NSNotification *)notification
{
	NSArray *selection = [sourceController selectedObjects];
	if ([selection count] == 1)
		[self changeItemView];
}

@end
