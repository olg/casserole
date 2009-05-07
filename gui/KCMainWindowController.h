//
//  KCMainWindowController.h
//  Cuisine
//
//  Created by Olivier Gutknecht on 06/05/09.
//  Copyright 2009 Fotonauts. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface KCMainWindowController : NSWindowController {
	IBOutlet NSTreeController	*sourceController;
	NSMutableArray				*sourceContents;
	NSView						*currentView;
	IBOutlet NSOutlineView		*sourceView;
}

@property (nonatomic, retain) IBOutlet NSTreeController *sourceController;
@property (nonatomic, retain) IBOutlet NSMutableArray *sourceContents;
@property (nonatomic, retain) IBOutlet NSView *currentView;
@property (nonatomic, retain) IBOutlet NSOutlineView *sourceView;

@end
