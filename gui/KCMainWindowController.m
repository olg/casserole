//
//  KCMainWindowController.m
//  Casserole
//
//  Created by Olivier Gutknecht on 06/05/09.
//  Copyright 2009 Fotonauts. All rights reserved.
//

#import "KCMainWindowController.h"
#import "KCAbstractNode.h"
#import "KCRegistrationsController.h"
#import "KCSearchController.h"
#import "KCStatusController.h"
#import "KCNodesController.h"
#import "KCNodeController.h"
#import "KCCookbooksController.h"
#import "KCCookbookController.h"
#import "KCImageAndTextCell.h"


@implementation KCMainWindowController
@synthesize currentViewController;
@synthesize sourceController;
@synthesize sourceContents;
@synthesize chefConnection;
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
	KCAbstractNode *node;
	KCAbstractNode *child;
	node = [[KCAbstractNode alloc] init];
	[node setNodeTitle:@"Status"];
	[a addObject:node];
	[node setIsLeaf:true];
	node = [[KCNodesProxy alloc] init];
	node.connection = self.chefConnection;
	[node setNodeTitle:@"Nodes"];
	[a addObject:node];
	node = [[KCAbstractNode alloc] init];
	[node setNodeTitle:@"Cookbooks"];
	[node setIsLeaf:false];
	child = [[KCAbstractNode alloc] init];
	[child setNodeTitle:@"Apache2"];
	[child setIsLeaf:true];
	[node addObject:child];
	[a addObject:node];
	node = [[KCAbstractNode alloc] init];
	[node setNodeTitle:@"Registrations"];
	[a addObject:node];
	[node setIsLeaf:true];
	node = [[KCAbstractNode alloc] init];
	[node setNodeTitle:@"Search"];
	[node setIsLeaf:false];
/*	child = [[KCAbstractNode alloc] init];
	[child setNodeTitle:@"Rails nodes"];
	[child setIsLeaf:true];
	[node addObject:child];
	child = [[KCAbstractNode alloc] init];
	[child setNodeTitle:@"Ubuntu nodes"];
	[child setIsLeaf:true];
	[node addObject:child];*/
	[a addObject:node];

	
	[self setSourceContents:a];
}

// -------------------------------------------------------------------------------
//	outlineViewSelectionDidChange:notification
// -------------------------------------------------------------------------------


