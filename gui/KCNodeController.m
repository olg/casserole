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
@synthesize name;
@synthesize tags;
@synthesize attributes;
@synthesize node;

-(NSString*)iconName
{
	return [node iconName];
}


@end
