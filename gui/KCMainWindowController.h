//
//  KCMainWindowController.h
//  Casserole
//
//  Created by Olivier Gutknecht on 06/05/09.
//  Copyright 2009 Fotonauts. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "KCViewController.h"

@class KCRegistrationsController;
@class KCSearchController;
@class KCNodeController;
@class KCCookbooksController;
@class KCNodesController;
@class KCCookbookController;
@class KCStatusController;

@interface KCMainWindowController : NSWindowController {
	IBOutlet NSTreeController	*sourceController;
	NSMutableArray				*sourceContents;
	IBOutlet NSOutlineView		*sourceView;
	NSView						*currentView;
	IBOutlet KCViewController	*currentViewController;
	KCChefConnection			*chefConnection;
	IBOutlet NSSearchField		*searchField;
	
	KCRegistrationsController* registrationsController;
	KCSearchController* searchController;
	KCNodeController* nodeController;
	KCCookbooksController* cookbooksController;
	KCNodesController* nodesController;
	KCCookbookController* cookbookController;
	KCStatusController* statusController;
	
}

@property (retain) KCChefConnection *chefConnection;

@property (retain) KCRegistrationsController* registrationsController;
@property (retain) KCSearchController* searchController;
@property (retain) KCNodeController* nodeController;
@property (retain) KCCookbooksController* cookbooksController;
@property (retain) KCNodesController* nodesController;
@property (retain) KCCookbookController* cookbookController;
@property (retain) KCStatusController* statusController;

@property (retain) KCViewController	*currentViewController;

@property (retain) IBOutlet NSTreeController *sourceController;
@property (retain) IBOutlet NSMutableArray *sourceContents;
@property (retain) IBOutlet NSOutlineView *sourceView;

@property (retain) IBOutlet NSView *currentView;

- (void)setupViewControllers;
- (void)changeItemView;

@end
