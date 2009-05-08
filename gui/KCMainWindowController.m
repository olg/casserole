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
#import "KCStatusController.h"
#import "KCNodesController.h"
#import "KCCookbookController.h"
#import "KCImageAndTextCell.h"


@implementation KCMainWindowController

@synthesize sourceController;
@synthesize sourceContents;
@synthesize currentView;
@synthesize sourceView;

#define COLUMNID_NAME @"NameColumn"

- (void)awakeFromNib
{
	NSTableColumn *tableColumn = [sourceView tableColumnWithIdentifier:COLUMNID_NAME];
	KCImageAndTextCell *imageAndTextCell = [[KCImageAndTextCell alloc] init];
	[imageAndTextCell setEditable:NO];
	[tableColumn setDataCell:imageAndTextCell];

	[[self window] setAutorecalculatesContentBorderThickness:YES forEdge:NSMinYEdge];
	[[self window] setContentBorderThickness:32 forEdge:NSMinYEdge];

	NSMutableArray* a = [NSMutableArray array];
	KCNode *node;
	KCNode *child;
	node = [[KCNode alloc] init];
	[node setNodeTitle:@"Status"];
	[a addObject:node];
	[node setIsLeaf:true];
	node = [[KCNode alloc] init];
	[node setNodeTitle:@"Nodes"];
	[node setIsLeaf:false];
	child = [[KCNode alloc] init];
	[child setNodeTitle:@"test1.ftnx.net"];
	[child setIsLeaf:true];
	[node addObject:child];
	child = [[KCNode alloc] init];
	[child setNodeTitle:@"test2.ftnx.net"];
	[child setIsLeaf:true];
	[node addObject:child];
	child = [[KCNode alloc] init];
	[child setNodeTitle:@"test3.ftnx.net"];
	[child setIsLeaf:true];
	[node addObject:child];
	child = [[KCNode alloc] init];
	[child setNodeTitle:@"test4.ftnx.net"];
	[child setIsLeaf:true];
	[node addObject:child];
	[a addObject:node];
	node = [[KCNode alloc] init];
	[node setNodeTitle:@"Cookbooks"];
	[node setIsLeaf:false];
	child = [[KCNode alloc] init];
	[child setNodeTitle:@"Apache2"];
	[child setIsLeaf:true];
	[node addObject:child];
	child = [[KCNode alloc] init];
	[child setNodeTitle:@"CouchDB"];
	[child setIsLeaf:true];
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
	
	if ([title isEqualToString:@"Registrations"]) 
	{
		KCRegistrationsController* registrationsController =
		[[KCRegistrationsController alloc] initWithNibName:@"Registrations" bundle:nil];
		if (registrationsController != nil) 
		{		
			currentViewController = registrationsController;	// keep track of the current view controller
			[currentViewController setTitle:@"Registrations table"];
		}
	}
	else if ([title isEqualToString:@"Search"]) 
	{
		KCSearchController* searchController =
		[[KCSearchController alloc] initWithNibName:@"Search" bundle:nil];
		if (searchController != nil) 
		{		
			currentViewController = searchController;	// keep track of the current view controller
			[currentViewController setTitle:@"Search"];
		}
	}
	else if ([title isEqualToString:@"Nodes"]) 
	{
		KCNodesController* nodesController =
		[[KCNodesController alloc] initWithNibName:@"Nodes" bundle:nil];
		if (nodesController != nil) 
		{		
			currentViewController = nodesController;	// keep track of the current view controller
			[currentViewController setTitle:@"Nodes"];
		}
	}
	else if ([title isEqualToString:@"Apache2"]) 
	{
		KCCookbookController* cookbookController =
		[[KCCookbookController alloc] initWithNibName:@"Cookbook" bundle:nil];
		if (cookbookController != nil) 
		{		
			currentViewController = cookbookController;	// keep track of the current view controller
			[currentViewController setTitle:@"Cookbook"];
		}
	}
	else
	{
		KCStatusController* statusController =
		[[KCStatusController alloc] initWithNibName:@"Status" bundle:nil];
		if (statusController != nil) 
		{		
			currentViewController = statusController;	// keep track of the current view controller
			[currentViewController setTitle:@"Status"];
		}
	}
	
			
	[currentView addSubview: [currentViewController view]];

	// make sure we automatically resize the controller's view to the current window size
	[[currentViewController view] setFrame: [currentView bounds]];	
}
	
