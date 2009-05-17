//
//  KCRegistration.h
//  Casserole
//
//  Created by Olivier Gutknecht on 09/05/09.
//  Copyright 2009 Fotonauts. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "KCAbstractNode.h"


@interface KCRegistration : KCChefNode {
	NSDictionary* content;
}

@property (retain) NSDictionary* content;

@end
