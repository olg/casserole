//
//  KCCookbookController.h
//  Casserole
//
//  Created by Olivier Gutknecht on 08/05/09.
//  Copyright 2009 Fotonauts. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "KCViewController.h"

@interface KCCookbookController : KCViewController {
//	NSMutableArray				*cookbookContents;
//	NSString					*cookbookName;
	NSString					*sourceText;
	IBOutlet NSBrowser			*cookbookBrowser;
	IBOutlet NSTreeController	*cookbookStructureController;
	NSTextView					*textView;
	KCCookbook					*cookbook;
	NSMutableArray				*selections;
	NSOperation					*currentOperation;
}

// @property (retain) IBOutlet NSMutableArray *cookbookContents;
@property (retain) IBOutlet NSString *sourceText;
@property (retain) IBOutlet NSTextView *textView;
@property (retain) KCCookbook* cookbook;

@end
