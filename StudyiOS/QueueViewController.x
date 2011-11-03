<span class = "brown">#import</span> <span class = "red">"ASIHTTPRequestHeader.h"</span>
<span class = "green">// 初始化队列</span>
<span class = "cyan">networkQueue</span>= [[<span class = "cyan">ASINetworkQueue</span> <span class = "purple">alloc</span>] <span class = "purple">init</span>];
<span class = "green">// 设置完成方法</span>
[<span class = "cyan">networkQueue setRequestDidFinishSelector</span>:<span class = "magenta">@selector</span>(imageFetchComplete:)];
<span class = "green">// 设置错误方法</span>
[<span class = "cyan">networkQueue setRequestDidFailSelector</span>:<span class = "magenta">@selector</span>(imageFetchFailed:)];
<span class = "green">// 设置委托</span>
[<span class = "cyan">networkQueue setDelegate</span>:<span class = "magenta">self</span>];
<span class = "green">// 初始化请求</span>
<span class = "cyan">ASIHTTPRequest</span> *request = [<span class = "cyan">ASIHTTPRequest requestWithURL</span>:url];
<span class = "green">// 设置下载的目标路径</span>
[request <span class = "cyan">setDownloadDestinationPath</span>:path];
<span class = "green">// 将请求加入队列</span>
[<span class = "cyan">networkQueue</span> <span class = "magenta">addOperation</span>:request];
<span class = "green">// 启动队列</span>
[<span class = "cyan">networkQueue go</span>];