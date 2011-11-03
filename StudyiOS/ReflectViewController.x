<span class="brown">#import</span> <span class="red">"IIReflectionImage.h"</span>

// 设置映射比例
<span class = "purple">NSUInteger</span> height = <span class = "magenta">self</span>.<span class = "cyan">imageView</span>.<span class = "purple">bounds.size.height * 1.0</span>;
// 得到映射图片
<span class = "magenta">self</span>.<span class = "cyan">reflectView</span>.<span class = "purple">image</span> = [<span class = "cyan">IIReflectionImage reflectedImage</span>:<span class = "magenta">self</span>.<span class = "cyan">imageView withHeight</span>:height];