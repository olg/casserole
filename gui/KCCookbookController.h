//
//  KCCookbookController.h
//  Cuisine
//
//  Created by Olivier Gutknecht on 08/05/09.
//  Copyright 2009 Fotonauts. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface KCCookbookController : NSViewController {
	NSMutableArray				*cookbookContents;
	NSString					*cookbookName;
	NSString					*sourceText;
	IBOutlet NSBrowser			*cookbookStructure;
	NSTextView					*textView;
}

@property (nonatomic, retain) IBOutlet NSMutableArray *cookbookContents;
@property (nonatomic, retain) IBOutlet NSTextView *textView;

@end
