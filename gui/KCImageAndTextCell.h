//
//  KCImageAndTextCell.h
//  Cuisine
//
//  Created by Olivier Gutknecht on 08/05/09.
//  Copyright 2009 Fotonauts. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface KCImageAndTextCell : NSTextFieldCell {
@private
	NSImage *image;
}

- (void)setImage:(NSImage *)anImage;
- (NSImage*)image;

- (void)drawWithFrame:(NSRect)cellFrame inView:(NSView*)controlView;
- (NSSize)cellSize;

@end
