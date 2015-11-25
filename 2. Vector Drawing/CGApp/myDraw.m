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

/*
 * myDraw is called whenever the view is updated.
 * context - CG context to draw into
 * windowRect - rectangle defining the window rectangle
 */ 

void drawRandomPaths(CGContextRef context, int w, int h)
{
    int i;
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
}

void myDraw(CGContextRef context, CGRect* contextRect)
{
    int i;
    int w, h;
    static int n = 0;
    
    w = contextRect->size.width;
    h = contextRect->size.height;
    
    switch (n) {
    case 0:
        // Draw random rectangles (some stroked some filled)
        for (i = 0; i < 20; i++) {
            if(i % 2) {
                CGContextSetRGBFillColor(context, (float)(rand()%256)/255, 
                        (float)(rand()%256)/255, (float)(rand()%256)/255, 
                        (float)(rand()%256)/255);
                CGContextFillRect(context, CGRectMake(rand()%w, rand()%h, rand()%w, rand()%h));
            }
            else {
                CGContextSetLineWidth(context, (rand()%10)+2);
                CGContextSetRGBStrokeColor(context, (float)(rand()%256)/255, 
                        (float)(rand()%256)/255, (float)(rand()%256)/255, 
                        (float)(rand()%256)/255);
                CGContextStrokeRect(context, CGRectMake(rand()%w, rand()%h, rand()%w, rand()%h));
            }
        }
        break;
    case 1:
        // Draw random circles (some stroked, some filled)
        for (i = 0; i < 20; i++) {
            CGContextBeginPath(context);
            CGContextAddArc(context, rand()%w, rand()%h, rand()%((w>h) ? h : w), 0, 2*PI, 0);
            CGContextClosePath(context);

            if(i % 2) {
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
        break;
    case 2:
        drawRandomPaths(context, w, h);
        break;
    case 3:
        /* Clipping example - draw random path through a circular clip */
        CGContextBeginPath(context);
        CGContextAddArc(context, w/2, h/2, ((w>h) ? h : w)/2, 0, 2*PI, 0);
        CGContextClosePath(context);
        CGContextClip(context);
        
        // Draw something into the clip
        drawRandomPaths(context, w, h);
        
        // Draw an clip path on top as a black stroked circle.
        CGContextBeginPath(context);
        CGContextAddArc(context, w/2, h/2, ((w>h) ? h : w)/2, 0, 2*PI, 0);
        CGContextClosePath(context);
        CGContextSetLineWidth(context, 1);
        CGContextSetRGBStrokeColor(context, 0, 0, 0, 1);
        CGContextStrokePath(context);
        break;
        
    default:
        break;
    }
    
    n = ((n+1) % kNumOfExamples);
}
