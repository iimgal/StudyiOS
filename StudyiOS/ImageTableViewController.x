#import "AsyncImageView.h"

// 创建异步图片视图
AsyncImageView* asyncImage = [[AsyncImageView alloc] initWithFrame:frame];    
// 加载异步图片
[asyncImage loadImageFromURL:url]; 