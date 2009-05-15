//
//  KCNodeController.m
//  Casserole
//
//  Created by Olivier Gutknecht on 09/05/09.
//  Copyright 2009 Fotonauts. All rights reserved.
//

#import "KCNodeController.h"
#import "KCAbstractNode.h"


@implementation KCNodeController
@synthesize recipes;
@synthesize name;
@synthesize tags;
@synthesize attributes;
@synthesize node;

-(void)awakeFromNib
{
	[self setName:@"test1.ftnx.net"];
	[self setRecipes:@"vim,emacs,passenger,couchdb"];
	[self setTags:@"cloud1,production,load-balanced"];
	
#if 0
	NSMutableArray* a = [NSMutableArray array];
	KCAbstractNode *n;
	KCAbstractNode *child;
	n= [[KCAbstractNode alloc] init];
	[n setNodeTitle:@"platform"];
	[n setNodeValue:@"ubuntu"];
	[n setIsLeaf:true];
	[a addObject:n];

	n = [[KCAbstractNode alloc] init];
	[n setNodeTitle:@"activemq"];
	[n setIsLeaf:false];

	child = [[KCAbstractNode alloc] init];
	[child setNodeTitle:@"gid"];
	[child setNodeValue:@"992"];
	[child setIsLeaf:true];
	[n addObject:child];
	
	child = [[KCAbstractNode alloc] init];
	[child setNodeTitle:@"version"];
	[child setNodeValue:@"5.1.0"];
	[child setIsLeaf:true];
	[n addObject:child];
	
	child = [[KCAbstractNode alloc] init];
	[child setNodeTitle:@"mirror_url"];
	[child setNodeValue:@"http://apache.osuosl.org/activemq"];
	[child setIsLeaf:true];
	[n addObject:child];
	
	[a addObject:n];

	
	n = [[KCAbstractNode alloc] init];
	[n setNodeTitle:@"kernel"];
	[n setIsLeaf:false];
	
	child = [[KCAbstractNode alloc] init];
	[child setNodeTitle:@"machine"];
	[child setNodeValue:@"i686"];
	[child setIsLeaf:true];
	[n addObject:child];
	
	child = [[KCAbstractNode alloc] init];
	[child setNodeTitle:@"name"];
	[child setNodeValue:@"Linux"];
	[child setIsLeaf:true];
	[n addObject:child];
	
	child = [[KCAbstractNode alloc] init];
	[child setNodeTitle:@"version"];
	[child setNodeValue:@"#42-Ubuntu SMP Fri Apr 17 02:48:10 UTC 2009"];
	[child setIsLeaf:true];
	[n addObject:child];

	child = [[KCAbstractNode alloc] init];
	[child setNodeTitle:@"release"];
	[child setNodeValue:@"2.6.28-11-server"];
	[child setIsLeaf:true];
	[n addObject:child];
	
	[a addObject:n];
	[self setAttributes:a];
#endif

	
}

/* Required methods
 */

- (id)outlineView:(NSOutlineView *)outlineView child:(NSInteger)index ofItem:(id)item
{
	// NSLog(@"outlineView:child:ofItem:%d %@",index,item);
	if (item==nil)
	{
		NSDictionary* item = [self.node.attributes objectForKey:@"attributes"];
		NSArray* a = [[item allKeys] sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
		NSString* key = [a objectAtIndex:index];
		NSArray* couple = [NSArray arrayWithObjects:key, [item objectForKey:key], nil];
		CFRetain(couple);
		return couple;
	}
	else if ([item isKindOfClass:[NSArray class]]) 
    {
		NSDictionary* value = [item objectAtIndex:1];

		NSArray* a = [value allKeys];
		NSString* key = [a objectAtIndex:index];
		NSArray* couple = [NSArray arrayWithObjects:key, [value objectForKey:key], nil];
		CFRetain(couple);
		return couple;
    }
    else if ([item isKindOfClass:[NSDictionary class]]) 
    {
        return [item objectForKey:[[item allKeys] objectAtIndex:index]];
    }
	return nil;
}

- (BOOL)outlineView:(NSOutlineView *)outlineView isItemExpandable:(id)item
{
	// NSLog(@"outlineView:isItemExpandable:%@",[item class]);
	if (![item isKindOfClass:[NSArray class]])
		return false;
	if ([[item objectAtIndex:1] isKindOfClass:[NSDictionary class]])
    {
        if ([[item objectAtIndex:1] count] > 0)
            return true;
    }
    return false;
}

- (NSInteger)outlineView:(NSOutlineView *)outlineView numberOfChildrenOfItem:(id)item
{
	// NSLog(@"outlineView:numberOfChildrenOfItem:%@",[item class]);
	if (item==nil)
		return [[self.node.attributes objectForKey:@"attributes"] count];
	else if (![item isKindOfClass:[NSArray class]]) 
		return 0;
		
	// NSLog(@"    outlineView:numberOfChildrenOfItem:%d",[item count]);
	if ([[item objectAtIndex:1] isKindOfClass:[NSDictionary class]])
		return [[item objectAtIndex:1] count];
	
	return 0;
	
}

- (id)outlineView:(NSOutlineView *)outlineView objectValueForTableColumn:(NSTableColumn *)tableColumn byItem:(id)item
{
	// NSLog(@"outlineView:objectValueForTableColumn:%@ byItem %@",[tableColumn identifier],[item class]);
	if ([item isKindOfClass:[NSArray class]]) 
		// NSLog(@"                             %d",[item count]);
		
	if (item==nil)
		return @"";
	if ([item isKindOfClass:[NSString class]]) 
	{
		return item;
	} 
	else if ([item isKindOfClass:[NSDictionary class]]) 
	{
		if ([[tableColumn identifier] isEqualToString:@"key"])
			return [item objectForKey:@"key"];
		else
			return [item objectForKey:@"value"];
	}
	else if ([item isKindOfClass:[NSArray class]]) 
	{
		if ([item count]<2)
			return [item description];
		if ([[tableColumn identifier] isEqualToString:@"key"])
			return [item objectAtIndex:0];
		else {
			if ([[item objectAtIndex:1] isKindOfClass:[NSDictionary class]]) 
				return @"";
				//				return [NSString stringWithFormat:@"%d items",[[item objectAtIndex:1] count]];
			if ([[item objectAtIndex:1] isKindOfClass:[NSArray class]]) 
				return [[item objectAtIndex:1] componentsJoinedByString:@","];
			else
				return [item objectAtIndex:1];
		}
	}
	else	
		return [item description];
}

-(NSString*)iconName
{
	return [node iconName];
}


@end
