//
//  KCApplicationDelegate.h
//  Cuisine
//
//  Created by Olivier Gutknecht on 06/05/09.
//  Copyright 2009 Fotonauts. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface KCApplicationDelegate : NSObject {
	NSOperationQueue* queue;
}

@property (retain) NSOperationQueue* queue;


- (void)applicationDidFinishLaunching:(NSNotification *)aNotification;


@end
