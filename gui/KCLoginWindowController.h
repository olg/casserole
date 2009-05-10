//
//  KCLoginWindowController.h
//  Cuisine
//
//  Created by Olivier Gutknecht on 06/05/09.
//  Copyright 2009 Fotonauts. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface KCLoginWindowController : NSWindowController {
	IBOutlet NSButton *defaultButton;
	IBOutlet NSTextField *urlField;
}

@property (retain) IBOutlet NSButton *defaultButton;

- (IBAction)connect:(id)sender;

@end
