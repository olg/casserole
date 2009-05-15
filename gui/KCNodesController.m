//
//  KCNodesController.m
//  Casserole
//
//  Created by Olivier Gutknecht on 5/7/09.
//  Copyright 2009 Fotonauts. All rights reserved.
//

#import "KCNodesController.h"


@implementation KCNodesController
@synthesize nodes;


-(NSPredicate*)predicateTemplate
{
	return [NSPredicate predicateWithFormat:@"((attributes.name contains $value) or (attributes.ipaddress contains $value) or (attributes.platform contains $value) or (attributes.recipes contains $value))"];
}

-(NSString*)iconName
{
	return NSImageNameNetwork;
}

@end
