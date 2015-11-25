/*


/*
 *  utils.h
 *
 *  Copyright (c) 2001 Apple Computer, Inc. All rights reserved.
 *
 */

#import <stdlib.h>
#import <stdio.h>
#import <AppKit/NSImage.h>

typedef struct BitmapStruct
{
    float w;
    float h;
    size_t bitsPerPixel;
    size_t bitsPerComponent;
    size_t bytesPerRow;
    void* bits;
    void* reserved;
} BitmapStruct;

// For a given file name, fills the bitmap structure with 
// the bitmap data.
void getBitmap(char* filename, BitmapStruct* bitmap);

// Release the memory associated with the bitmap.
void releaseBitmap(BitmapStruct* bitmap);

// Gets the current location of the mouse in screen coordinates.
void getMouseLocation(CGPoint *loc);

// Give a file name, returns a CFURL
CFURLRef get_url(const char *filename);