//
//  KCNetworkOperation.m
//  Cuisine
//
//  Created by Olivier Gutknecht on 09/05/09.
//  Copyright 2009 Fotonauts. All rights reserved.
//

#import "KCNetworkOperation.h"
#import "JSON/JSON.h"

@interface NSURLRequest (SomePrivateAPIs)
+ (BOOL)allowsAnyHTTPSCertificateForHost:(id)fp8;
+ (void)setAllowsAnyHTTPSCertificate:(BOOL)fp8 forHost:(id)fp12;
@end


@implementation KCNetworkOperation
@synthesize result;
@synthesize data;
@synthesize url;
@synthesize error;

-(void)main
{
	NSError *e;
	NSData *d;
	NSHTTPURLResponse *response;

	[NSURLRequest setAllowsAnyHTTPSCertificate:YES forHost:[[self url] host]];
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[self url] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10];
	d = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&e];
	if (d!=nil)
	{
		[self setData:d];

		SBJSON *parser = [[SBJSON alloc] init];
		NSString *json_string = [[NSString alloc] initWithData:d encoding:NSUTF8StringEncoding];
		NSObject* r = [parser objectWithString:json_string error:nil];
		[self setResult:r];
	}
	if (e!=nil)
		[self setError:e];
}

@end
