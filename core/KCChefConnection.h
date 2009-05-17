//
//  KCChefConnection.h
//  Casserole
//
//  Created by Olivier Gutknecht on 09/05/09.
//  Copyright 2009 Fotonauts. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class KCCookbook;

@interface KCChefConnection : NSObject {
	NSString* serverURL; // https://chef.example.com
	NSMutableArray* nodes;
	NSMutableArray* registrations;
	NSMutableArray* cookbooks;
}

@property (retain) NSString* serverURL;
@property (retain) NSMutableArray* registrations;
@property (retain) NSMutableArray* cookbooks;
@property (retain) NSMutableArray* nodes;

-(void)refresh:(id)sender;
-(KCCookbook*)cookbookForName:(NSString*)name;

@end
