//
//  KCNodesController.h
//  Casserole
//
//  Created by Olivier Gutknecht on 5/7/09.
//  Copyright 2009 Fotonauts. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "KCViewController.h"


@interface KCNodesController : KCViewController {
	NSMutableArray* nodes;
}

@property (retain) IBOutlet NSMutableArray* nodes;

@end
