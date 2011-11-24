#import "Reachability.h"
// 测试连接可用性
Reachability *hostReach = [Reachability reachabilityWithHostName:@"www.baidu.com"];
// 判断连接类型
switch([hostReach currentReachabilityStatus]) {
case NotReachable:
    connectionKind = @"没有网络链接";
    break;
case ReachableViaWiFi:
    connectionKind = @"当前使用的网络类型是WIFI";
    break;
case ReachableViaWWAN:
    connectionKind = @"当前使用的网络链接类型是WWAN（3G）";
    break;
}