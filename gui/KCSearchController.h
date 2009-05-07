//
//  KCSearchController.h
//  Cuisine
//
//  Created by Olivier Gutknecht on 5/7/09.
//  Copyright 2009 Fotonauts. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface KCSearchController : NSViewController {
	NSString* query;
	NSString* attributes;
	NSMutableArray* results;
}

- (IBAction)search:(id)sender;

@end
