#import "TFHpple.h"

// 得到网页DATA
NSString *urlString = @"http://www.baidu.com";
NSData *htmlData = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]]; 
    
// 创建TFHpple对象
TFHpple *xpathParser = [[TFHpple alloc] initWithHTMLData:htmlData];
    
// 通过xpath语法解析
NSArray *elements = [xpathParser searchWithXPathQuery:@"//title"];
TFHppleElement *element = [elements objectAtIndex:0];
NSString *myTitle = [element content];
    
    