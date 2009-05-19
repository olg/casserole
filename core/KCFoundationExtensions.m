//
//  KCFoundationExtensions.m
//  Casserole
//
//  Created by Olivier Gutknecht on 5/19/09.
//  Copyright 2009 Fotonauts. All rights reserved.
//

#import "KCFoundationExtensions.h"


@implementation NSString (TimeInterval)

+ (NSString *)stringForTimeInterval:(NSTimeInterval)i
{
	NSTimeInterval interval = fabs(i);
	double years = 0;
	double months = 0;
	// double weeks = 0;
	double days = round(interval/86400.0);
	double hours = round(((int)interval % 86400)/1440);
	double minutes = round(((int)interval % 1440)/60);
	double seconds = (int)interval % 60;
	
	if (years!=0)
		return [NSString stringWithFormat:@"%.0f years %.0f months %.0f days %.0f hours %.0f minutes %.0f seconds", years, months, days, hours, minutes, seconds];
	if (months!=0)
		return [NSString stringWithFormat:@"%.0f months %.0f days %.0f hours %.0f minutes %.0f seconds", months, days, hours, minutes, seconds];    
	if (days!=0)
		return [NSString stringWithFormat:@"%.0f days %.0f hours %.0f minutes %.0f seconds", days, hours, minutes, seconds];    
	if (hours!=0)
		return [NSString stringWithFormat:@"%.0f hours %.0f minutes %.0f seconds", hours, minutes, seconds];    
	if (minutes!=0)
		return [NSString stringWithFormat:@"%.0f minutes %.0f seconds", minutes, seconds];    
	
	return [NSString stringWithFormat:@"%.0f seconds", seconds];
}

@end