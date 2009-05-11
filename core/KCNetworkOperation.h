//
//  KCNetworkOperation.h
//  Casserole
//
//  Created by Olivier Gutknecht on 09/05/09.
//  Copyright 2009 Fotonauts. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface KCNetworkOperation : NSOperation {
	NSObject *result;
	NSData *data;
	NSURL *url;
	NSError *error;
	NSString* type;
	NSString* summary;
	NSObject* callback;
}

@property (retain) NSObject *callback;
@property (retain) NSString *summary;
@property (retain) NSString *type;
@property (retain) NSObject *result;
@property (retain) NSData *data;
@property (retain) NSError *error;
@property (retain) NSURL *url;

@end
