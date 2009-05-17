//
//  KCNode.h
//  Casserole
//
//  Created by Olivier Gutknecht on 5/9/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "KCAbstractNode.h"

@interface KCNode : KCChefNode {
	NSDictionary* attributes;
	NSMutableArray* chefAttributes;
}

@property (retain) NSDictionary* attributes;
@property (retain) NSMutableArray* chefAttributes;

-(void)refresh:(id)sender;
-(NSMutableArray*)nodeTreeFromDictionary:(NSDictionary*)d;
-(NSMutableArray*)nodeTreeFromArray:(NSArray*)array;

@end
