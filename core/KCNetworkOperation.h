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
	NSObject* userInfo;
}

@property (retain) NSObject *userInfo;
@property (retain) NSString *summary;
@property (retain) NSString *type;
@property (retain) NSObject *result;
@property (retain) NSData *data;
@property (retain) NSError *error;
@property (retain) NSURL *url;

@end

@interface KCNetworkStringOperation : NSOperation {
	NSObject *result;
	NSData *data;
	NSURL *url;
	NSError *error;
	NSString* type;
	NSString* summary;
	NSObject* userInfo;
}

@property (retain) NSObject *userInfo;
@property (retain) NSString *summary;
@property (retain) NSString *type;
@property (retain) NSObject *result;
@property (retain) NSData *data;
@property (retain) NSError *error;
@property (retain) NSURL *url;

@end
