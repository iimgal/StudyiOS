#import "ASIHTTPRequestHeader.h"

// 创建ASIHTTPRequest对象
NSURL *url = [NSURL URLWithString:@"http://www.163.com"];
ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
// 开始同步请求
[request startSynchronous];
// 是否报错
if([request error]) {
    // 得到错误信息
    [showText setText:[[request error] localizedDescription]];
} else if([request responseString]) {
    // 得到返回信息
    [showText setText:[request responseString]];
}

// 带SSL访问HTTPS
// The first object in the array is our SecIdentityRef
[certificates addObject:(id)clientCertificateIdentity];

// If we've added any additional certificates, add them too
for (id cert in clientCertificates) {
    [certificates addObject:cert];
}