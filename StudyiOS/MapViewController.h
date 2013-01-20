//
//  ViewController.h
//  MapTest
//
//  Created by ZhangYiCheng on 12-12-14.
//  Copyright (c) 2012年 ZhangYiCheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface MapViewController : BaseViewController <MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) NSMutableArray *annotations;
@property (strong, nonatomic) IBOutlet UILabel *label;

- (IBAction)refresh:(id)sender;

@end
