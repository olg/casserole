//
//  KCMainWindowController.h
//  Cuisine
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
	KCViewController			*currentViewController;
	KCChefConnection			*chefConnection;
}

@property (retain) KCChefConnection *chefConnection;
@property (retain) IBOutlet NSTreeController *sourceController;
@property (retain) IBOutlet NSMutableArray *sourceContents;
@property (retain) IBOutlet NSView *currentView;
@property (retain) IBOutlet NSOutlineView *sourceView;

@end
