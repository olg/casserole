//
//  KCViewController.h
//  Cuisine
//
//  Created by Olivier Gutknecht on 09/05/09.
//  Copyright 2009 Fotonauts. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "KCChefConnection.h";

@interface KCViewController : NSViewController {
	KCChefConnection *chefConnection;
}

@property (retain) KCChefConnection *chefConnection;

@end
