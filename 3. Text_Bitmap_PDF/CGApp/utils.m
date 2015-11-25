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
        exit(0);
    }
    if ([bmi isPlanar]) {
        printf("planar bitmap format not supported.\n");
        exit(0);
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

CGPDFDocumentRef getPDFDocumentRef(char *filename)
{
    CFStringRef path;
    CFURLRef url;
    CGPDFDocumentRef document;    
    size_t count;

    path = CFStringCreateWithCString(NULL, filename, kCFStringEncodingUTF8);
    url = CFURLCreateWithFileSystemPath(NULL, path, kCFURLPOSIXPathStyle, 0);
    CFRelease(path);
    if (url == NULL) {
        printf("can't create CFURL.");
        exit(0);
    }
    document = CGPDFDocumentCreateWithURL(url);
    CFRelease(url);
    if (document == NULL) {
        printf("can't open `%s'.", filename);
        exit(0);
    }
    count = CGPDFDocumentGetNumberOfPages(document);
    if (count == 0) {
        printf("`%s' needs at least one page!", filename);
        exit(0);
    }
    return document;
}