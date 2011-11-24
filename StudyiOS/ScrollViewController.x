// 是否按页滚动
    self.scrollView.pagingEnabled = YES;
    // 背景色
    self.scrollView.backgroundColor = [UIColor blackColor];
    // 滚动条颜色 因为背景为黑,所以用白色
    self.scrollView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
    // 隐藏水平滚动条
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.canCancelContentTouches = NO;
    self.scrollView.clipsToBounds = YES;
    // 设置委托
    self.scrollView.delegate = self;
    // 添加子视图
    [self.scrollView addSubview:imageView];
    // 修改子视图位置
    CGRect frame = imageView.frame;
    frame.origin = CGPointMake(width*i, 0);
    imageView.frame = frame;
    // 设置ScrollView大小
    self.scrollView.contentSize = CGSizeMake(width*[array count], scrollView.bounds.size.height);