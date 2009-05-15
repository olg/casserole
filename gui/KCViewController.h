//
//  KCViewController.h
//  Casserole
//
//  Created by Olivier Gutknecht on 09/05/09.
//  Copyright 2009 Fotonauts. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "KCChefConnection.h";

@class KCMainWindowController;

@interface KCViewController : NSViewController {
	KCChefConnection *chefConnection;
	KCMainWindowController *windowController;
	NSPredicate* searchPredicate;
	bool canSearch;
}

@property (retain) KCChefConnection *chefConnection;
@property (retain) NSPredicate* searchPredicate;
@property (retain) KCMainWindowController *windowController;
@property bool canSearch;

-(NSString*)iconName;

@end
