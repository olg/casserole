//
//  KCStatusController.h
//  Casserole
//
//  Created by Olivier Gutknecht on 08/05/09.
//  Copyright 2009 Fotonauts. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "KCViewController.h"

@interface KCStatusController : KCViewController {
	NSMutableArray* nodes;
	NSString* serverURL;
	NSString* cookbooks;
}

@property (retain) NSMutableArray *nodes;
@property (retain) NSString *serverURL;
@property (retain) NSString *cookbooks;

@end
