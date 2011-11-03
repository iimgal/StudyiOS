//
//  PhotoWallViewController.m
//  StudyiOS
//
//  Created by  on 11-10-31.
//  Copyright (c) 2011年 ZhangYiCheng. All rights reserved.
//

#import "PhotoWallViewController.h"
#import "MockPhotoSource.h"

@implementation PhotoWallViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    // 增加Code按钮，可跳转至教学页面
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"Code" style:UIBarButtonItemStyleBordered target:self action:@selector(code)];
    self.navigationItem.rightBarButtonItem = item;
    
    // 添加数据源
    self.photoSource = [[MockPhotoSource alloc]
                        initWithType:MockPhotoSourceNormal
                        //initWithType:MockPhotoSourceDelayed
                        // initWithType:MockPhotoSourceLoadError
                        // initWithType:MockPhotoSourceDelayed|MockPhotoSourceLoadError
                        title:@"Flickr Photos"
                        photos:[[NSArray alloc] initWithObjects:
                                [[MockPhoto alloc]
                                  initWithURL:@"http://farm4.static.flickr.com/3246/2957580101_33c799fc09_o.jpg"
                                  smallURL:@"http://farm4.static.flickr.com/3246/2957580101_d63ef56b15_t.jpg"
                                  size:CGSizeMake(960, 1280)],
                                [[MockPhoto alloc]
                                  initWithURL:@"http://farm4.static.flickr.com/3444/3223645618_13fe36887a_o.jpg"
                                  smallURL:@"http://farm4.static.flickr.com/3444/3223645618_f5e2fa7fea_t.jpg"
                                  size:CGSizeMake(320, 480)
                                  caption:@"These are the wood tiles that we had installed after the accident."],
                                [[MockPhoto alloc]
                                  initWithURL:@"http://farm2.static.flickr.com/1124/3164979509_bcfdd72123.jpg?v=0"
                                  smallURL:@"http://farm2.static.flickr.com/1124/3164979509_bcfdd72123_t.jpg"
                                  size:CGSizeMake(320, 480)
                                  caption:@"A hike."],
                                [[MockPhoto alloc]
                                  initWithURL:@"http://farm4.static.flickr.com/3106/3203111597_d849ef615b.jpg?v=0"
                                  smallURL:@"http://farm4.static.flickr.com/3106/3203111597_d849ef615b_t.jpg"
                                  size:CGSizeMake(320, 480)],
                                [[MockPhoto alloc]
                                  initWithURL:@"http://farm4.static.flickr.com/3099/3164979221_6c0e583f7d.jpg?v=0"
                                  smallURL:@"http://farm4.static.flickr.com/3099/3164979221_6c0e583f7d_t.jpg"
                                  size:CGSizeMake(320, 480)],
                                [[MockPhoto alloc]
                                  initWithURL:@"http://farm4.static.flickr.com/3081/3164978791_3c292029f2.jpg?v=0"
                                  smallURL:@"http://farm4.static.flickr.com/3081/3164978791_3c292029f2_t.jpg"
                                  size:CGSizeMake(320, 480)],
                                
                                [[MockPhoto alloc]
                                  initWithURL:@"http://farm3.static.flickr.com/2358/2179913094_3a1591008e.jpg"
                                  smallURL:@"http://farm3.static.flickr.com/2358/2179913094_3a1591008e_t.jpg"
                                  size:CGSizeMake(383, 500)],
                                [[MockPhoto alloc]
                                  initWithURL:@"http://farm4.static.flickr.com/3162/2677417507_e5d0007e41.jpg"
                                  smallURL:@"http://farm4.static.flickr.com/3162/2677417507_e5d0007e41_t.jpg"
                                  size:CGSizeMake(391, 500)],
                                [[MockPhoto alloc]
                                  initWithURL:@"http://farm4.static.flickr.com/3334/3334095096_ffdce92fc4.jpg"
                                  smallURL:@"http://farm4.static.flickr.com/3334/3334095096_ffdce92fc4_t.jpg"
                                  size:CGSizeMake(407, 500)],
                                [[MockPhoto alloc]
                                  initWithURL:@"http://farm4.static.flickr.com/3118/3122869991_c15255d889.jpg"
                                  smallURL:@"http://farm4.static.flickr.com/3118/3122869991_c15255d889_t.jpg"
                                  size:CGSizeMake(500, 406)],
                                [[MockPhoto alloc]
                                  initWithURL:@"http://farm2.static.flickr.com/1004/3174172875_1e7a34ccb7.jpg"
                                  smallURL:@"http://farm2.static.flickr.com/1004/3174172875_1e7a34ccb7_t.jpg"
                                  size:CGSizeMake(500, 372)],
                                [[MockPhoto alloc]
                                  initWithURL:@"http://farm3.static.flickr.com/2300/2179038972_65f1e5f8c4.jpg"
                                  smallURL:@"http://farm3.static.flickr.com/2300/2179038972_65f1e5f8c4_t.jpg"
                                  size:CGSizeMake(391, 500)],
                                
                                [[MockPhoto alloc]
                                  initWithURL:@"http://farm4.static.flickr.com/3246/2957580101_33c799fc09_o.jpg"
                                  smallURL:@"http://farm4.static.flickr.com/3246/2957580101_d63ef56b15_t.jpg"
                                  size:CGSizeMake(960, 1280)],
                                [[MockPhoto alloc]
                                  initWithURL:@"http://farm4.static.flickr.com/3444/3223645618_13fe36887a_o.jpg"
                                  smallURL:@"http://farm4.static.flickr.com/3444/3223645618_f5e2fa7fea_t.jpg"
                                  size:CGSizeMake(320, 480)
                                  caption:@"These are the wood tiles that we had installed after the accident."],
                                [[MockPhoto alloc]
                                  initWithURL:@"http://farm2.static.flickr.com/1124/3164979509_bcfdd72123.jpg?v=0"
                                  smallURL:@"http://farm2.static.flickr.com/1124/3164979509_bcfdd72123_t.jpg"
                                  size:CGSizeMake(320, 480)
                                  caption:@"A hike."],
                                [[MockPhoto alloc]
                                  initWithURL:@"http://farm4.static.flickr.com/3106/3203111597_d849ef615b.jpg?v=0"
                                  smallURL:@"http://farm4.static.flickr.com/3106/3203111597_d849ef615b_t.jpg"
                                  size:CGSizeMake(320, 480)],
                                [[MockPhoto alloc]
                                  initWithURL:@"http://farm4.static.flickr.com/3099/3164979221_6c0e583f7d.jpg?v=0"
                                  smallURL:@"http://farm4.static.flickr.com/3099/3164979221_6c0e583f7d_t.jpg"
                                  size:CGSizeMake(320, 480)],
                                [[MockPhoto alloc]
                                  initWithURL:@"http://farm4.static.flickr.com/3081/3164978791_3c292029f2.jpg?v=0"
                                  smallURL:@"http://farm4.static.flickr.com/3081/3164978791_3c292029f2_t.jpg"
                                  size:CGSizeMake(320, 480)],
                                
                                [[MockPhoto alloc]
                                  initWithURL:@"http://farm3.static.flickr.com/2358/2179913094_3a1591008e.jpg"
                                  smallURL:@"http://farm3.static.flickr.com/2358/2179913094_3a1591008e_t.jpg"
                                  size:CGSizeMake(383, 500)],
                                [[MockPhoto alloc]
                                  initWithURL:@"http://farm4.static.flickr.com/3162/2677417507_e5d0007e41.jpg"
                                  smallURL:@"http://farm4.static.flickr.com/3162/2677417507_e5d0007e41_t.jpg"
                                  size:CGSizeMake(391, 500)],
                                [[MockPhoto alloc]
                                  initWithURL:@"http://farm4.static.flickr.com/3334/3334095096_ffdce92fc4.jpg"
                                  smallURL:@"http://farm4.static.flickr.com/3334/3334095096_ffdce92fc4_t.jpg"
                                  size:CGSizeMake(407, 500)],
                                [[MockPhoto alloc]
                                  initWithURL:@"http://farm4.static.flickr.com/3118/3122869991_c15255d889.jpg"
                                  smallURL:@"http://farm4.static.flickr.com/3118/3122869991_c15255d889_t.jpg"
                                  size:CGSizeMake(500, 406)] ,
                                [[MockPhoto alloc]
                                  initWithURL:@"http://farm2.static.flickr.com/1004/3174172875_1e7a34ccb7.jpg"
                                  smallURL:@"http://farm2.static.flickr.com/1004/3174172875_1e7a34ccb7_t.jpg"
                                  size:CGSizeMake(500, 372)] ,
                                [[MockPhoto alloc]
                                  initWithURL:@"http://farm3.static.flickr.com/2300/2179038972_65f1e5f8c4.jpg"
                                  smallURL:@"http://farm3.static.flickr.com/2300/2179038972_65f1e5f8c4_t.jpg"
                                  size:CGSizeMake(391, 500)] ,
                                
                                [[MockPhoto alloc]
                                  initWithURL:@"http://farm4.static.flickr.com/3246/2957580101_33c799fc09_o.jpg"
                                  smallURL:@"http://farm4.static.flickr.com/3246/2957580101_d63ef56b15_t.jpg"
                                  size:CGSizeMake(960, 1280)] ,
                                [[MockPhoto alloc]
                                  initWithURL:@"http://farm4.static.flickr.com/3444/3223645618_13fe36887a_o.jpg"
                                  smallURL:@"http://farm4.static.flickr.com/3444/3223645618_f5e2fa7fea_t.jpg"
                                  size:CGSizeMake(320, 480)
                                  caption:@"These are the wood tiles that we had installed after the accident."] ,
                                [[MockPhoto alloc]
                                  initWithURL:@"http://farm2.static.flickr.com/1124/3164979509_bcfdd72123.jpg?v=0"
                                  smallURL:@"http://farm2.static.flickr.com/1124/3164979509_bcfdd72123_t.jpg"
                                  size:CGSizeMake(320, 480)
                                  caption:@"A hike."] ,
                                [[MockPhoto alloc]
                                  initWithURL:@"http://farm4.static.flickr.com/3106/3203111597_d849ef615b.jpg?v=0"
                                  smallURL:@"http://farm4.static.flickr.com/3106/3203111597_d849ef615b_t.jpg"
                                  size:CGSizeMake(320, 480)] ,
                                [[MockPhoto alloc]
                                  initWithURL:@"http://farm4.static.flickr.com/3099/3164979221_6c0e583f7d.jpg?v=0"
                                  smallURL:@"http://farm4.static.flickr.com/3099/3164979221_6c0e583f7d_t.jpg"
                                  size:CGSizeMake(320, 480)] ,
                                [[MockPhoto alloc]
                                  initWithURL:@"http://farm4.static.flickr.com/3081/3164978791_3c292029f2.jpg?v=0"
                                  smallURL:@"http://farm4.static.flickr.com/3081/3164978791_3c292029f2_t.jpg"
                                  size:CGSizeMake(320, 480)] ,
                                
                                [[MockPhoto alloc]
                                  initWithURL:@"http://farm3.static.flickr.com/2358/2179913094_3a1591008e.jpg"
                                  smallURL:@"http://farm3.static.flickr.com/2358/2179913094_3a1591008e_t.jpg"
                                  size:CGSizeMake(383, 500)] ,
                                [[MockPhoto alloc]
                                  initWithURL:@"http://farm4.static.flickr.com/3162/2677417507_e5d0007e41.jpg"
                                  smallURL:@"http://farm4.static.flickr.com/3162/2677417507_e5d0007e41_t.jpg"
                                  size:CGSizeMake(391, 500)] ,
                                [[MockPhoto alloc]
                                  initWithURL:@"http://farm4.static.flickr.com/3334/3334095096_ffdce92fc4.jpg"
                                  smallURL:@"http://farm4.static.flickr.com/3334/3334095096_ffdce92fc4_t.jpg"
                                  size:CGSizeMake(407, 500)] ,
                                [[MockPhoto alloc]
                                  initWithURL:@"http://farm4.static.flickr.com/3118/3122869991_c15255d889.jpg"
                                  smallURL:@"http://farm4.static.flickr.com/3118/3122869991_c15255d889_t.jpg"
                                  size:CGSizeMake(500, 406)] ,
                                [[MockPhoto alloc]
                                  initWithURL:@"http://farm2.static.flickr.com/1004/3174172875_1e7a34ccb7.jpg"
                                  smallURL:@"http://farm2.static.flickr.com/1004/3174172875_1e7a34ccb7_t.jpg"
                                  size:CGSizeMake(500, 372)] ,
                                [[MockPhoto alloc]
                                  initWithURL:@"http://farm3.static.flickr.com/2300/2179038972_65f1e5f8c4.jpg"
                                  smallURL:@"http://farm3.static.flickr.com/2300/2179038972_65f1e5f8c4_t.jpg"
                                  size:CGSizeMake(391, 500)] ,
                                
                                [[MockPhoto alloc]
                                  initWithURL:@"http://farm4.static.flickr.com/3246/2957580101_33c799fc09_o.jpg"
                                  smallURL:@"http://farm4.static.flickr.com/3246/2957580101_d63ef56b15_t.jpg"
                                  size:CGSizeMake(960, 1280)] ,
                                [[MockPhoto alloc]
                                  initWithURL:@"http://farm4.static.flickr.com/3444/3223645618_13fe36887a_o.jpg"
                                  smallURL:@"http://farm4.static.flickr.com/3444/3223645618_f5e2fa7fea_t.jpg"
                                  size:CGSizeMake(320, 480)
                                  caption:@"These are the wood tiles that we had installed after the accident."] ,
                                [[MockPhoto alloc]
                                  initWithURL:@"http://farm2.static.flickr.com/1124/3164979509_bcfdd72123.jpg?v=0"
                                  smallURL:@"http://farm2.static.flickr.com/1124/3164979509_bcfdd72123_t.jpg"
                                  size:CGSizeMake(320, 480)
                                  caption:@"A hike."] ,
                                [[MockPhoto alloc]
                                  initWithURL:@"http://farm4.static.flickr.com/3106/3203111597_d849ef615b.jpg?v=0"
                                  smallURL:@"http://farm4.static.flickr.com/3106/3203111597_d849ef615b_t.jpg"
                                  size:CGSizeMake(320, 480)] ,
                                [[MockPhoto alloc]
                                  initWithURL:@"http://farm4.static.flickr.com/3099/3164979221_6c0e583f7d.jpg?v=0"
                                  smallURL:@"http://farm4.static.flickr.com/3099/3164979221_6c0e583f7d_t.jpg"
                                  size:CGSizeMake(320, 480)] ,
                                [[MockPhoto alloc]
                                  initWithURL:@"http://farm4.static.flickr.com/3081/3164978791_3c292029f2.jpg?v=0"
                                  smallURL:@"http://farm4.static.flickr.com/3081/3164978791_3c292029f2_t.jpg"
                                  size:CGSizeMake(320, 480)] ,
                                
                                [[MockPhoto alloc]
                                  initWithURL:@"http://farm3.static.flickr.com/2358/2179913094_3a1591008e.jpg"
                                  smallURL:@"http://farm3.static.flickr.com/2358/2179913094_3a1591008e_t.jpg"
                                  size:CGSizeMake(383, 500)] ,
                                [[MockPhoto alloc]
                                  initWithURL:@"http://farm4.static.flickr.com/3162/2677417507_e5d0007e41.jpg"
                                  smallURL:@"http://farm4.static.flickr.com/3162/2677417507_e5d0007e41_t.jpg"
                                  size:CGSizeMake(391, 500)] ,
                                [[MockPhoto alloc]
                                  initWithURL:@"http://farm4.static.flickr.com/3334/3334095096_ffdce92fc4.jpg"
                                  smallURL:@"http://farm4.static.flickr.com/3334/3334095096_ffdce92fc4_t.jpg"
                                  size:CGSizeMake(407, 500)] ,
                                [[MockPhoto alloc]
                                  initWithURL:@"http://farm4.static.flickr.com/3118/3122869991_c15255d889.jpg"
                                  smallURL:@"http://farm4.static.flickr.com/3118/3122869991_c15255d889_t.jpg"
                                  size:CGSizeMake(500, 406)] ,
                                [[MockPhoto alloc]
                                  initWithURL:@"http://farm2.static.flickr.com/1004/3174172875_1e7a34ccb7.jpg"
                                  smallURL:@"http://farm2.static.flickr.com/1004/3174172875_1e7a34ccb7_t.jpg"
                                  size:CGSizeMake(500, 372)] ,
                                [[MockPhoto alloc]
                                  initWithURL:@"http://farm3.static.flickr.com/2300/2179038972_65f1e5f8c4.jpg"
                                  smallURL:@"http://farm3.static.flickr.com/2300/2179038972_65f1e5f8c4_t.jpg"
                                  size:CGSizeMake(391, 500)] ,
                                
                                [[MockPhoto alloc]
                                  initWithURL:@"http://farm4.static.flickr.com/3246/2957580101_33c799fc09_o.jpg"
                                  smallURL:@"http://farm4.static.flickr.com/3246/2957580101_d63ef56b15_t.jpg"
                                  size:CGSizeMake(960, 1280)] ,
                                [[MockPhoto alloc]
                                  initWithURL:@"http://farm4.static.flickr.com/3444/3223645618_13fe36887a_o.jpg"
                                  smallURL:@"http://farm4.static.flickr.com/3444/3223645618_f5e2fa7fea_t.jpg"
                                  size:CGSizeMake(320, 480)
                                  caption:@"These are the wood tiles that we had installed after the accident."] ,
                                [[MockPhoto alloc]
                                  initWithURL:@"http://farm2.static.flickr.com/1124/3164979509_bcfdd72123.jpg?v=0"
                                  smallURL:@"http://farm2.static.flickr.com/1124/3164979509_bcfdd72123_t.jpg"
                                  size:CGSizeMake(320, 480)
                                  caption:@"A hike."] ,
                                [[MockPhoto alloc]
                                  initWithURL:@"http://farm4.static.flickr.com/3106/3203111597_d849ef615b.jpg?v=0"
                                  smallURL:@"http://farm4.static.flickr.com/3106/3203111597_d849ef615b_t.jpg"
                                  size:CGSizeMake(320, 480)] ,
                                [[MockPhoto alloc]
                                  initWithURL:@"http://farm4.static.flickr.com/3099/3164979221_6c0e583f7d.jpg?v=0"
                                  smallURL:@"http://farm4.static.flickr.com/3099/3164979221_6c0e583f7d_t.jpg"
                                  size:CGSizeMake(320, 480)] ,
                                [[MockPhoto alloc]
                                  initWithURL:@"http://farm4.static.flickr.com/3081/3164978791_3c292029f2.jpg?v=0"
                                  smallURL:@"http://farm4.static.flickr.com/3081/3164978791_3c292029f2_t.jpg"
                                  size:CGSizeMake(320, 480)] ,
                                
                                [[MockPhoto alloc]
                                  initWithURL:@"http://farm3.static.flickr.com/2358/2179913094_3a1591008e.jpg"
                                  smallURL:@"http://farm3.static.flickr.com/2358/2179913094_3a1591008e_t.jpg"
                                  size:CGSizeMake(383, 500)] ,
                                [[MockPhoto alloc]
                                  initWithURL:@"http://farm4.static.flickr.com/3162/2677417507_e5d0007e41.jpg"
                                  smallURL:@"http://farm4.static.flickr.com/3162/2677417507_e5d0007e41_t.jpg"
                                  size:CGSizeMake(391, 500)] ,
                                [[MockPhoto alloc]
                                  initWithURL:@"http://farm4.static.flickr.com/3334/3334095096_ffdce92fc4.jpg"
                                  smallURL:@"http://farm4.static.flickr.com/3334/3334095096_ffdce92fc4_t.jpg"
                                  size:CGSizeMake(407, 500)] ,
                                [[MockPhoto alloc]
                                  initWithURL:@"http://farm4.static.flickr.com/3118/3122869991_c15255d889.jpg"
                                  smallURL:@"http://farm4.static.flickr.com/3118/3122869991_c15255d889_t.jpg"
                                  size:CGSizeMake(500, 406)] ,
                                
                                nil
                                ]
                        
                        photos2:nil
                        //  photos2:[[NSArray alloc] initWithObjects:
                        //    [[[MockPhoto alloc]
                        //      initWithURL:@"http://farm4.static.flickr.com/3280/2949707060_e639b539c5_o.jpg"
                        //      smallURL:@"http://farm4.static.flickr.com/3280/2949707060_8139284ba5_t.jpg"
                        //      size:CGSizeMake(800, 533)] autorelease],
                        //    nil]
                        ];
    
    [super viewDidLoad];
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

// 跳转至教学页面
- (void)code
{
    CodeViewController *controller = [[CodeViewController alloc] init];
    NSString *name = [NSString stringWithUTF8String:object_getClassName(self)];
    controller.className = name;
    
    [self.navigationController pushViewController:controller animated:YES];
}

@end
