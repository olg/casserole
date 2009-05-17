//
//  KCNetworkOperation.m
//  Casserole
//
//  Created by Olivier Gutknecht on 09/05/09.
//  Copyright 2009 Fotonauts. All rights reserved.
//

#import "KCNetworkOperation.h"
#import <JSON/JSON.h>
@interface NSURLRequest (SomePrivateAPIs)
+ (BOOL)allowsAnyHTTPSCertificateForHost:(id)fp8;
+ (void)setAllowsAnyHTTPSCertificate:(BOOL)fp8 forHost:(id)fp12;
@end


@implementation KCNetworkOperation
@synthesize userInfo;
@synthesize result;
@synthesize data;
@synthesize url;
@synthesize error;
@synthesize summary;
@synthesize type;

-(void)main
{
	NSError *e = nil;
	NSData *d;
	NSHTTPURLResponse *response = nil;

	[NSURLRequest setAllowsAnyHTTPSCertificate:YES forHost:[[self url] host]];
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[self url] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10];
	[request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
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
		NSLog(@"error %@ %@",self.url,e);
	[self setError:e];
}

-(void)finalize
{
    [super finalize];
}

@end

// Will refactor these two operations

@implementation KCNetworkStringOperation
@synthesize userInfo;
@synthesize result;
@synthesize data;
@synthesize url;
@synthesize error;
@synthesize summary;
@synthesize type;
@synthesize userInfo;

-(void)main
{
	NSError *e = nil;
	NSData *d;
	NSHTTPURLResponse *response = nil;

	[NSURLRequest setAllowsAnyHTTPSCertificate:YES forHost:[[self url] host]];
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[self url] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10];
	d = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&e];
	if (d!=nil)
	{
		[self setData:d];
		NSString *string = [[NSString alloc] initWithData:d encoding:NSUTF8StringEncoding];
		[self setResult:string];
	}
	if (e!=nil)
		NSLog(@"error %@ %@",self.url,e);
	[self setError:e];
}

-(void)finalize
{
    [super finalize];
}

@end
