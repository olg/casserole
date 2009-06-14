//
//  KCSearchController.m
//  Casserole
//
//  Created by Olivier Gutknecht on 5/7/09.
//  Copyright 2009 Fotonauts. All rights reserved.
//

#import "KCSearchController.h"
#import "KCNetworkOperation.h"
#import "KCApplicationDelegate.h"

@implementation KCSearchController
@synthesize results;
@synthesize nodes;

-(void)awakeFromNib 
{
	self.canSearch = true;
	[predicateEditor addRow:self];
	// put the focus in the first text field
    id displayValue = [[predicateEditor displayValuesForRow:1] lastObject];
		[[[self view] window] makeFirstResponder:displayValue];
}

- (void)observeValueForKeyPath:(NSString *)keyPath
					  ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{
    if ([keyPath isEqual:@"isFinished"]) {
		KCNetworkOperation* op = (KCNetworkOperation*)object;
		if (op.error!=nil) {
			NSAlert* a = [NSAlert alertWithError:op.error];
			[a runModal];
		}
		else {
			[self setNodes:[NSArray array]];
			[self setResults:[NSArray array]];
			if ([op.result isKindOfClass:[NSArray class]])
			{
				NSArray* a = (NSArray*)op.result;
				NSMutableArray* r = [NSMutableArray array];
				NSMutableArray* n = [NSMutableArray array];
				for (NSDictionary* d in a) {
					NSString* nodeID =  [d objectForKey:@"id"];
					[n addObject:nodeID];
					for (id key in d) {
						if ((![key isEqualToString:@"id"])&&(![key isEqualToString:@"index_name"]))
							[r addObject:[NSDictionary dictionaryWithObjectsAndKeys:nodeID, @"id",  [d objectForKey:key], @"value", key, @"key", nil]];
					}
				}
				[self setNodes:n];
				[self setResults:r];
				[progressSearchLabel setStringValue: [NSString stringWithFormat:@"%ld attributes found in %ld nodes", [results count],[nodes count]]];
			}
		}
    }
}

- (void)search:(id)sender
{
	NSPredicate* predicate = [predicateEditor objectValue];
	if (![predicate isKindOfClass:[NSCompoundPredicate class]])
		return;
	NSCompoundPredicate* topLevelPredicate = (NSCompoundPredicate*)predicate;
    if (topLevelPredicate == nil)
		return;
	
	NSString* join;
	[self setNodes:[NSArray array]];
	[self setResults:[NSArray array]];
		
	switch ([topLevelPredicate compoundPredicateType])
	{
		case NSOrPredicateType:
			join = @" OR ";
			break;
		case NSNotPredicateType:
			join = @" NOT ";
			break;
		case NSAndPredicateType:
		default:
			join = @" AND ";
			break;
	}
	NSMutableArray* subexp = [NSMutableArray array];
	NSArray* subpredicates = [topLevelPredicate subpredicates];
	for (NSComparisonPredicate* predicate in subpredicates)
	{
		NSString* left = [[[predicate leftExpression] constantValue] description];
		NSString* right = [[[predicate rightExpression] constantValue] description];
		NSString* l = [[left componentsSeparatedByString:@"\""] objectAtIndex:0];
		NSString* r = [[right componentsSeparatedByString:@"\""] objectAtIndex:0];
		if ([l isEqualToString:@""])
			l = @"*";
		if ([r isEqualToString:@""])
			r = @"*";
		[subexp addObject:[NSString stringWithFormat:@"%@:\"%@\"",l,r]]; 
	}
	
	NSString* filteredQuery = [subexp componentsJoinedByString:join];
	NSString* a;
	NSString* q;
	if (filteredQuery==nil)
		q = @"";
	else
		q = [filteredQuery stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	if (attributes==nil)
		a = @"";
	else
		a = [attributes componentsJoinedByString:@","];
	
	NSOperationQueue* queue = [(KCApplicationDelegate*)[NSApp delegate] queue];
	KCNetworkOperation* op = [[[KCNetworkOperation alloc] init] autorelease];
	op.url =  [NSURL URLWithString:[NSString stringWithFormat:@"%@/search/node.json?q=%@&a=%@", self.chefConnection.serverURL, q, a]]; // This is baroque, let's fix it
	op.type = @"search.node";
	op.summary = @"Searching index";
	[op addObserver:self forKeyPath:@"isFinished" options:0 context:nil]; 
	[queue addOperation:op];
}

- (IBAction)predicateEditorChanged:(id)sender;
{
	// check NSApp currentEvent for the return key
    NSEvent* event = [NSApp currentEvent];
    if ([event type] == NSKeyDown)
	{
		NSString* characters = [event characters];
		if ([characters length] > 0 && (([characters characterAtIndex:0] == 0x0D)||([characters characterAtIndex:0] == 0x03)))
			[self search:self];
    }
    
    // if the user deleted the first row, then add it again - no sense leaving the user with no rows
    if ([predicateEditor numberOfRows] == 0)
		[predicateEditor addRow:self];
}

-(NSString*)iconName
{
	return @"Spotlight";
}


@end
