//
//  ViewController.m
//  Socket
//
//  Created by  on 11-11-15.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "AsyncSocketViewController.h"
#import "AsyncSocket.h"

@implementation AsyncSocketViewController

@synthesize client = _client;
@synthesize server = _server;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle
- (void)viewDidUnload
{
    _client = nil;
    _server = nil;
    [super viewDidUnload];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 增加Code按钮，可跳转至教学页面
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"Code" style:UIBarButtonItemStyleBordered target:self action:@selector(code)];
    self.navigationItem.rightBarButtonItem = item;

}


- (IBAction)connectPressed:(id)sender 
{
    // 建立一个Socket实体并连接到本地服务器的7777端口
    _client = [[AsyncSocket alloc] initWithDelegate:self];
    NSError *err = nil;
    if (![_client connectToHost:@"127.0.0.1" onPort:7777 withTimeout:5.0f error:&err]) {
        NSLog(@"client net:%@", err);
    }
}

- (IBAction)sendPressed:(id)sender {
    // 发送数据到服务器
    NSString *path = [[NSBundle mainBundle] pathForResource:@"InfoPlist" ofType:@"strings"];
    NSData* data = [NSData dataWithContentsOfFile:path];
    
    [_server writeData:data withTimeout:-1 tag:1];
}

#pragma mark -
#pragma mark AsyncSocket Delegate
// 添加事件响应函数
- (void)onSocket:(AsyncSocket *)sock didConnectToHost:(NSString *)host port:(UInt16)port
{
    NSLog(@"didConnectToHost");
    // 在本函数中请求读取数据, AsyncSocket内部会在有接收到数据的时候调用函数didReadData:
    [_client readDataWithTimeout:-1 tag:0];
    // 将传入的sock给记录下来,这就是我们连接的服务器的socket接口了
    _server = sock;
}

- (void)onSocketDidSecure:(AsyncSocket *)sock
{
    NSLog(@"onSocketDidSecure");
}

- (void)onSocket:(AsyncSocket *)sock willDisconnectWithError:(NSError *)err
{
    NSLog(@"willDisconnectWithError");
}

- (void)onSocketDidDisconnect:(AsyncSocket *)sock
{
    NSLog(@"onSocketDidDisconnect");
}

- (void)onSocket:(AsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{
    // 本函数被调用过之后这个读取请求就结束了,我们不想让它结束掉, 所以在函数结尾处加入, 这样读取过程就可以一直持继下去了
    NSLog(@"didReadData");
    [_client readDataWithTimeout:-1 tag:0];
}

// 跳转至教学页面
- (void)code
{
    CodeViewController *controller = [[CodeViewController alloc] initWithNibName:@"CodeViewController" bundle:nil];
    NSString *name = [NSString stringWithUTF8String:object_getClassName(self)];
    controller.className = name;
    
    [self.navigationController pushViewController:controller animated:YES];
}

@end
