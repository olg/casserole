//
//  KCCookbook.h
//  Casserole
//
//  Created by Olivier Gutknecht on 17/05/09.
//  Copyright 2009 Fotonauts. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "KCAbstractNode.h"

@interface KCCookbook : KCChefNode {
	KCChefNode* recipes;
	KCChefNode* libraries;
	KCChefNode* attributes;
	KCChefNode* definitions;
	NSMutableArray* content;
}

@property (retain) NSMutableArray* content;

@property (retain) KCChefNode* recipes;
@property (retain) KCChefNode* libraries;
@property (retain) KCChefNode* attributes;
@property (retain) KCChefNode* definitions;

-(void)addRecipe:(NSString*)name;
-(KCChefNode*)recipeForName:(NSString*)name;
-(void)addLibrary:(NSString*)name;
-(KCChefNode*)libraryForName:(NSString*)name;
-(void)addDefinition:(NSString*)name;
-(KCChefNode*)definitionForName:(NSString*)name;
-(void)addAttribute:(NSString*)name;
-(KCChefNode*)attributeForName:(NSString*)name;

@end
