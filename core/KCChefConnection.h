//
//  KCChefConnection.h
//  Cuisine
//
//  Created by Olivier Gutknecht on 09/05/09.
//  Copyright 2009 Fotonauts. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface KCChefConnection : NSObject {
	NSString* serverURL;
}

@property (nonatomic, retain) NSString* serverURL;
@end