- (void)outlineView:(NSOutlineView *)olv willDisplayCell:(NSCell*)cell forTableColumn:(NSTableColumn *)tableColumn item:(id)item
{
	[(KCImageAndTextCell*)cell setImage:nil];
	if ([[tableColumn identifier] isEqualToString:COLUMNID_NAME])
	{
		if ([cell isKindOfClass:[KCImageAndTextCell class]])
		{
			item = [item representedObject];
			if ([[item nodeTitle] isEqualToString:@"Nodes"])
				[(KCImageAndTextCell*)cell setImage:[NSImage imageNamed:NSImageNameNetwork]];
			if ([[item nodeTitle] isEqualToString:@"Registrations"])
				[(KCImageAndTextCell*)cell setImage:[NSImage imageNamed:NSImageNameUserGroup]];
			if ([[item nodeTitle] isEqualToString:@"All active"])
				[(KCImageAndTextCell*)cell setImage:[NSImage imageNamed:NSImageNameAdvanced]];
			if ([[item nodeTitle] isEqualToString:@"Backend nodes"])
				[(KCImageAndTextCell*)cell setImage:[NSImage imageNamed:NSImageNameAdvanced]];
			if ([[item nodeTitle] isEqualToString:@"Search"])
				[(KCImageAndTextCell*)cell setImage:[NSImage imageNamed:@"Spotlight"]];//NSImageNameAdvanced]];
			if ([[item nodeTitle] isEqualToString:@"Cookbooks"])
				[(KCImageAndTextCell*)cell setImage:[NSImage imageNamed:NSImageNameMultipleDocuments]];
			if ([[item nodeTitle] isEqualToString:@"Apache2"])
				[(KCImageAndTextCell*)cell setImage:[NSImage imageNamed:@"NSMysteryDocument"]];
			if ([[item nodeTitle] isEqualToString:@"test1.ftnx.net"])
				[(KCImageAndTextCell*)cell setImage:[NSImage imageNamed:@"ubuntu.gif"]];
			if ([[item nodeTitle] isEqualToString:@"test2.ftnx.net"])
				[(KCImageAndTextCell*)cell setImage:[NSImage imageNamed:@"ubuntu"]];
			if ([[item nodeTitle] isEqualToString:@"test3.ftnx.net"])
				[(KCImageAndTextCell*)cell setImage:[NSImage imageNamed:@"centos"]];
			if ([[item nodeTitle] isEqualToString:@"test4.ftnx.net"])
				[(KCImageAndTextCell*)cell setImage:[NSImage imageNamed:@"linux"]];
			if ([[item nodeTitle] isEqualToString:@"Passenger"])
				[(KCImageAndTextCell*)cell setImage:[NSImage imageNamed:@"NSMysteryDocument"]];
			if ([[item nodeTitle] isEqualToString:@"CouchDB"])
				[(KCImageAndTextCell*)cell setImage:[NSImage imageNamed:@"NSMysteryDocument"]];
			if ([[item nodeTitle] isEqualToString:@"Status"])
				[(KCImageAndTextCell*)cell setImage:[NSImage imageNamed:NSImageNameInfo]];
		}
	}
}

- (void)outlineViewSelectionDidChange:(NSNotification *)notification
{
	NSArray *selection = [sourceController selectedObjects];
	if ([selection count] == 1)
		[self changeItemView];
}

@end
