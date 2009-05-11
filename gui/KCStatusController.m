//
//  KCStatusController.m
//  Casserole
//
//  Created by Olivier Gutknecht on 08/05/09.
//  Copyright 2009 Fotonauts. All rights reserved.
//

#import "KCStatusController.h"


@implementation KCStatusController
@synthesize nodes;
@synthesize cookbooks;
@synthesize serverURL;

-(void)awakeFromNib
{
	[self setNodes:[NSArray arrayWithObjects:@"1", @"1", @"1", @"1", nil]];
	[self setServerURL:@"https://chef.ftnx.next"];
	[self setCookbooks:@"2 (apache2, couchdb)"];
}


-(void)refresh:(id)sender
{
			}

@end
