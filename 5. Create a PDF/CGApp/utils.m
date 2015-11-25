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

CFURLRef get_url(const char *filename)
{
    CFURLRef url;
    CFStringRef path;

    path = CFStringCreateWithCString(NULL, filename, kCFStringEncodingUTF8);
    if (path == NULL) {
        printf("can't create CFString.");
        exit(0);
    }

    url = CFURLCreateWithFileSystemPath(NULL, path, kCFURLPOSIXPathStyle, 0);
    CFRelease(path);
    if (url == NULL) {
        printf("can't create CFURL.");
        exit(0);
    }

    return url;
}