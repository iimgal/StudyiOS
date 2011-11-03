<span class = "brown">#import</span> <span class = "red">"Three20/Three20+Additions.h"</span>
<span class = "green">TTScrollViewDataSource,TTScrollViewDelegate</span>
<span class = "green">// 创建滑动视图</span>
<span class = "cyan">scrollView</span>= [[<span class = "cyan">TTScrollView</span> <span class = "purple">alloc</span>] <span class = "purple">initWithFrame:CGRectMake</span>(0,0, width, height];
<span class = "green">// 设置委托</span>
<span class = "cyan">scrollView.dataSource</span>= <span class = "magenta">self</span>;
<span class = "cyan">scrollView.delegate</span> = <span class = "magenta">self</span>;
<span class = "green">// 创建页面控制器</span>
<span class = "cyan">pageControl</span>= [[<span class = "purple">TTPageControl</span> <span class = "purple">alloc</span>] <span class = "purple">initWithFrame:CGRectMake</span>(0,380, width, 20)];
<span class = "green">// 需实现以下委托方法</span>
- (<span class = "purple">NSInteger</span>)numberOfPagesInScrollView:(<span class = "cyan">TTScrollView</span>*)scrollView;
- (<span class = "purple">UIView</span>*)scrollView:(<span class = "cyan">TTScrollView</span>*)scrollView pageAtIndex:(<span class = "purple">NSInteger</span>)pageIndex;
- (<span class = "purple">CGSize</span>)scrollView:(<span class = "cyan">TTScrollView</span>*)scrollView sizeOfPageAtIndex:(<span class = "purple">NSInteger</span>)pageIndex;
- (<span class = "magenta">void</span>)scrollView:(<span class = "cyan">TTScrollView</span>*)scrollView didMoveToPageAtIndex:(<span class = "purple">NSInteger</span>)pageIndex;
    