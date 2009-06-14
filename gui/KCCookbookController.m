//
//  KCCookbookController.m
//  Casserole
//
//  Created by Olivier Gutknecht on 08/05/09.
//  Copyright 2009 Fotonauts. All rights reserved.
//

#import "KCCookbookController.h"
#import "KCAbstractNode.h"
#import "KCApplicationDelegate.h"
#import "KCNetworkOperation.h"

@implementation KCCookbookController
@synthesize sourceText;
@synthesize textView;
@synthesize cookbook;

- (void)awakeFromNib
{
	[cookbookBrowser setTarget:self];
    [cookbookBrowser setAction:@selector(browserSingleClick:)];
    [cookbookBrowser setDoubleAction:@selector(browserDoubleClick:)];
	[self setSourceText:@""];
}

-(NSString*)iconName
{
	return @"NSMysteryDocument";
}

- (IBAction)doubleSingleClick:(NSBrowser*)browser {
}

- (IBAction)browserSingleClick:(NSBrowser*)browser {
	// Strange, the selection binding does not seem to work
	[cookbookStructureController setSelectionIndexPaths:selections];
    NSArray *objects = [cookbookStructureController selectedObjects];
    if ([objects count] == 1) {
		KCChefNode* node = [objects objectAtIndex:0];
        // Find the last selected cell and show its information
		NSString* title = [node nodeTitle];
		NSString* category = [node nodeType];
		NSString* value = [node nodeValue];
		NSString* path = nil;

		if ((value!=nil) && ([value length]!=0)) {
			[self setSourceText:value];
			return;
		}
		else
			[self setSourceText:@""]; // so we cleanup during navigation

		if ([category isEqualToString:@"library"])
			path = [NSString stringWithFormat:@"/cookbooks/%@/libraries?id=%@", [cookbook nodeTitle], title];
		if ([category isEqualToString:@"attribute"])
			path = [NSString stringWithFormat:@"/cookbooks/%@/attributes?id=%@", [cookbook nodeTitle], title];
		if ([category isEqualToString:@"definition"])
			path = [NSString stringWithFormat:@"/cookbooks/%@/definitions?id=%@", [cookbook nodeTitle], title];
		if ([category isEqualToString:@"recipe"])
			path = [NSString stringWithFormat:@"/cookbooks/%@/recipes?id=%@", [cookbook nodeTitle], title];

		if (path != nil) {
			if (currentOperation!=nil) {
				[currentOperation cancel];
				currentOperation = nil;
			}
			NSOperationQueue* queue = [(KCApplicationDelegate*)[NSApp delegate] queue];
			KCNetworkStringOperation* op = [[[KCNetworkStringOperation alloc] init] autorelease];	
			op.url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", self.chefConnection.serverURL, path]];
			op.type = [NSString stringWithFormat:@"refresh.%@",category];
			op.summary = [NSString stringWithFormat:@"Getting %@ file %@", category, title];
			op.userInfo = node;
			[op addObserver:self forKeyPath:@"isFinished" options:0 context:nil];
			[queue addOperation:op];
		}
    }
}


- (void)observeValueForKeyPath:(NSString *)keyPath
					  ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{
    if ([keyPath isEqual:@"isFinished"]) {
		KCNetworkStringOperation* op = (KCNetworkStringOperation*)object;
		if (op.error!=nil) {
			NSAlert* a = [NSAlert alertWithError:op.error];
			[a runModal];
		}
		else {
			if (![op isCancelled])
				[self setSourceText:[op.result description]];
			if ((op.userInfo!=nil)&&([op.userInfo isKindOfClass:[KCChefNode class]]))
			{
				[(KCChefNode*)(op.userInfo) setNodeValue:[op.result description]];
			}
		}
    }
}


@end
