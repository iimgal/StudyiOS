<span class = "brown">#import</span> <span class = "red">"JSON.h"</span>
<span class = "green">// 得到json源文件字符串</span>
<span class = "purple">NSString</span>*jsonString = [<span class = "purple">[NSString alloc] initWithContentsOfFile</span>:path <span class = "purple">encoding:NSUTF8StringEncoding error</span>:<span class = "magenta">nil];
<span class = "green">// 解析json</span>
<span class = "purple">NSMutableDictionary</span>*dic = [jsonString <span class = "cyan">JSONValue</span>];
<span class = "purple">NSArray</span>*jsonArray = [dic <span class = "purple">objectForKey</span>:<span class = "red">@"result"</span>];
    