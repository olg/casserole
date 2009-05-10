//
//  KCAbstractNode.m
//  Cuisine
//
//  Created by Olivier Gutknecht on 07/05/09.
//  Copyright 2009 Fotonauts. All rights reserved.
//

#import "KCAbstractNode.h"
#import "KCChefConnection.h"


@implementation KCAbstractNode

@synthesize nodeValue = _nodeValue;  
@synthesize nodeTitle = _nodeTitle;  
@synthesize parent = _parent;  
@synthesize connection = _connection;
@dynamic isLeaf;  
@dynamic children;  

- (void)refresh:(id)sender
{
}

- (NSString*)description  
{
	return _nodeTitle;
}

- (void)setIsLeaf:(BOOL)flag;  
{  
	_isLeaf = flag;  
	if (_isLeaf)  
		self.children = [NSMutableArray arrayWithObject:self];  
	else  
		self.children = [NSMutableArray array];  
}  
- (BOOL)isLeaf;  
{  
	return _isLeaf;  
}  

- (NSMutableArray *)children;  
{  
	return _children;  
}  

- (void)setChildren:(NSMutableArray *)newChildren;  
{  
	if (_children == newChildren)  
		return;  
	[_children release];  
	_children = [newChildren mutableCopy];  
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




@implementation KCNodesProxy

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
	return [_connection.nodes objectAtIndex:index];  
}  

- (void)replaceObjectInChildrenAtIndex:(NSUInteger)index withObject:(id)object;  
{  
	return;  
}  

@end


