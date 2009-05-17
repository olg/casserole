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

@synthesize registrationsController;
@synthesize searchController;
@synthesize nodeController;
@synthesize cookbooksController;
@synthesize nodesController;
@synthesize cookbookController;
@synthesize statusController;


#define COLUMNID_NAME @"NameColumn"

-(void)prepareSourceContent
{
	NSMutableArray* a = [NSMutableArray array];
	KCViewControllerNode *viewNode;
	KCChefNode *child;
	KCNodesProxy *nodeProxy;
	
	viewNode = [[KCViewControllerNode alloc] init];
	viewNode.viewController = statusController;
	[viewNode setIsLeaf:true];
	[a addObject:viewNode];
	
	nodeProxy = [[KCNodesProxy alloc] init];
	nodeProxy.connection = self.chefConnection;
	[nodeProxy setNodeTitle:@"Nodes"];
	[a addObject:nodeProxy];
	
	viewNode = [[KCViewControllerNode alloc] init];
	viewNode.viewController = cookbooksController;
	[viewNode setIsLeaf:false];
	child = [[KCChefNode alloc] init];
	[child setNodeTitle:@"Apache2"];
	[child setIsLeaf:true];
	[viewNode addObject:child];
	[a addObject:viewNode];
	
	viewNode = [[KCViewControllerNode alloc] init];
	viewNode.viewController = registrationsController;
	[viewNode setIsLeaf:true];
	[a addObject:viewNode];
	
	viewNode = [[KCViewControllerNode alloc] init];
	((KCViewControllerNode*)viewNode).viewController = searchController;
	[viewNode setIsLeaf:true];
	
	/*	child = [[KCChefNode alloc] init];
	 [child setNodeTitle:@"Rails nodes"];
	 [child setIsLeaf:true];
	 [node addObject:child];
	 child = [[KCChefNode alloc] init];
	 [child setNodeTitle:@"Ubuntu nodes"];
	 [child setIsLeaf:true];
	 [node addObject:child];*/
	[a addObject:viewNode];
	
	
	[self setSourceContents:a];
}

- (void)awakeFromNib
{	
	[self setupViewControllers];
	
	NSTableColumn *tableColumn = [sourceView tableColumnWithIdentifier:COLUMNID_NAME];
	KCImageAndTextCell *imageAndTextCell = [[KCImageAndTextCell alloc] init];
	[imageAndTextCell setEditable:NO];
	[tableColumn setDataCell:imageAndTextCell];

	[[self window] setAutorecalculatesContentBorderThickness:YES forEdge:NSMinYEdge];
	[[self window] setContentBorderThickness:32 forEdge:NSMinYEdge];

	[self prepareSourceContent];
	[self addObserver:self forKeyPath:@"chefConnection.nodes.@count" options:0 context:nil]; 
}

// -------------------------------------------------------------------------------
//	outlineViewSelectionDidChange:notification
// -------------------------------------------------------------------------------

- (void)setupViewControllers
{
	registrationsController = [[KCRegistrationsController alloc] initWithNibName:@"Registrations" bundle:nil];
	registrationsController.chefConnection = self.chefConnection;
	registrationsController.windowController = self;
	[registrationsController setTitle:@"Registrations"];

	searchController = [[KCSearchController alloc] initWithNibName:@"Search" bundle:nil];
	searchController.chefConnection = self.chefConnection;
	searchController.windowController = self;
	[searchController setCanSearch:true];
	[searchController setTitle:@"Search"];

	nodeController = [[KCNodeController alloc] initWithNibName:@"Node" bundle:nil];
	nodeController.chefConnection = self.chefConnection;
	nodeController.windowController = self;
	[nodeController setCanSearch:true];
	[nodeController setTitle:@"Node"];

	cookbooksController = [[KCCookbooksController alloc] initWithNibName:@"Cookbooks" bundle:nil];
	cookbooksController.chefConnection = self.chefConnection;
	cookbooksController.windowController = self;
	[cookbooksController setTitle:@"Cookbooks"];

	nodesController = [[KCNodesController alloc] initWithNibName:@"Nodes" bundle:nil];
	nodesController.chefConnection = self.chefConnection;
	nodesController.windowController = self;
	[nodesController setTitle:@"Nodes"];

	cookbookController = [[KCCookbookController alloc] initWithNibName:@"Cookbook" bundle:nil];
	cookbookController.chefConnection = self.chefConnection;
	cookbookController.windowController = self;
	[cookbookController setTitle:@"Cookbook"];

	statusController = [[KCStatusController alloc] initWithNibName:@"Status" bundle:nil];
	statusController.chefConnection = self.chefConnection;
	statusController.windowController = self;
	[statusController setTitle:@"Status"];
}

- (void)switchView:(KCViewController*)view
{
	[sourceController removeSelectionIndexPaths:[sourceController selectionIndexPaths]];
	if (view==nodesController)
		[sourceController addSelectionIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathWithIndex:1]]];
	else
		[sourceController addSelectionIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathWithIndex:2]]];		
	[self changeItemView];
}

- (void)changeItemView
{
	NSArray		*selection = [sourceController selectedObjects];	
	KCChefNode		*node = [selection objectAtIndex:0];
	NSString	*title = [node nodeTitle];
	
	if ([currentViewController view] != nil)
		[[currentViewController view] removeFromSuperview];	// remove the current view
	
	if ([title isEqualToString:@"Registrations"]) 
	{
		[self setCurrentViewController:registrationsController];	// keep track of the current view controller
		[currentViewController setTitle:@"Registrations"];
	}
	else if ([title isEqualToString:@"Search"]) 
	{
		[self setCurrentViewController:searchController];	// keep track of the current view controller
		[currentViewController setTitle:@"Search"];
	}
	else if ([node isKindOfClass:[KCNode class]]) 
	{
		nodeController.node = (KCNode*)node;
		[self setCurrentViewController:nodeController];	// keep track of the current view controller
		[currentViewController setTitle:@"Node"];
	}
	else if ([title isEqualToString:@"Cookbooks"]) 
	{
		[self setCurrentViewController:cookbooksController];	// keep track of the current view controller
		[currentViewController setTitle:@"Cookbooks"];
	}
	else if ([title isEqualToString:@"Nodes"]) 
	{
		[self setCurrentViewController:nodesController];	// keep track of the current view controller
		[currentViewController setTitle:@"Nodes"];
	}
	else if ([title isEqualToString:@"Apache2"]) 
	{
		[self setCurrentViewController:cookbookController];	// keep track of the current view controller
		[currentViewController setTitle:@"Cookbook"];
	}
	else
	{
		[self setCurrentViewController:statusController];	// keep track of the current view controller
		[currentViewController setTitle:@"Status"];
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
			NSString* imageName = [item iconName];
			if (imageName!=nil)
				[(KCImageAndTextCell*)cell setImage:[NSImage imageNamed:imageName]];
			
			else if ([[item nodeTitle] isEqualToString:@"Apache2"]) 
				[(KCImageAndTextCell*)cell setImage:[NSImage imageNamed:@"NSMysteryDocument"]];
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
	[self prepareSourceContent];
}

- (void)observeValueForKeyPath:(NSString *)keyPath
					  ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{
    if ([keyPath isEqual:@"chefConnection.nodes.@count"]) {
		[self prepareSourceContent];
    }
}



@end
