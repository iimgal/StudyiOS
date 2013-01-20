//
//  ViewController.m
//  MapTest
//
//  Created by ZhangYiCheng on 12-12-14.
//  Copyright (c) 2012年 ZhangYiCheng. All rights reserved.
//

#import "MapViewController.h"
#import <MapKit/MapKit.h>


#define KILOMETER 1000.0 // 1公里

@interface MapViewController ()

@end

@implementation MapViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.mapView.mapType = MKMapTypeStandard; // 地图显示模式
    self.mapView.showsUserLocation = YES; // 是否显示用户位置
    
    self.mapView.delegate = self;
    
    // 增加长按手势
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressed:)];
    [self.mapView addGestureRecognizer:longPress];
    
    // 刷新地图
    [self performSelector:@selector(refresh:) withObject:nil afterDelay:3.0f];

    self.label.text = @"长按放下大头针";
    
    
}

// 长按增加大头针
- (void)longPressed:(UIGestureRecognizer *)gestureRecognizer {
    // 判断手势状态,在这里当手指拿开和移动时返回
    if (gestureRecognizer.state == UIGestureRecognizerStateEnded || gestureRecognizer.state == UIGestureRecognizerStateChanged){
        return;
    }
    
    // 坐标转换
    CGPoint touchPoint = [gestureRecognizer locationInView:self.mapView];
    CLLocationCoordinate2D touchMapCoordinate = [self.mapView convertPoint:touchPoint toCoordinateFromView:self.mapView];
    
    // 设置大头针
    MKPointAnnotation* pointAnnotation = [[MKPointAnnotation alloc] init];
    pointAnnotation.coordinate = touchMapCoordinate;
    pointAnnotation.title = @"Go Here!";
    
    // 加入大头针(这时还没显示,要显示需实现下面那个方法)
    if (!self.annotations) {
        self.annotations = [@[] mutableCopy];
    }
    [self.mapView removeAnnotations:self.annotations];
    [self.mapView addAnnotation:pointAnnotation];
    [self.annotations addObject:pointAnnotation];
    
    self.label.text = @"点击大头针显示路线图";
}

// 显示大头针
- (MKAnnotationView *)mapView:(MKMapView *)theMapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    // 判断是用户本身的大头针则返回
    if ([annotation isKindOfClass:[MKUserLocation class]])
    {
        return nil;
    }
    
    // 显示大头针,大头针的重用机制和UITableViewCell类似
    static NSString* AnnotationIdentifier = @"AnnotationIdentifier";
    MKPinAnnotationView* customPinView = (MKPinAnnotationView *)[self.mapView dequeueReusableAnnotationViewWithIdentifier:AnnotationIdentifier];
    
    if (!customPinView) {
        customPinView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationIdentifier];
        
        customPinView.pinColor = MKPinAnnotationColorRed; // 设置大头针的颜色
        customPinView.animatesDrop = YES; // 大头针显示动画
        customPinView.canShowCallout = YES; // 大头针可显示详情
//        customPinView.draggable = YES; // 可以拖动
        
        //添加tips上的按钮
        UIButton* rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        [rightButton addTarget:self action:@selector(openAppleMap:) forControlEvents:UIControlEventTouchUpInside];
        customPinView.rightCalloutAccessoryView = rightButton;
    }
    else {
        customPinView.annotation = annotation;
    }
    
    return customPinView;
    
}

// 启动AppleMap,显示路线图
- (void)openAppleMap:(id)sender {
    // 得到被点击的大头针
    UIButton *button = (UIButton *)sender;
    MKPinAnnotationView *view = (MKPinAnnotationView *)button.superview.superview;
    
    // 设置位置信息
    MKPlacemark *placemark = [[MKPlacemark alloc] initWithCoordinate:[view.annotation coordinate] addressDictionary:nil];
    MKMapItem* sfStore = [[MKMapItem alloc] initWithPlacemark:placemark];
    
    // 交通工具为开车
    NSDictionary *launchOptions = @{MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving};
    
    // 启动AppleMap
    [sfStore openInMapsWithLaunchOptions:launchOptions];
}

// 刷新
- (IBAction)refresh:(id)sender {
    [self.mapView removeAnnotations:self.annotations];
    
    // 取得用户当前位置
    CLLocationCoordinate2D zoomLocation = self.mapView.userLocation.location.coordinate;
    if (zoomLocation.latitude == 0) {
        zoomLocation = CLLocationCoordinate2DMake(30.2504, 120.163);
    }
    
    // 设定显示范围为500米
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 0.5*KILOMETER, 0.5*KILOMETER);
    
    // 显示
    [_mapView setRegion:viewRegion animated:YES];
}


- (void)viewDidUnload {
    [self setLabel:nil];
    [super viewDidUnload];
}
@end
