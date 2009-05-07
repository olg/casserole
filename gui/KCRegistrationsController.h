//
//  KCRegistrationsController.h
//  Cuisine
//
//  Created by Olivier Gutknecht on 5/7/09.
//  Copyright 2009 Fotonauts. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface KCRegistrationsController : NSViewController {
	NSMutableArray* registrations;
}

@property (nonatomic, retain) IBOutlet NSMutableArray* registrations;

@end
