/*


#import "MyDocument.h"

@implementation MyDocument
- init
{
    if(![NSBundle loadNibNamed: @"MyDocument.nib" owner: self])
    {
        [self release];
    }
    return nil;
}

@end