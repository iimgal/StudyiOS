#import "QuartzCore/QuartzCore.h"
// 使用Core Animation创建动画
// 创建CATransition对象
CATransition *animation = CATransition animation;
animation.delegate = self;
// 设定动画时间
animation.duration = 0.7;
// 设定动画快慢(开始与结束时较慢)
animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
// 设定动画类型
// 详细16种类型见源码
animation.type = kCATransitionFade;
// 设定动画方向
animation.subtype = kCATransitionFromLeft;
...// 此处编写视图切换代码
// 动画开始
[[self.view layer] addAnimation:animation forKey:@"animation"];