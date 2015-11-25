/*


#include <ApplicationServices/ApplicationServices.h>

#import "MyView.h"
#import "myDraw.h"

@implementation MyView
- (void)drawRect:(NSRect)rect
{
    NSGraphicsContext *nsgc = [NSGraphicsContext currentContext];
    CGContextRef gc = [nsgc graphicsPort];
    
    NSEraseRect(rect);
    CGContextSetTextMatrix(gc, CGAffineTransformIdentity);
    myDraw(gc, (CGRect *)&rect);
}

- (void)forceUpdate:(id)sender
{
    [self setNeedsDisplay:YES];
}

@end