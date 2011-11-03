<span class="brown">#import</span> <span class="red">"QuartzCore/QuartzCore.h"</span>
<span class="green">// 使用Core Animation创建动画</span>
<span class="green">// 创建CATransition对象</span>
<span class="purple">CATransition</span> *animation = [<span class="purple">CATransition animation</span>];
animation.<span class="purple">delegate</span> = <span class="magenta">self</span>;
<span class="green">// 设定动画时间</span>
animation.<span class="purple">duration</span> = <span class="purple">0.7</span>;
<span class="green">// 设定动画快慢(开始与结束时较慢)</span>
animation.<span class="purple">timingFunction</span> = [<span class="purple">CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut</span>];
<span class="green">// 设定动画类型</span>
<span class="green">// 详细16种类型见源码</span>
animation.<span class="purple">type</span> = <span class="purple">kCATransitionFade</span>;
<span class="green">// 设定动画方向</span>
animation.<span class="purple">subtype</span> = <span class="purple">kCATransitionFromLeft</span>;
...<span class="green">// 此处编写视图切换代码</span>
<span class="green">// 动画开始</span>
[[<span class="magenta">self</span>.<span class="purple">view layer</span>] <span class="purple">addAnimation</span>:animation <span class="purple">forKey</span>:<span class="red">@"animation"</span>];