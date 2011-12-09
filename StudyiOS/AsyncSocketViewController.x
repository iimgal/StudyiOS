本示例请结合SocketServer一起运行

#import "AsyncSocket.h"

// 建立一个Socket实体并连接到本地服务器的7777端口
_client = [[AsyncSocket alloc] initWithDelegate:self];
[_client connectToHost:@"127.0.0.1" onPort:7777 withTimeout:5.0f error:&err]
// 发送数据到服务器
[_server writeData:data withTimeout:-1 tag:1];

// 添加事件响应函数
- (void)onSocket:(AsyncSocket *)sock didConnectToHost:(NSString *)host port:(UInt16)port
{
    // 在本函数中请求读取数据, AsyncSocket内部会在有接收到数据的时候调用函数didReadData:
    [_client readDataWithTimeout:-1 tag:0];
    // 将传入的sock给记录下来,这就是我们连接的服务器的socket接口了
    _server = sock;
}

- (void)onSocket:(AsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{
    // 本函数被调用过之后这个读取请求就结束了,我们不想让它结束掉, 所以在函数结尾处加入, 这样读取过程就可以一直持继下去了
    [_client readDataWithTimeout:-1 tag:0];
}

// 带SSL的Socket
[sock startTLS:settings];