//
//  KCNodesController.h
//  Cuisine
//
//  Created by Olivier Gutknecht on 5/7/09.
//  Copyright 2009 Fotonauts. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface KCNodesController : NSViewController {
	NSMutableArray* nodes;
}

@property (nonatomic, retain) IBOutlet NSMutableArray* nodes;

@end
