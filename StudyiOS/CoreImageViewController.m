//
//  CoreImageViewController.m
//  StudyiOS
//
//  Created by  on 11-10-11.
//  Copyright (c) 2011年 ZhangYiCheng. All rights reserved.
//

#import "CoreImageViewController.h"

#import "ES1Renderer.h"
#import "ES2Renderer.h"

@implementation CoreImageViewController

@synthesize imageView;


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - View lifecycle
//- (id)initWithCoder:(NSCoder *)aDecoder
//{
//    if ((self = [super initWithCoder:aDecoder]))
//    {
//        CAEAGLLayer *eaglLayer = (CAEAGLLayer *)self.view.layer;
//        
//        eaglLayer.opaque = TRUE;
//        eaglLayer.drawableProperties = [NSDictionary dictionaryWithObjectsAndKeys:
//                                        [NSNumber numberWithBool:FALSE], kEAGLDrawablePropertyRetainedBacking, kEAGLColorFormatRGBA8, kEAGLDrawablePropertyColorFormat, nil];
//		
//    }
//    
//    return self;
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
}


- (void)viewDidUnload
{
    self.imageView = nil;
    [super viewDidUnload];
}


- (IBAction)buttonPressed:(id)sender
{
    //NSArray *array = [CIFilter filterNamesInCategories:nil];
    
//    CIFilter *myFilter;
//    NSDictionary *myFilterAttributes;
//    myFilter = [CIFilter filterWithName:@"CIExposureFilter"];
//    myFilterAttributes = [myFilter attributes];
    
//    NSMutableDictionary *categories = [[NSMutableDictionary alloc] init];
//    
//    NSMutableArray  *array = [NSMutableArray arrayWithArray:
//             [CIFilter filterNamesInCategories:nil]];
//    
//    [categories setObject: [self buildFilterDictionary: array]
//                   forKey: @"All"];
    
    
//    CIContext *context;
//    
//    if(context == nil)
//    {
//        context = [CIContext contextWithCGContext:
//                   [[UIGraphicsContext currentContext] graphicsPort]
//                                          options: nil]
//        [context retain];
//    }
    
//    CIContext *myCIContext;
//    const NSOpenGLPixelFormatAttribute attr[] = {
//        NSOpenGLPFAAccelerated,
//        NSOpenGLPFANoRecovery,
//        NSOpenGLPFAColorSize, 32,
//        0
//    };
//    pf = [[NSOpenGLPixelFormat alloc] initWithAttributes:(void *)&attr];
//    myCIContext = [CIContext contextWithCGLContext: CGLGetCurrentContext()
//                                       pixelFormat: [pf CGLPixelFormatObj]
//                                           options: nil];
    //ES2Renderer *renderer = [[ES2Renderer alloc] init];
    //[renderer resizeFromLayer:(CAEAGLLayer*)self.view.layer];
    
    // Get the layer

    CAEAGLLayer *eaglLayer = (CAEAGLLayer *)self.imageView.layer;
    
    eaglLayer.opaque = TRUE;
    eaglLayer.drawableProperties = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:FALSE], kEAGLDrawablePropertyRetainedBacking, kEAGLColorFormatRGBA8, kEAGLDrawablePropertyColorFormat, nil];
    
    ES2Renderer *renderer = [[ES2Renderer alloc] init];
    
    //EAGLContext *eContext = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    [renderer resizeFromLayer:(CAEAGLLayer*)self.imageView.layer];
    
    //[eContext renderbufferStorage:GL_RENDERBUFFER fromDrawable:(CAEAGLLayer *)self.imageView.layer];
    
    EAGLContext *eContext = [EAGLContext currentContext];
    CIContext *context = [CIContext contextWithEAGLContext:eContext];
    
    //CIImage *myCIImage = [[CIImage alloc] initWithImage:self.imageView.image];
    
    
    CIImage *myCIImage = [[CIImage alloc] initWithImage:self.imageView.image];
    
//    CIFilter *hueAdjust = [CIFilter filterWithName:@"CIHueAdjust"];
//    [hueAdjust setDefaults];
//    [hueAdjust setValue: myCIImage forKey: @"inputImage"];
//    [hueAdjust setValue: [NSNumber numberWithFloat: 2.094]
//                 forKey: @"inputAngle"];
//    CIImage *result = [hueAdjust valueForKey: @"outputImage"];
    CIImage *result = myCIImage;
    
    CGRect rect = CGRectMake(0, 0, 640, 960);
    
    [context drawImage:result atPoint:CGPointZero fromRect:rect];
    //[context drawImage:result inRect:rect fromRect:rect];
    
    
    //UIImage *image = [[UIImage alloc] initWithCIImage:result];
    //self.imageView.image = image;
    
    
}

- (NSMutableDictionary *)buildFilterDictionary: (NSArray *)names// 1
{
    NSMutableDictionary  *td, *catfilters;
    NSDictionary         *attr;
    NSString             *classname;
    CIFilter             *filter;
    int                   i;
    
    catfilters = [NSMutableDictionary dictionary];
    
    for(i=0 ; i<[names count] ; i++)// 2
    {
        classname = [names objectAtIndex: i];// 3
        filter = [CIFilter filterWithName: classname];// 4
        
        if(filter)
        {
            attr = [filter attributes];// 5
            
            td   = [NSMutableDictionary dictionary];
            [td setObject: classname forKey: @"class"];// 6
            [catfilters setObject: td
                           forKey:[attr objectForKey:@"CIAttributeFilterDisplayName"]];// 7
        }
        
        else
            NSLog(@" could not create '%@' filter", classname);
    }
    
    return catfilters;

}


@end
