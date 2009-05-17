//
//  KCAbstractNode.m
//  Casserole
//
//  Created by Olivier Gutknecht on 07/05/09.
//  Copyright 2009 Fotonauts. All rights reserved.
//

#import "KCAbstractNode.h"
#import "KCChefConnection.h"
#import "KCViewController.h"

@implementation KCAttributeNode
@synthesize nodeType;
@end

@implementation KCAbstractNode

@synthesize nodeValue;
@synthesize nodeTitle;
@synthesize parent;
@dynamic isLeaf;
@dynamic children;

- (NSString*)iconName
{
	return nil;
}

- (void)refresh:(id)sender
{
}

- (NSString*)description  
{
	return nodeTitle;
}

- (void)setIsLeaf:(BOOL)flag;
{  
	isLeaf = flag;
	if (isLeaf)
		self.children = [NSMutableArray arrayWithObject:self];
	else  
		self.children = [NSMutableArray array];
}  
- (BOOL)isLeaf;
{  
	return isLeaf;
}  

- (NSMutableArray *)children;
{  
	return children;
}  

- (void)setChildren:(NSMutableArray *)newChildren;
{  
	if (children == newChildren)  
		return;
	[children release];
	children = [newChildren mutableCopy];
}  

- (NSUInteger)countOfChildren;
{  
	if (self.isLeaf)  
		return 0;
	return [self.children count];
}  

- (void)addObject:(id)object
{  
	if (self.isLeaf)  
		return;
	[self.children insertObject:object atIndex:[self countOfChildren]];
}  

- (void)insertObject:(id)object inChildrenAtIndex:(NSUInteger)index;
{  
	if (self.isLeaf)  
		return;
	[self.children insertObject:object atIndex:index];
}  

- (void)removeObjectFromChildrenAtIndex:(NSUInteger)index;
{  
	if (self.isLeaf)  
		return;
	[self.children removeObjectAtIndex:index];
}  

- (id)objectInChildrenAtIndex:(NSUInteger)index;
{  
	if (self.isLeaf)  
		return nil;
	return [self.children objectAtIndex:index];
}  

- (void)replaceObjectInChildrenAtIndex:(NSUInteger)index withObject:(id)object;
{  
	if (self.isLeaf)  
		return;
	[self.children replaceObjectAtIndex:index withObject:object];
}  

@end


@implementation KCChefNode
@synthesize connection;
@end

@implementation KCViewControllerNode
@synthesize viewController;

-(NSString*)iconName
{
	return [viewController iconName];
}

-(NSString*)nodeTitle
{
	return [viewController title];
}

-(void)setNodeTitle:(NSString*)s
{
	return [viewController setTitle:s];
}

@end

@implementation KCNodesProxy

-(NSString*)iconName
{
	return NSImageNameNetwork;
}

- (void)setIsLeaf:(BOOL)flag;
{  
	return;
}  
- (BOOL)isLeaf;
{  
	return NO;
} 

- (NSMutableArray *)children;
{  
	return self.connection.nodes;
}  

- (void)setChildren:(NSMutableArray *)newChildren;
{  
	return;
}  

- (NSUInteger)countOfChildren;
{  
	return [self.connection.nodes count];
}  

- (void)addObject:(id)object
{  
	return;
}  

- (void)insertObject:(id)object inChildrenAtIndex:(NSUInteger)index;
{  
	return;
}  

- (void)removeObjectFromChildrenAtIndex:(NSUInteger)index;
{  
	return;
}  

- (id)objectInChildrenAtIndex:(NSUInteger)index;
{  
	return [connection.nodes objectAtIndex:index];
}  

- (void)replaceObjectInChildrenAtIndex:(NSUInteger)index withObject:(id)object;
{  
	return;
}  

@end


