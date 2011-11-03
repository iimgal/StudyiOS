<span class = "brown">#import</span> <span class = "red">"ASIHTTPRequestHeader.h"</span>
<span class = "green">// 设置一个表单请求</span>
[<span class = "magenta">self</span> <span class = "cyan">setRequest</span>:[<span class = "cyan">ASIFormDataRequest requestWithURL</span>:url]];
<span class = "green">// 设置超时时间</span>
[<span class = "cyan">request setTimeOutSeconds</span>:<span class = "purple">20</span>];
<span class = "green">// 允许后台运行</span>
[<span class = "cyan">request setShouldContinueWhenAppEntersBackground</span>:<span class = "magenta">YES</span>];
<span class = "green">// 设置委托</span>
[<span class = "cyan">request setDelegate</span>:<span class = "magenta">self</span>];
<span class = "green">// 设置错误方法</span>
[<span class = "cyan">request setDidFailSelector</span>:<span class = "magenta">@selector</span>(uploadFailed:)];
<span class = "green">// 设置完成方法</span>
[<span class = "cyan">request setDidFinishSelector</span>:<span class = "magenta">@selector</span>(uploadFinished:)];
<span class = "green">// 设置上传文件</span>
[<span class = "cyan">request setFile</span>:path <span class = "cyan">forKey</span>:<span class = "magenta">@"file1"</span>];
<span class = "green">// 开始异步请求</span>
[<span class = "cyan">request startAsynchronous</span>];