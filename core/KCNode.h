//
//  KCNode.h
//  Cuisine
//
//  Created by Olivier Gutknecht on 07/05/09.
//  Copyright 2009 Fotonauts. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface KCNode : NSObject {
	KCNode *_parent;  
	NSString *_nodeTitle;  
	NSString *_nodeValue;  
	NSMutableArray *_children;  
	BOOL _isLeaf;  
}  

@property(copy) NSString *nodeValue;  
@property(copy) NSString *nodeTitle;  
@property(copy) NSMutableArray *children;  
@property(assign) KCNode *parent;  
@property(assign) BOOL isLeaf;  

-(void)addObject:(id)o;

@end
