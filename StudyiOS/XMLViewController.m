//
//  XMLViewController.m
//  StudyiOS
//
//  Created by  on 11-10-18.
//  Copyright (c) 2011年 ZhangYiCheng. All rights reserved.
//

#import "XMLViewController.h"

@interface XMLViewController()
@property (nonatomic, strong) NSString *xmlString;
- (void)parseGDataXML;
@end

@implementation XMLViewController
@synthesize textView;
@synthesize nameField;
@synthesize levelField;
@synthesize classField;
@synthesize xmlString;

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle


- (void)viewDidLoad
{
    // 增加Code按钮，可跳转至教学页面
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"Code" style:UIBarButtonItemStyleBordered target:self action:@selector(code)];
    self.navigationItem.rightBarButtonItem = item;
    
    [super viewDidLoad];
}


- (void)viewDidUnload
{
    self.textView = nil;
    self.xmlString = nil;
    [self setNameField:nil];
    [self setLevelField:nil];
    [self setClassField:nil];
    [super viewDidUnload];
}

// 解析网络文件
- (IBAction)networkXML:(id)sender {
    NSURL *url = [NSURL URLWithString:
                      @"http://www.raywenderlich.com/downloads/Party.xml"];
    // 创建请求
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] init];    
    [request setURL:url];    
    [request setHTTPMethod:@"GET"]; 
        
    NSHTTPURLResponse* response;    
    // 调用同步请求得到数据
    NSData* data = 
        [NSURLConnection sendSynchronousRequest:request    
                              returningResponse:&response 
                                          error:nil];   
    // 得到XML文本并转码
    self.xmlString = 
        [[NSString alloc] initWithData:data 
                              encoding: CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000)];
    
    [self parseGDataXML];
    
}

// 解析本地文件
- (IBAction)localXML:(id)sender
{
    // 先将要操作的文件拷贝到Documents目录下
    
    // 得到资源文件路径
    NSString *path = [[NSBundle mainBundle] pathForResource:@"party" ofType:@"xml"];
    // 得到Documents路径
    NSString *home = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSString *homePath = [home stringByAppendingPathComponent:@"party.xml"];
    
    // 文件管理器
    NSFileManager *manager = [NSFileManager defaultManager];
    
    NSError *error;
    // 判断文件是否存在
    if ([manager fileExistsAtPath:homePath]) {
        // 如果存在就先删除(根据需求也可以选择什么也不做)
        //[manager removeItemAtPath:homePath error:&error];
        //[manager copyItemAtPath:path toPath:homePath error:&error];
    }else {
        // 将文件拷贝到可操作的Documents文件夹
        [manager copyItemAtPath:path toPath:homePath error:&error];
    }
    
    // 得到XML文件内容
    self.xmlString = [[NSString alloc] initWithContentsOfFile:homePath encoding:NSUTF8StringEncoding error:nil];
    
    [self parseGDataXML];
}

// GDataXML方式解析
- (void)parseGDataXML
{
    textView.text = @"";
    
    NSError *error;
    // 加载XML文件
    GDataXMLDocument *doc = [[GDataXMLDocument alloc] 
                             initWithXMLString: self.xmlString
                             options:0 
                             error:&error];
    
    if (doc == nil) { return; }
    
    NSLog(@"LOG=%@", [[NSString alloc] initWithData:doc.XMLData encoding:NSUTF8StringEncoding]);
    
    NSMutableString *resultString = [[NSMutableString alloc] initWithString:@"XML数据内容: \n"];
    
    // 解析
    
    // 使用XPath语法解析
    NSArray *partyMembers = [doc.rootElement nodesForXPath:@"//Party/Player" error:nil];
    // 遍历节点
    for (GDataXMLElement *partyMember in partyMembers) {
        
        NSString *_name;
        NSString *_level;
        NSString *_class;
        
        // 取值
        NSArray *names = [partyMember elementsForName:@"Name"];
        if (names.count > 0) {
            GDataXMLElement *firstName = (GDataXMLElement *) [names objectAtIndex:0];
            _name = firstName.stringValue;
        } else continue;
        
        // Level
        NSArray *levels = [partyMember elementsForName:@"Level"];
        if (levels.count > 0) {
            GDataXMLElement *firstLevel = (GDataXMLElement *) [levels objectAtIndex:0];
            _level = firstLevel.stringValue;
        } else continue;
        
        // Class
        NSArray *classes = [partyMember elementsForName:@"Class"];
        if (classes.count > 0) {
            GDataXMLElement *firstClass = (GDataXMLElement *) [classes objectAtIndex:0];
            _class = firstClass.stringValue;
            
        } else continue;
        
        [resultString appendFormat:@"Name=%@",_name ];
        [resultString appendFormat:@" Level=%@",_level ];
        [resultString appendFormat:@" Class=%@\n",_class ];
        
    }
    
    textView.text = resultString;
}

// 写文件
- (IBAction)saveXML:(id)sender {
    
    // 创建XML节点
    GDataXMLElement * partyElement = [GDataXMLNode elementWithName:@"Party"];
    GDataXMLElement * playerElement = [GDataXMLNode elementWithName:@"Player"];
    GDataXMLElement * nameElement = [GDataXMLNode elementWithName:@"Name" stringValue:self.nameField.text];
    GDataXMLElement * levelElement = [GDataXMLNode elementWithName:@"Level" stringValue:self.levelField.text];     
    GDataXMLElement * classElement = [GDataXMLNode elementWithName:@"Class" stringValue:self.classField.text];
    
    // 创建XML层次结构
    [playerElement addChild:nameElement];
    [playerElement addChild:levelElement];
    [playerElement addChild:classElement];
    [partyElement addChild:playerElement];

    // 创建XML文件
    GDataXMLDocument *document = [[GDataXMLDocument alloc] initWithRootElement:partyElement];
    NSData *xmlData = document.XMLData;
    
    // 得到输出路径
    NSString *homePath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"party.xml"];

    NSLog(@"Saving xml data to %@...", homePath);
    // 输出
    [xmlData writeToFile:homePath atomically:YES];
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.nameField resignFirstResponder];
    [self.levelField resignFirstResponder];
    [self.classField resignFirstResponder];
}

// 跳转至教学页面
- (void)code
{
    CodeViewController *controller = [[CodeViewController alloc] initWithNibName:@"CodeViewController" bundle:nil];
    NSString *name = [NSString stringWithUTF8String:object_getClassName(self)];
    controller.className = name;
    
    [self.navigationController pushViewController:controller animated:YES];
}

@end
