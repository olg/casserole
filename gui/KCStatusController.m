//
//  KCStatusController.m
//  Cuisine
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
	[self setServerURL:@"https://chef.ftnx.net"];
	[self setCookbooks:@"2 (apache2, couchdb)"];
}

@end
