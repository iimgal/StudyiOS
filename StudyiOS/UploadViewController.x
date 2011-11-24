#import "ASIHTTPRequestHeader.h"
// 设置一个表单请求
[self setRequest:[ASIFormDataRequest requestWithURL:url]];
// 设置超时时间
[request setTimeOutSeconds:20];
// 允许后台运行
[request setShouldContinueWhenAppEntersBackground:YES];
// 设置委托
[request setDelegate:self];
// 设置错误方法
[request setDidFailSelector:@selector(uploadFailed:)];
// 设置完成方法
[request setDidFinishSelector:@selector(uploadFinished:)];
// 设置上传文件
[request setFile:path forKey:@"file1"];
// 开始异步请求
[request startAsynchronous];