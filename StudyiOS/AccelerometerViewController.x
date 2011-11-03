<span class = "green">// 需实现UIAccelerometerDelegate委托</span>

<span class = "green">// 设置加速计采集频率(单位:秒)</span>
[<span class = "purple">[UIAccelerometer sharedAccelerometer] setUpdateInterval:1.0 / 60.0</span>];
<span class = "green">// 设置委托(注意对象销毁时要将委托设置为空)</span>
[<span class = "purple">[UIAccelerometer sharedAccelerometer] setDelegate</span>:<span class = "magenta">self</span>];
<span class = "green">// 加速计委托方法根据设置的采集频率定时调用</span>
-(<span class = "red">void</span>)accelerometer:(<span class = "purple">UIAccelerometer</span> *)accelerometer didAccelerate:(<span class = "purple">UIAcceleration</span> *)acceleration;
<span class = "green">// 取3个方向的值</span>
acceleration.<span class = "purple">x</span> ,acceleration.<span class = "purple">y</span> ,acceleration.<span class = "purple">z</span>