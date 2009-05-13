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
	NSString* query;
	NSArray* attributes;
	NSArray* results;
}

@property (retain) NSArray* results;

- (IBAction)search:(id)sender;

@end
