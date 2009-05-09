//
//  KCNodeController.h
//  Cuisine
//
//  Created by Olivier Gutknecht on 09/05/09.
//  Copyright 2009 Fotonauts. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface KCNodeController : NSViewController {
	NSString* recipes;
	NSString* tags;
	NSMutableArray* attributes;
	NSString* name;
}

@property (nonatomic, retain) IBOutlet NSString* recipes;
@property (nonatomic, retain) IBOutlet NSString* name;
@property (nonatomic, retain) IBOutlet NSString* tags;
@property (nonatomic, retain) IBOutlet NSMutableArray* attributes;

@end
