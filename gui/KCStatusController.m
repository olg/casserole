//
//  KCStatusController.m
//  Casserole
//
//  Created by Olivier Gutknecht on 08/05/09.
//  Copyright 2009 Fotonauts. All rights reserved.
//

#import "KCStatusController.h"


@implementation KCStatusController
@synthesize cookbooks;

-(void)awakeFromNib
{
	[self setCookbooks:@"2 (apache2, couchdb)"];
}


-(void)refresh:(id)sender
{
}

@end