- (void)changeItemView
{
	NSArray		*selection = [sourceController selectedObjects];	
	KCAbstractNode		*node = [selection objectAtIndex:0];
	NSString	*title = [node nodeTitle];
	
	if ([currentViewController view] != nil)
		[[currentViewController view] removeFromSuperview];	// remove the current view
	
	if ([title isEqualToString:@"Registrations"]) 
	{
		KCRegistrationsController* registrationsController =
		[[KCRegistrationsController alloc] initWithNibName:@"Registrations" bundle:nil];
		registrationsController.chefConnection = self.chefConnection;
		if (registrationsController != nil) 
		{		
			[self setCurrentViewController:registrationsController];	// keep track of the current view controller
			[currentViewController setTitle:@"Registrations table"];
		}
	}
	else if ([title isEqualToString:@"Search"]) 
	{
		KCSearchController* searchController =
		[[KCSearchController alloc] initWithNibName:@"Search" bundle:nil];
		searchController.chefConnection = self.chefConnection;
		if (searchController != nil) 
		{		
			[self setCurrentViewController:searchController];	// keep track of the current view controller
			[currentViewController setTitle:@"Search"];
		}
		[currentViewController setCanSearch:true];
	}
	else if ([node isKindOfClass:[KCNode class]]) 
	{
		KCNodeController* nodeController =
		[[KCNodeController alloc] initWithNibName:@"Node" bundle:nil];
		nodeController.chefConnection = self.chefConnection;
		nodeController.node = (KCNode*)node;
		if (nodeController != nil) 
		{		
			[self setCurrentViewController:nodeController];	// keep track of the current view controller
			[currentViewController setTitle:@"Node"];
		}
	}
	else if ([title isEqualToString:@"Cookbooks"]) 
	{
		KCCookbooksController* cookbooksController =
		[[KCCookbooksController alloc] initWithNibName:@"Cookbooks" bundle:nil];
		cookbooksController.chefConnection = self.chefConnection;
		if (cookbooksController != nil) 
		{		
			[self setCurrentViewController:cookbooksController];	// keep track of the current view controller
			[currentViewController setTitle:@"Cookbooks"];
		}
	}
	else if ([title isEqualToString:@"Nodes"]) 
	{
		KCNodesController* nodesController =
		[[KCNodesController alloc] initWithNibName:@"Nodes" bundle:nil];
		nodesController.chefConnection = self.chefConnection;
		if (nodesController != nil) 
		{		
			[self setCurrentViewController:nodesController];	// keep track of the current view controller
			[currentViewController setTitle:@"Nodes"];
		}
	}
	else if ([title isEqualToString:@"Apache2"]) 
	{
		KCCookbookController* cookbookController =
		[[KCCookbookController alloc] initWithNibName:@"Cookbook" bundle:nil];
		cookbookController.chefConnection = self.chefConnection;
		if (cookbookController != nil) 
		{		
			[self setCurrentViewController:cookbookController];	// keep track of the current view controller
			[currentViewController setTitle:@"Cookbook"];
		}
	}
	else
	{
		KCStatusController* statusController =
		[[KCStatusController alloc] initWithNibName:@"Status" bundle:nil];
		statusController.chefConnection = self.chefConnection;
		if (statusController != nil) 
		{		
			[self setCurrentViewController:statusController];	// keep track of the current view controller
			[currentViewController setTitle:@"Status"];
		}
	}
	
	[searchField setObjectValue:@""];
	[currentViewController setSearchPredicate:nil];
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
			
			if ([item isKindOfClass:[KCNode class]])
				[(KCImageAndTextCell*)cell setImage:[NSImage imageNamed:[[((KCNode*)item).attributes objectForKey:@"attributes"] objectForKey:@"platform"]]];
			if ([[item nodeTitle] isEqualToString:@"Nodes"])
				[(KCImageAndTextCell*)cell setImage:[NSImage imageNamed:NSImageNameNetwork]];
			else if ([[item nodeTitle] isEqualToString:@"Registrations"])
				[(KCImageAndTextCell*)cell setImage:[NSImage imageNamed:NSImageNameUserGroup]];
			else if ([[item nodeTitle] isEqualToString:@"Rails nodes"])
				[(KCImageAndTextCell*)cell setImage:[NSImage imageNamed:NSImageNameAdvanced]];
			else if ([[item nodeTitle] isEqualToString:@"Ubuntu nodes"])
				[(KCImageAndTextCell*)cell setImage:[NSImage imageNamed:NSImageNameAdvanced]];
			else if ([[item nodeTitle] isEqualToString:@"Search"])
				[(KCImageAndTextCell*)cell setImage:[NSImage imageNamed:@"Spotlight"]];//NSImageNameAdvanced]];
			else if ([[item nodeTitle] isEqualToString:@"Cookbooks"])
				[(KCImageAndTextCell*)cell setImage:[NSImage imageNamed:NSImageNameMultipleDocuments]];
			else if ([[item nodeTitle] isEqualToString:@"Apache2"])
				[(KCImageAndTextCell*)cell setImage:[NSImage imageNamed:@"NSMysteryDocument"]];
			else if ([[item nodeTitle] isEqualToString:@"test1.ftnx.net"])
				[(KCImageAndTextCell*)cell setImage:[NSImage imageNamed:@"ubuntu.gif"]];
			else if ([[item nodeTitle] isEqualToString:@"Passenger"])
				[(KCImageAndTextCell*)cell setImage:[NSImage imageNamed:@"NSMysteryDocument"]];
			else if ([[item nodeTitle] isEqualToString:@"CouchDB"])
				[(KCImageAndTextCell*)cell setImage:[NSImage imageNamed:@"NSMysteryDocument"]];
			else if ([[item nodeTitle] isEqualToString:@"Status"])
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

-(void)refresh:(id)sender
{
	[chefConnection refresh:sender];
}

@end
