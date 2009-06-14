//
//  KCNodeController.m
//  Casserole
//
//  Created by Olivier Gutknecht on 09/05/09.
//  Copyright 2009 Fotonauts. All rights reserved.
//

#import "KCNodeController.h"
#import "KCAbstractNode.h"
#import <QuartzCore/QuartzCore.h>


@implementation KCNodeController
@synthesize recipes;
@synthesize resultsString;
@synthesize searchString;
@synthesize name;
@synthesize tags;
@synthesize attributes;
@synthesize node;
@synthesize matchingAttributes;

- (void)observeValueForKeyPath:(NSString *)keyPath
					  ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{
    if ([keyPath isEqual:@"searchPredicate"]) {
		// ok, don't laugh: I'm extracting the search string from something like:
		// attributes.name CONTAINS "ga" OR id CONTAINS "ga" OR key CONTAINS "ga" OR value CONTAINS "ga" OR attributes.ipaddress 
		// yes, this is over ugly, yes, this will change as soon I plug correct per-view predicate setup
		NSString* s = [[[searchPredicate description] componentsSeparatedByString:@"\""] objectAtIndex:1];
		if (![s isEqual:searchString]) {
			[self setSearchString:s];
			[outlineView reloadData];
			if (s==nil)
				[self setMatchingAttributes:[NSArray array]];
			else
				[self setMatchingAttributes:[node attributeNodesContaining:s]];

			if (s==nil)
				[self setResultsString:@""];
			else
				[self setResultsString:[NSString stringWithFormat:@"%d of ", [node countNodesContainingString:s]]];
		}
    }
}


-(void)awakeFromNib
{
	[self addObserver:self forKeyPath:@"searchPredicate" options:0 context:nil]; 
}

-(NSString*)iconName
{
	return [node iconName];
}

- (void)outlineView:(NSOutlineView *)view willDisplayCell:(id)cell forTableColumn:(NSTableColumn *)tableColumn item:(id)item
{
	NSString* text;
	KCAttributeNode* attribute = [item representedObject];
	if (searchString!=nil) {
		bool rendered = false;
		if ([[tableColumn identifier] isEqualToString:@"key"])
			text = [attribute nodeTitle]; 
		else
			text = [attribute nodeValue]; 
		if (text!=nil) {
			int location = 0;
			{
				NSFont *font = [NSFont boldSystemFontOfSize:11];
				NSDictionary *attrsDictionary =	[NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName, [NSColor yellowColor], NSBackgroundColorAttributeName, nil];
				NSMutableAttributedString* rendering = [[[NSMutableAttributedString alloc] initWithString:text] autorelease];
				while ((location < [text length])&&(location!=NSNotFound)) {
					NSRange range = [text rangeOfString:searchString options:NSDiacriticInsensitiveSearch range:NSMakeRange(location,([text length]-location))];
					if (range.location!=NSNotFound) {
						[rendering setAttributes:attrsDictionary range:range];
						[cell setAttributedStringValue:rendering];
						rendered = true;
						location = range.location+ 1;
					}
					else
						location = NSNotFound;
				}
			}
			if (!rendered && ([matchingAttributes containsObject:attribute]) && [[tableColumn identifier] isEqualToString:@"key"]) {
				NSFont *font = [NSFont boldSystemFontOfSize:11];
				NSDictionary *attrsDictionary =	[NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName, [NSColor colorWithCalibratedRed:1 green:1 blue:0.75 alpha:1], NSBackgroundColorAttributeName, nil];
				NSMutableAttributedString* rendering = [[[NSMutableAttributedString alloc] initWithString:text attributes:attrsDictionary] autorelease];
				[cell setAttributedStringValue:rendering];
			}
		}
	}
}

@end
