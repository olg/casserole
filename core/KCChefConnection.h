//
//  KCChefConnection.h
//  Cuisine
//
//  Created by Olivier Gutknecht on 09/05/09.
//  Copyright 2009 Fotonauts. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface KCChefConnection : NSObject {
	NSString* serverURL; // https://chef.example.com
}

@property (nonatomic, retain) NSString* serverURL;

-(void)initialFetch;

@end
