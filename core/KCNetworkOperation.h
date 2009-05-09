//
//  KCNetworkOperation.h
//  Cuisine
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
}

@property (nonatomic, retain) NSObject *result;
@property (nonatomic, retain) NSData *data;
@property (nonatomic, retain) NSError *error;
@property (nonatomic, retain) NSURL *url;

@end
