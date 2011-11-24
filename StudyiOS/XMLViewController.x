#import "GDataXMLNode.h"
// 加载XML文件
GDataXMLDocument *doc = [[GDataXMLDocument alloc] 
    initWithXMLString: self.xmlString options:0 error:nil];
// 使用XPath语法
NSArray *partyMembers = [doc.rootElement nodesForXPath:@"//Party/Player" error:nil];
// 遍历节点
for(GDataXMLElement *partyMember in partyMembers) {
    NSString *_name;
    // 取值
    NSArray *names = [partyMember elementsForName:@"Name"];
    if(names.count!= 0) {
        GDataXMLElement *firstName = (GDataXMLElement *) [names objectAtIndex:0];
        _name = firstName.stringValue;
    } else continue;
}