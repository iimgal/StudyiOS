<span class = "brown">#import</span> <span class = "red">"TFHpple.h"</span>

<span class = "green">// 得到网页DATA</span>
<span class = "purple">NSString</span>*urlString = <span class = "red">@"http://www.baidu.com"</span>;
<span class = "purple">NSData</span>*htmlData = [<span class = "purple">NSData dataWithContentsOfURL</span>:[<span class = "purple">NSURL URLWithString</span>:urlString]]; 
    
<span class = "green">// 创建TFHpple对象</span>
<span class = "cyan">TFHpple</span>*xpathParser = [[<span class = "cyan">TFHpple</span> <span class = "purple">alloc</span>] <span class = "cyan">initWithHTMLData</span>:htmlData];
    
<span class = "green">// 通过xpath语法解析</span>
<span class = "purple">NSArray</span>*elements = [xpathParser <span class = "cyan">searchWithXPathQuery</span>:<span class = "red">@"//title"</span>];
<span class = "cyan">TFHppleElement</span>*element = [elements <span class = "purple">objectAtIndex:0</span>];
<span class = "purple">NSString</span>*myTitle = [element <span class = "cyan">content</span>];
    
    