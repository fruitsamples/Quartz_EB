/*


/*
 *  myDraw.m
 *
 *  Copyright (c) 2001 Apple Computer, Inc. All rights reserved.
 *
 */
 
#include <ApplicationServices/ApplicationServices.h>
#include "myDraw.h"

#define kNumOfExamples 3
/*
 * myDraw is called whenever the view is updated.
 * context - CG context to draw into
 * windowRect - rectangle defining the window rectangle
 */ 
void myDraw(CGContextRef context, CGRect* contextRect)
{
    int w, h;
    static int n = 0;
    
    w = contextRect->size.width;
    h = contextRect->size.height;
    
    switch (n) {
    case 0:
        // Draw Text
        CGContextSelectFont(context, "Apple Chancery", h/10, kCGEncodingMacRoman);
        CGContextSetTextDrawingMode(context, kCGTextFillStroke);
        CGContextSetLineWidth(context, 1);
        CGContextSetRGBFillColor(context, 1, 0, 0, 1);
        CGContextSetRGBStrokeColor(context, 0, 0, 0, 1);
        CGContextShowTextAtPoint(context, 10, h/2, "Quartz Early Bird", 17);
        break;
        
    case 1:
    {
        // Draw a bitmap
        CGImageRef image;
        CGColorSpaceRef colorspace;
        CGDataProviderRef provider;
        BitmapStruct bitmap;
    
        getBitmap("Ladybug.jpg", &bitmap);
    
        provider = CGDataProviderCreateWithData(NULL, bitmap.bits, bitmap.bytesPerRow*bitmap.h, NULL);

        colorspace = CGColorSpaceCreateDeviceRGB();

        image = CGImageCreate(bitmap.w, bitmap.h,
                            bitmap.bitsPerComponent, bitmap.bitsPerPixel,
                            bitmap.bytesPerRow, colorspace,
                            kCGImageAlphaNone, provider, NULL, 0,
                            kCGRenderingIntentDefault);
        CGDataProviderRelease(provider);
        CGColorSpaceRelease(colorspace);

        CGContextDrawImage(context, *contextRect, image);

        CGImageRelease(image);
        releaseBitmap(&bitmap);
        break;
    }

    case 2:
    {
        // Draw a PDF Document
        CGPDFDocumentRef document;
        CGRect mediaBox;
        document = getPDFDocumentRef("iBook.pdf");
        mediaBox = CGPDFDocumentGetMediaBox(document, 1);
        CGContextBeginPage(context, &mediaBox);
        CGContextDrawPDFDocument(context, *contextRect, document, 1);
        CGContextEndPage(context);
        CGPDFDocumentRelease(document);
        break;
    }

    default:
        break;
    }
    
    n = ((n+1) % kNumOfExamples);
}
