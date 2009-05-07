//
//  KCNode.m
//  Cuisine
//
//  Created by Olivier Gutknecht on 07/05/09.
//  Copyright 2009 Fotonauts. All rights reserved.
//

#import "KCNode.h"


@implementation KCNode

@synthesize nodeTitle = _nodeTitle;  
@synthesize parent = _parent;  
@dynamic isLeaf;  
@dynamic children;  

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
