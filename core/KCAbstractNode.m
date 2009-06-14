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

- (NSIndexPath*)path
{
	if (parent!=nil)
	{
		NSIndexPath* parentPath = [parent path];
		if (parentPath==nil)
			return [parentPath indexPathByAddingIndex:[[parent children] indexOfObject:self]];
		else
			return [NSIndexPath indexPathWithIndex:[[parent children] indexOfObject:self]];
	}
	else
		return nil;
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


- (void)insertObject:(KCAbstractNode*)object inChildrenAtIndex:(NSUInteger)index;
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

- (void)replaceObjectInChildrenAtIndex:(NSUInteger)index withObject:(KCAbstractNode*)object;
{
	if (self.isLeaf)
		return;
	[self.children replaceObjectAtIndex:index withObject:object];
}


- (void)addObject:(KCAbstractNode*)object
{
	[self insertObject:object inChildrenAtIndex:[self countOfChildren]];
}

- (void)addSortedObject:(KCAbstractNode*)object
{
	if (self.isLeaf)
		return;
	[self addObject:object];
	[self willChangeValueForKey:@"children"];
	[self.children sortUsingDescriptors:[NSArray arrayWithObject:[[[NSSortDescriptor alloc] initWithKey:@"nodeTitle" ascending:YES] autorelease]]];
	[self didChangeValueForKey:@"children"];
}



@end


@implementation KCChefNode
@synthesize connection;
@synthesize nodeType;
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

@implementation KCCookbooksProxy

-(NSString*)iconName
{
	return NSImageNameMultipleDocuments;
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
	return self.connection.cookbooks;
}

- (void)setChildren:(NSMutableArray *)newChildren;
{
	return;
}

- (NSUInteger)countOfChildren;
{
	return [self.connection.cookbooks count];
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
	return [connection.cookbooks objectAtIndex:index];
}

- (void)replaceObjectInChildrenAtIndex:(NSUInteger)index withObject:(id)object;
{
	return;
}

@end


