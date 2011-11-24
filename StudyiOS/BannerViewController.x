#import <iAd/iAd.h>
实现ADBannerViewDelegate

ADBannerView *banner;
self.banner.delegate = self;

// ADBannerViewDelegate委托方法
// 广告栏加载成功后调用
- (void)bannerViewDidLoadAd:(ADBannerView *)banner;
// 点击广告栏后调用
- (BOOL)bannerViewActionShouldBegin:(ADBannerView *)banner willLeaveApplication:(BOOL)willLeave;