<span class = "brown">#import</span> <span class = "red">"ASIHTTPRequestHeader.h"</span>

<span class = "green">// 创建ASIHTTPRequest对象</span>
<span class = "purple">NSURL</span>*url = [<span class = "purple">NSURL URLWithString</span>:<span class = "red">@"http://www.163.com"</span>];
<span class = "cyan">ASIHTTPRequest</span>*request = [<span class = "cyan">ASIHTTPRequest requestWithURL</span>:url];
<span class = "green">// 开始同步请求</span>
[request <span class = "cyan">startSynchronous</span>];
<span class = "green">// 是否报错</span>
<span class = "magenta">if</span>([request <span class = "cyan">error</span>]) {
    <span class = "green">// 得到错误信息</span>
    [<span class = "cyan">showText</span> <span class = "purple">setText</span>:[[request <span class = "cyan">error</span>] <span class = "purple">localizedDescription</span>]];
} <span class = "magenta">else if</span>([request <span class = "cyan">responseString</span>]) {
    <span class = "green">// 得到返回信息</span>
    [<span class = "cyan">showText</span> <span class = "purple">setText</span>:[request <span class = "cyan">responseString</span>]];
}
    