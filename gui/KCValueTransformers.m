//
//  KCValueTransformers.m
//  Casserole
//
//  Created by Olivier Gutknecht on 09/05/09.
//  Copyright 2009 Fotonauts. All rights reserved.
//

#import "KCValueTransformers.h"


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