//
//  KCCookbooksController.h
//  Cuisine
//
//  Created by Olivier Gutknecht on 09/05/09.
//  Copyright 2009 Fotonauts. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "KCViewController.h"


@interface KCCookbooksController : KCViewController {
	NSMutableArray* cookbooks;
}

@property (retain) NSMutableArray* cookbooks;

@end