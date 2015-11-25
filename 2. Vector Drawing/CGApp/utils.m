/*


#include <ApplicationServices/ApplicationServices.h>
#include <Cocoa/Cocoa.h>
#include "utils.h"
 
void getMouseLocation(CGPoint *loc)
{
    //CGSGetWindowMouseLocation([NSApp contextID], 
    //        [[NSApp mainWindow] windowNumber], &pt);
    NSPoint pt;
    pt = [[NSApp mainWindow] mouseLocationOutsideOfEventStream];
    loc->x = pt.x;
    loc->y = pt.y;
}



void getBitmap(char* filename, BitmapStruct* bitmap)
{
    NSString *file;
    NSData *data;
    NSBitmapImageRep *bmi;

    file = [NSString stringWithCString:filename];
    data = [NSData dataWithContentsOfMappedFile:file];
    bmi = [[NSBitmapImageRep alloc] initWithData:data];

    if (bmi == nil) {
        printf("cannot read from file\n");
        return;
    }
    if ([bmi isPlanar]) {
        printf("planar bitmap format not supported.\n");
        return;
    }

    bitmap->w = [bmi pixelsWide];
    bitmap->h = [bmi pixelsHigh];
    bitmap->bitsPerPixel = [bmi bitsPerPixel];
    bitmap->bitsPerComponent = [bmi bitsPerSample];
    bitmap->bytesPerRow = [bmi bytesPerRow];
    bitmap->reserved = bmi;
    bitmap->bits = [bmi bitmapData];

}

void releaseBitmap(BitmapStruct* bitmap)
{
    NSBitmapImageRep *bmi;
    bmi = (NSBitmapImageRep *)bitmap->reserved;
    if (bitmap && bmi)
        [bmi release];
}
