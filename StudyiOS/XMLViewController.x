<span class = "brown">#import</span> <span class = "red">"GDataXMLNode.h"</span>
<span class = "green">// 加载XML文件</span>
<span class = "cyan">GDataXMLDocument</span>*doc = [[<span class = "cyan">GDataXMLDocument</span> <span class = "purple">alloc</span>] <span class = "cyan">initWithXMLString</span>: <span class = "magenta">self</span>.<span class = "cyan">xmlString</span> <span class = "cyan">options</span>:<span class = "purple">0</span> <span class = "cyan">error</span>:<span class = "magenta">nil</span>];
<span class = "green">// 使用XPath语法</span>
<span class = "purple">NSArray</span>*partyMembers = [doc.<span class = "purple">rootElement</span> <span class = "cyan">nodesForXPath</span>:<span class = "red">@"//Party/Player"</span> <span class = "cyan">error</span>:<span class = "magenta">nil</span>];
<span class = "green">// 遍历节点</span>
<span class = "magenta">for</span>(<span class = "cyan">GDataXMLElement</span>*partyMember <span class = "magenta">in</span>partyMembers) {
    <span class = "purple">NSString</span> *_name;
    <span class = "green">// 取值</span>
    <span class = "purple">NSArray</span>*names = [partyMember <span class = "cyan">elementsForName</span>:<span class = "red">@"Name"</span>];
    <span class = "magenta">if</span>(names.<span class = "purple">count</span>!= <span class = "purple">0</span>) {
        <span class = "cyan">GDataXMLElement</span>*firstName = (<span class = "cyan">GDataXMLElement</span>*) [names <span class = "purple">objectAtIndex:0</span>];
        _name = firstName.<span class = "purple">stringValue</span>;
    } <span class = "magenta">else continue</span>;
}