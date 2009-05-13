//
//  KCSearchController.h
//  Casserole
//
//  Created by Olivier Gutknecht on 5/7/09.
//  Copyright 2009 Fotonauts. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "KCViewController.h"


@interface KCSearchController : KCViewController {
	NSArray* attributes;
	NSArray* results;
	NSArray* nodes;
	IBOutlet NSTextField* progressSearchLabel;
	IBOutlet NSPredicateEditor*	predicateEditor;
}

@property (retain) NSArray* results;
@property (retain) NSArray* nodes;

- (IBAction)predicateEditorChanged:(id)sender;
- (void)search:(id)sender;

@end
