//
//  KCCookbooksController.h
//  Cuisine
//
//  Created by Olivier Gutknecht on 09/05/09.
//  Copyright 2009 Fotonauts. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface KCCookbooksController : NSViewController {
	NSMutableArray* cookbooks;
}

@property (nonatomic, retain) NSMutableArray* cookbooks;

@end
