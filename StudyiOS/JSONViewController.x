#import "JSON.h"
// 得到json源文件字符串
NSString *jsonString = [[NSString alloc] 
    initWithContentsOfFile: path 
    encoding: NSUTF8StringEncoding 
    error: nil];
// 解析json
NSMutableDictionary *dic = [jsonString JSONValue];
NSArray *jsonArray = [dic objectForKey:@"result"];
    