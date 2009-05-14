//
//  KCMainWindowController.h
//  Casserole
//
//  Created by Olivier Gutknecht on 06/05/09.
//  Copyright 2009 Fotonauts. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "KCViewController.h"

@interface KCMainWindowController : NSWindowController {
	NSString					*serverURL;
	IBOutlet NSTreeController	*sourceController;
	NSMutableArray				*sourceContents;
	IBOutlet NSOutlineView		*sourceView;
	NSView						*currentView;
	IBOutlet KCViewController	*currentViewController;
	KCChefConnection			*chefConnection;
	IBOutlet NSSearchField		*searchField;
}

@property (retain) KCViewController	*currentViewController;
@property (retain) KCChefConnection *chefConnection;
@property (retain) IBOutlet NSTreeController *sourceController;
@property (retain) IBOutlet NSMutableArray *sourceContents;
@property (retain) IBOutlet NSView *currentView;
@property (retain) IBOutlet NSOutlineView *sourceView;

@end
