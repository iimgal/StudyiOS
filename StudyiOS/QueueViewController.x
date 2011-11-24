#import "ASIHTTPRequestHeader.h"
// 初始化队列
networkQueue = [[ASINetworkQueue alloc] init];
// 设置完成方法
[networkQueue setRequestDidFinishSelector:@selector(imageFetchComplete:)];
// 设置错误方法
[networkQueue setRequestDidFailSelector:@selector(imageFetchFailed:)];
// 设置委托
[networkQueue setDelegate:self];
// 初始化请求
ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
// 设置下载的目标路径
[request setDownloadDestinationPath:path];
// 将请求加入队列
[networkQueue addOperation:request];
// 启动队列
[networkQueue go];