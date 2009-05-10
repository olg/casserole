//
//  KCNode.h
//  Cuisine
//
//  Created by Olivier Gutknecht on 5/9/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "KCAbstractNode.h"

@interface KCNode : KCAbstractNode {
	NSDictionary* attributes;
}

@property (retain) NSDictionary* attributes;

-(void)refresh:(id)sender;

@end
