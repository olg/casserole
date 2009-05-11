//
//  KCValueTransformers.m
//  Casserole
//
//  Created by Olivier Gutknecht on 09/05/09.
//  Copyright 2009 Fotonauts. All rights reserved.
//

#import "KCValueTransformers.h"



@implementation KCValueTransformers

@end


@implementation S3OperationSummarizer
+ (Class)transformedValueClass
{
	return [NSAttributedString class];
}

+ (BOOL)allowsReverseTransformation
{
	return NO;
}

- (id)transformedValue:(id)data
{
	if ([data length]>4096)
		return [[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%u bytes in raw data response",[data length]]] autorelease];
	
	NSString *s = [[[NSString alloc] initWithData:data encoding:NSNonLossyASCIIStringEncoding] autorelease];
	if (s==nil)
		return [[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%u bytes in raw data response",[data length]]] autorelease];
	return [[[NSAttributedString alloc] initWithString:s] autorelease];	
}

@end

@implementation KCStringArrayTransformer

+ (Class)transformedValueClass
{
    return [NSString class];
}

+ (BOOL)allowsReverseTransformation
{
    return NO;
}

- (id)transformedValue:(id)item {
	if ([item isKindOfClass:[NSArray class]])
		return [(NSArray*)item componentsJoinedByString:@","]; 
	else
		return item;
}
@end