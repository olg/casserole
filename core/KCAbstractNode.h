//
//  KCAbstractNode.h
//  Cuisine
//
//  Created by Olivier Gutknecht on 07/05/09.
//  Copyright 2009 Fotonauts. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class KCChefConnection;

@interface KCAbstractNode : NSObject {
	KCAbstractNode *_parent;  
	NSString *_nodeTitle;  
	NSString *_nodeValue;  
	NSMutableArray *_children;  
	KCChefConnection *_connection;  
	BOOL _isLeaf;  
}  

@property(copy) NSString *nodeValue;  
@property(copy) NSString *nodeTitle;  
@property(copy) NSMutableArray *children;  
@property(assign) KCAbstractNode *parent;  
@property(assign) BOOL isLeaf;  
@property(assign) KCChefConnection *connection;  

-(void)addObject:(id)o;

-(void)refresh:(id)sender;

@end

@interface KCNodesProxy : KCAbstractNode
@end
