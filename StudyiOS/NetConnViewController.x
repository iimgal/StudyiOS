<span class = "brown">#import</span> <span class = "red">"Reachability.h"</span>
<span class = "green">// 测试连接可用性</span>
<span class = "cyan">Reachability</span>*hostReach = [<span class = "cyan">Reachability reachabilityWithHostName</span>:@"www.baidu.com"];
<span class = "green">// 判断连接类型</span>
<span class = "magenta">switch</span>([hostReach <span class = "cyan">currentReachabilityStatus</span>]) {
<span class = "magenta">case</span> <span class = "cyan">NotReachable</span>:
connectionKind = <span class = "red">@"没有网络链接"</span>;<span class = "magenta">break</span>;
<span class = "magenta">case</span> <span class = "cyan">ReachableViaWiFi</span>:
connectionKind = <span class = "red">@"当前使用的网络类型是WIFI"</span>;<span class = "magenta">break</span>;
<span class = "magenta">case</span> <span class = "cyan">ReachableViaWWAN</span>:
connectionKind = <span class = "red">@"当前使用的网络链接类型是WWAN（3G）"</span>;<span class = "magenta">break</span>;
}