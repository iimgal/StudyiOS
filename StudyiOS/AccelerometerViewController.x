// 需实现UIAccelerometerDelegate委托

// 设置加速计采集频率(单位:秒)
[[UIAccelerometer sharedAccelerometer] setUpdateInterval:1.0 / 60.0];
// 设置委托(注意对象销毁时要将委托设置为空)
[[UIAccelerometer sharedAccelerometer] setDelegate:self];
// 加速计委托方法根据设置的采集频率定时调用
-(void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration;
// 取3个方向的值
acceleration.x ,acceleration.y ,acceleration.z