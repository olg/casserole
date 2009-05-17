//
//  KCAbstractNode.h
//  Casserole
//
//  Created by Olivier Gutknecht on 07/05/09.
//  Copyright 2009 Fotonauts. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class KCChefConnection;
@class KCViewController;

@interface KCAbstractNode : NSObject {
	KCAbstractNode *parent;
	NSString *nodeTitle;
	NSString *nodeValue;
	NSMutableArray *children;
	BOOL isLeaf;
}  

@property(copy) NSString *nodeValue;
@property(copy) NSString *nodeTitle;
@property(copy) NSMutableArray *children;
@property(assign) KCAbstractNode *parent;
@property(assign) BOOL isLeaf;

-(void)addObject:(KCAbstractNode*)o;
-(void)addSortedObject:(KCAbstractNode*)object;

-(void)refresh:(id)sender;

-(NSString*)iconName;
-(NSIndexPath*)path;
@end

@interface KCAttributeNode : KCAbstractNode {
	NSString *nodeType;
}
@property(assign) NSString *nodeType;
@end

@interface KCChefNode : KCAbstractNode {
	KCChefConnection *connection;
	NSString *nodeType;
}

@property(assign) KCChefConnection *connection;
@property(assign) NSString *nodeType;

@end

@interface KCNodesProxy : KCChefNode
@end

@interface KCCookbooksProxy : KCChefNode
@end

@interface KCViewControllerNode : KCChefNode {
	KCViewController *viewController;
}  

@property(assign) KCViewController *viewController;

@end
