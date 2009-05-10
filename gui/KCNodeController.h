//
//  KCNodeController.h
//  Cuisine
//
//  Created by Olivier Gutknecht on 09/05/09.
//  Copyright 2009 Fotonauts. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "KCViewController.h"
#import "KCNode.h"

@interface KCNodeController : KCViewController {
	NSString* recipes;
	NSString* tags;
	NSMutableArray* attributes;
	NSString* name;
	KCNode* node;
}

@property (retain) KCNode* node;
@property (retain) IBOutlet NSString* recipes;
@property (retain) IBOutlet NSString* name;
@property (retain) IBOutlet NSString* tags;
@property (retain) IBOutlet NSMutableArray* attributes;

@end
