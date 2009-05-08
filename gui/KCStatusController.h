//
//  KCStatusController.h
//  Cuisine
//
//  Created by Olivier Gutknecht on 08/05/09.
//  Copyright 2009 Fotonauts. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface KCStatusController : NSViewController {
	NSMutableArray* nodes;
	NSString* serverURL;
	NSString* cookbooks;
}

@property (nonatomic, retain) NSMutableArray *nodes;
@property (nonatomic, retain) NSString *serverURL;
@property (nonatomic, retain) NSString *cookbooks;

@end
