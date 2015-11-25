/*


/*
 *  myDraw.m
 *
 *  Copyright (c) 2001 Apple Computer, Inc. All rights reserved.
 *
 */
 
#include <ApplicationServices/ApplicationServices.h>
#include "myDraw.h"


void MakeClip(CGContextRef context)
{
    CGPoint star[5];

    CGContextSetLineWidth(context, 2.0);
    CGContextSetLineCap(context, kCGLineCapSquare);
    CGContextSetLineJoin(context, kCGLineJoinBevel);

    star[0] = CGPointMake(150.0, 50.0);
    star[1] = CGPointMake(350.0, 250.0);
    star[2] = CGPointMake(150.0, 250.0);
    star[3] = CGPointMake(350.0, 50.0);
    star[4] = CGPointMake(250.0, 350.0);

    CGContextSetRGBStrokeColor(context, 1.0, 0.0, 0.0, 1.0);
    CGContextSetRGBFillColor(context, 1.0, 0.0, 0.0, 1.0);

    CGContextAddLines(context, star, 5);
     
    CGContextClosePath(context);
     
    CGContextEOClip(context);
}


/*
 * myDraw is called whenever the view is updated.
 * context - CG context to draw into
 * windowRect - rectangle defining the window rectangle
 */
 
void myDraw(CGContextRef context, CGRect* contextRect)
{
    int w, h;
    int i;

    w = contextRect->size.width;
    h = contextRect->size.height;

    MakeClip(context); 

    for( i = 0 ; i < 500; i++)
    {
        CGPoint pt;
        getMouseLocation(&pt);
                
        CGContextSetRGBFillColor(context, 1.0, 1.0, 1.0, 1.0);  
        CGContextFillRect(context,*contextRect);

        CGContextSaveGState(context);
        CGContextTranslateCTM(context, pt.x, pt.y);
        CGContextSetRGBFillColor(context, 0.0, 1.0, 0.0, 1.0);
        CGContextSetRGBStrokeColor(context, 1, 0, 0, 1);
        CGContextBeginPath(context);
        CGContextAddRect(context, CGRectMake(0,0,100,100));
        CGContextDrawPath(context, kCGPathFillStroke);
        CGContextFlush(context);
        CGContextRestoreGState(context);
    }
}

