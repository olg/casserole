//
//  KCCookbookController.m
//  Casserole
//
//  Created by Olivier Gutknecht on 08/05/09.
//  Copyright 2009 Fotonauts. All rights reserved.
//

#import "KCCookbookController.h"
#import "KCAbstractNode.h"

@implementation KCCookbookController
@synthesize sourceText;
@synthesize cookbookContents;
@synthesize textView;

- (void)awakeFromNib
{
	NSMutableArray* a = [NSMutableArray array];
	KCAbstractNode *node;
	KCAbstractNode *child;
	node = [[KCAbstractNode alloc] init];
	[node setNodeTitle:@"Attributes"];
	[node setIsLeaf:false];
	child = [[KCAbstractNode alloc] init];
	[child setNodeTitle:@"apache.rb"];
	[child setIsLeaf:true];
	[node addObject:child];	
	[a addObject:node];

	node = [[KCAbstractNode alloc] init];
	[node setNodeTitle:@"Definitions"];
	[node setIsLeaf:false];
	child = [[KCAbstractNode alloc] init];
	[child setNodeTitle:@"apache_module.rb"];
	[child setIsLeaf:true];
	[node addObject:child];	
	child = [[KCAbstractNode alloc] init];
	[child setNodeTitle:@"web_app.rb"];
	[child setIsLeaf:true];
	[node addObject:child];	
	child = [[KCAbstractNode alloc] init];
	[child setNodeTitle:@"apache_site.rb"];
	[child setIsLeaf:true];
	[node addObject:child];	
	[a addObject:node];

	
	node = [[KCAbstractNode alloc] init];
	[node setNodeTitle:@"Recipes"];
	[node setIsLeaf:false];
	child = [[KCAbstractNode alloc] init];
	[child setNodeTitle:@"default.rb"];
	[child setIsLeaf:true];
	[node addObject:child];	
	child = [[KCAbstractNode alloc] init];
	[child setNodeTitle:@"mod_dir.rb"];
	[child setIsLeaf:true];
	[node addObject:child];	
	child = [[KCAbstractNode alloc] init];
	[child setNodeTitle:@"mod_headers.rb"];
	[child setIsLeaf:true];
	[node addObject:child];	
	child = [[KCAbstractNode alloc] init];
	[child setNodeTitle:@"mod_proxy.rb"];
	[child setIsLeaf:true];
	[node addObject:child];	
	[a addObject:node];
	
	node = [[KCAbstractNode alloc] init];
	[node setNodeTitle:@"Templates"];
	[node setIsLeaf:false];
	child = [[KCAbstractNode alloc] init];
	[child setNodeTitle:@"apache2.conf.erb"];
	[child setIsLeaf:true];
	[node addObject:child];	
	child = [[KCAbstractNode alloc] init];
	[child setNodeTitle:@"ports.conf.erb"];
	[child setIsLeaf:true];
	[node addObject:child];	
	child = [[KCAbstractNode alloc] init];
	[child setNodeTitle:@"web_app.conf.erb"];
	[child setIsLeaf:true];
	[node addObject:child];	
	child = [[KCAbstractNode alloc] init];
	[child setNodeTitle:@"default_site.erb"];
	[child setIsLeaf:true];
	[node addObject:child];	
	[a addObject:node];
	
	NSString* source = @"#\n# Cookbook Name:: apache2\n# Recipe:: default\n#\n\npackage \"apache2\" do\n	action :install\nend\n\n";

	[self setSourceText:source];
	[self setCookbookContents:a];
}

-(NSString*)iconName
{
	return @"NSMysteryDocument";
}

@end
