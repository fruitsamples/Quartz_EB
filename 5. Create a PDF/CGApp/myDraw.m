/*


/*
 *  myDraw.m
 *
 *  Copyright (c) 2001 Apple Computer, Inc. All rights reserved.
 *
 */
 
#include <ApplicationServices/ApplicationServices.h>
#include "myDraw.h"

#define kNumOfExamples 4
#define PI 3.14159265358979323846

void drawContent(CGContextRef context, int w, int h)
{
    int i;
    
    CGContextBeginPath(context);
    CGContextAddArc(context, w/2, h/2, ((w>h) ? h : w)/2, 0, 2*PI, 0);
    CGContextClosePath(context);
    CGContextClip(context);
    
    for (i = 0; i < 20; i++) {
        int numberOfSegments = rand() % 8;
        int j;
        float sx, sy;
        
        CGContextBeginPath(context);
        sx = rand()%w; sy = rand()%h;
        CGContextMoveToPoint(context, rand()%w, rand()%h);
        for (j = 0; j < numberOfSegments; j++) {
            if (j % 2) {
                CGContextAddLineToPoint(context, rand()%w, rand()%h);
            }
            else {
                CGContextAddCurveToPoint(context, rand()%w, rand()%h,  
                    rand()%w, rand()%h,  rand()%h, rand()%h);
            }
        }
        if(i % 2) {
            CGContextAddCurveToPoint(context, rand()%w, rand()%h,
                    rand()%w, rand()%h,  sx, sy);
            CGContextClosePath(context);
            CGContextSetRGBFillColor(context, (float)(rand()%256)/255, 
                    (float)(rand()%256)/255, (float)(rand()%256)/255, 
                    (float)(rand()%256)/255);
            CGContextFillPath(context);
        }
        else {
            CGContextSetLineWidth(context, (rand()%10)+2);
            CGContextSetRGBStrokeColor(context, (float)(rand()%256)/255, 
                    (float)(rand()%256)/255, (float)(rand()%256)/255, 
                    (float)(rand()%256)/255);
            CGContextStrokePath(context);
        }
    }
    
    // Draw an clip path on top as a black stroked circle.
    CGContextBeginPath(context);
    CGContextAddArc(context, w/2, h/2, ((w>h) ? h : w)/2, 0, 2*PI, 0);
    CGContextClosePath(context);
    CGContextSetLineWidth(context, 1);
    CGContextSetRGBStrokeColor(context, 0, 0, 0, 1);
    CGContextStrokePath(context);
}

/*
 * myDraw is called whenever the view is updated.
 * context - CG context to draw into
 * windowRect - rectangle defining the window rectangle
 */ 
void myDraw(CGContextRef context, CGRect* contextRect)
{
    int w, h;
    CGContextRef pdfContext;
    CFURLRef url;
    CGRect pageRect;
    
    w = contextRect->size.width;
    h = contextRect->size.height;
    
    // Draw something to the screen
    drawContent(context, w, h);
    
    // Draw the same content into a pdf file
    url = get_url("test.pdf");
    pageRect = CGRectMake(0, 0, w, h);
    pdfContext = CGPDFContextCreateWithURL(url, &pageRect, NULL);
    CFRelease(url);
    CGContextBeginPage(pdfContext, &pageRect);
    drawContent(pdfContext, w, h);
    CGContextEndPage(pdfContext);
    CGContextRelease(pdfContext);
}
