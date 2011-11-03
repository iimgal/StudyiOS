//
//  CodeViewController.m
//  StudyiOS
//
//  Created by  on 11-10-30.
//  Copyright (c) 2011年 ZhangYiCheng. All rights reserved.
//

#import "CodeViewController.h"

@interface TextTestStyleSheet : TTDefaultStyleSheet
@end

@implementation TextTestStyleSheet

- (TTStyle*)blue {
    return [TTTextStyle styleWithColor:[UIColor blueColor] next:nil];
}

- (TTStyle*)green {
    return [TTTextStyle styleWithColor:[UIColor colorWithRed:0.0 green:0.6 blue:0.0 alpha:1.0] next:nil];
}

- (TTStyle*)red {
    return [TTTextStyle styleWithColor:[UIColor redColor] next:nil];
}

- (TTStyle*)purple {
    return [TTTextStyle styleWithColor:[UIColor purpleColor] next:nil];
}

- (TTStyle *)magenta {
    return [TTTextStyle styleWithColor:[UIColor magentaColor] next:nil];
}

- (TTStyle *)cyan {
    //return [TTTextStyle styleWithColor:[UIColor cyanColor] next:nil];
    return [TTTextStyle styleWithColor:[UIColor colorWithRed:0.0 green:0.7 blue:0.7 alpha:1.0] next:nil];
}

- (TTStyle *)brown {
    return [TTTextStyle styleWithColor:[UIColor brownColor] next:nil];
}

- (TTStyle*)largeText {
    return [TTTextStyle styleWithFont:[UIFont systemFontOfSize:32] next:nil];
}

- (TTStyle*)smallText {
    return [TTTextStyle styleWithFont:[UIFont systemFontOfSize:12] next:nil];
}

- (TTStyle*)floated {
    return [TTBoxStyle styleWithMargin:UIEdgeInsetsMake(0, 0, 5, 5)
                               padding:UIEdgeInsetsMake(0, 0, 0, 0)
                               minSize:CGSizeZero position:TTPositionFloatLeft next:nil];
}

- (TTStyle*)blueBox {
    return
    [TTShapeStyle styleWithShape:[TTRoundedRectangleShape shapeWithRadius:6] next:
     [TTInsetStyle styleWithInset:UIEdgeInsetsMake(0, -5, -4, -6) next:
      [TTShadowStyle styleWithColor:[UIColor grayColor] blur:2 offset:CGSizeMake(1,1) next:
       [TTSolidFillStyle styleWithColor:[UIColor cyanColor] next:
        [TTSolidBorderStyle styleWithColor:[UIColor grayColor] width:1 next:nil]]]]];
}

- (TTStyle*)inlineBox {
    return
    [TTSolidFillStyle styleWithColor:[UIColor blueColor] next:
     [TTBoxStyle styleWithPadding:UIEdgeInsetsMake(5,13,5,13) next:
      [TTSolidBorderStyle styleWithColor:[UIColor blackColor] width:1 next:nil]]];
}

- (TTStyle*)inlineBox2 {
    return
    [TTSolidFillStyle styleWithColor:[UIColor cyanColor] next:
     [TTBoxStyle styleWithMargin:UIEdgeInsetsMake(5,50,0,50)
                         padding:UIEdgeInsetsMake(0,13,0,13) next:nil]];
}

@end


@implementation CodeViewController
@synthesize className;

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle
//- (void)loadView
//{
//    
//}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    self.navigationItem.title = @"Code";
    
    [TTStyleSheet setGlobalStyleSheet:[[TextTestStyleSheet alloc] init]];
    
    TTStyledTextLabel* label = [[TTStyledTextLabel alloc] initWithFrame:self.view.bounds];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:self.className ofType:@"x"];
    NSString *kText = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    
    label.text = [TTStyledText textFromXHTML:kText lineBreaks:YES URLs:YES];
    label.contentInset = UIEdgeInsetsMake(10, 10, 10, 10);
    [label sizeToFit];
    self.view.backgroundColor = [UIColor colorWithWhite:1.0 alpha:1.0];
    
    [self.view addSubview:label];
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    self.className = nil;
    [super viewDidUnload];
}

- (void)dealloc {
    [TTStyleSheet setGlobalStyleSheet:nil];
}

@end
