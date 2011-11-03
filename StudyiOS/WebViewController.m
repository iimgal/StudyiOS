//
//  WebViewController.m
//  StudyiOS
//
//  Created by  on 11-10-14.
//  Copyright (c) 2011年 ZhangYiCheng. All rights reserved.
//

#import "WebViewController.h"
#import "IIFunction.h"

@interface WebViewController()

@property (nonatomic, assign)   BOOL            isReceiving;
@property (nonatomic, strong)   NSURLConnection *connection;
@property (nonatomic, strong)   NSString        *filePath;
@property (nonatomic, strong)   NSOutputStream  *fileStream;
@property (nonatomic, assign)   NSInteger       networkingCount;

- (void)startReceive;
- (void)stopReceiveWithStatus:(NSString *)statusString;

@end

@implementation WebViewController

@synthesize getButton;
@synthesize putButton;
@synthesize postButton;
@synthesize imageView;
@synthesize urlText;

@synthesize isReceiving;
@synthesize connection;
@synthesize filePath;
@synthesize fileStream;
@synthesize networkingCount;



- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    //NSString *defaultURLText = @"http://p1.sstu.net/p.aspx?u=v20_p1_photo_1110151534135707_0.png";
    NSString *defaultURLText = @"http://www.ouliu.net/i/8a40ecc7958a788bd57e711f569f2273.jpeg";
    self.urlText.text = defaultURLText;
    
    [super viewDidLoad];
}


- (void)viewDidUnload
{
    self.connection = nil;
    self.filePath = nil;
    self.fileStream = nil;
    [self setGetButton:nil];
    [self setImageView:nil];
    [self setPutButton:nil];
    [self setPostButton:nil];
    [self setUrlText:nil];
    [super viewDidUnload];
}

#pragma mark UI Action
- (IBAction)getPressed:(id)sender {
    // 判断是否已在连接
    if (connection == nil) {
        // 开始连接
        [self startReceive];
    }else{
        // 停止连接
        [self stopReceiveWithStatus:@"Cancelled"];
    }
}

- (IBAction)putPressed:(id)sender {
}

- (IBAction)postPressed:(id)sender {
}

#pragma mark -
// Starts a connection to download the current URL.
- (void)startReceive
{
    BOOL                success;
    NSURL *             url;
    NSURLRequest *      request;
    
    assert(self.connection == nil);         // don't tap receive twice in a row!
    assert(self.fileStream == nil);         // ditto
    assert(self.filePath == nil);           // ditto
    
    // 检查URL格式
    url = [IIFunction smartURLForString:self.urlText.text];
    success = (url != nil);
    
    if ( ! success) {
        NSLog(@"Invalid URL");
    } else {
        
        // 打开数据流用以存放将得到的数据
        
        self.filePath = [IIFunction pathForTemporaryFileWithPrefix:@"Get"];
        assert(self.filePath != nil);
        
        self.fileStream = [NSOutputStream outputStreamToFileAtPath:self.filePath append:NO];
        assert(self.fileStream != nil);
        
        [self.fileStream open];
        
        // 开启连接
        
        request = [NSURLRequest requestWithURL:url];
        assert(request != nil);
        
        self.connection = [NSURLConnection connectionWithRequest:request delegate:self];
        assert(self.connection != nil);
        
        // 更新UI
        [self.getButton setTitle:@"Loading" forState:UIControlStateNormal];
        self.networkingCount += 1;
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    }
}

- (void)stopReceiveWithStatus:(NSString *)statusString
// Shuts down the connection and displays the result (statusString == nil) 
// or the error status (otherwise).
{
    if (self.connection != nil) {
        [self.connection cancel];
        self.connection = nil;
    }
    if (self.fileStream != nil) {
        [self.fileStream close];
        self.fileStream = nil;
    }
    
    if (statusString == nil) {
        assert(self.filePath != nil);
        self.imageView.image = [UIImage imageWithContentsOfFile:self.filePath];
    }
    [self.getButton setTitle:@"Get" forState:UIControlStateNormal];
    
    self.networkingCount -= 1;
    [UIApplication sharedApplication].networkActivityIndicatorVisible = (self.networkingCount != 0);
    
    self.filePath = nil;
}

#pragma mark - NSURLConnection Delegate
// A delegate method called by the NSURLConnection when the request/response 
// exchange is complete.  We look at the response to check that the HTTP 
// status code is 2xx and that the Content-Type is acceptable.  If these checks 
// fail, we give up on the transfer.
// 请求成功时触发
- (void)connection:(NSURLConnection *)theConnection didReceiveResponse:(NSURLResponse *)response
{
#pragma unused(theConnection)
    NSHTTPURLResponse * httpResponse;
    NSString *          contentTypeHeader;
    
    assert(theConnection == self.connection);
    
    httpResponse = (NSHTTPURLResponse *) response;
    assert( [httpResponse isKindOfClass:[NSHTTPURLResponse class]] );
    
    if ((httpResponse.statusCode / 100) != 2) {
        [self stopReceiveWithStatus:[NSString stringWithFormat:@"HTTP error %zd", (ssize_t) httpResponse.statusCode]];
    } else {
        contentTypeHeader = [httpResponse.allHeaderFields objectForKey:@"Content-Type"];
        if (contentTypeHeader == nil) {
            [self stopReceiveWithStatus:@"No Content-Type!"];
        } else if ( ! [IIFunction isHTTPContentType:@"image/jpeg" contextType:contentTypeHeader] 
                   && ! [IIFunction isHTTPContentType:@"image/png" contextType:contentTypeHeader] 
                   && ! [IIFunction isHTTPContentType:@"image/gif" contextType:contentTypeHeader] ) {
            [self stopReceiveWithStatus:[NSString stringWithFormat:@"Unsupported Content-Type (%@)", contentTypeHeader]];
        } else {
            NSLog(@"Response OK.");
        }
    }    
}
// 成功接受到数据时触发
- (void)connection:(NSURLConnection *)theConnection didReceiveData:(NSData *)data
// A delegate method called by the NSURLConnection as data arrives.  We just 
// write the data to the file.
{
#pragma unused(theConnection)
    NSInteger       dataLength;
    const uint8_t * dataBytes;
    NSInteger       bytesWritten;
    NSInteger       bytesWrittenSoFar;
    
    assert(theConnection == self.connection);
    
    dataLength = [data length];
    dataBytes  = [data bytes];
    
    bytesWrittenSoFar = 0;
    do {
        bytesWritten = [self.fileStream write:&dataBytes[bytesWrittenSoFar] maxLength:dataLength - bytesWrittenSoFar];
        assert(bytesWritten != 0);
        if (bytesWritten == -1) {
            [self stopReceiveWithStatus:@"File write error"];
            break;
        } else {
            bytesWrittenSoFar += bytesWritten;
        }
    } while (bytesWrittenSoFar != dataLength);
}
// 请求失败时触发
- (void)connection:(NSURLConnection *)theConnection didFailWithError:(NSError *)error
// A delegate method called by the NSURLConnection if the connection fails. 
// We shut down the connection and display the failure.  Production quality code 
// would either display or log the actual error.
{
#pragma unused(theConnection)
#pragma unused(error)
    assert(theConnection == self.connection);
    
    [self stopReceiveWithStatus:@"Connection failed"];
}
// 请求结束时触发
- (void)connectionDidFinishLoading:(NSURLConnection *)theConnection
// A delegate method called by the NSURLConnection when the connection has been 
// done successfully.  We shut down the connection with a nil status, which 
// causes the image to be displayed.
{
#pragma unused(theConnection)
    assert(theConnection == self.connection);
    
    [self stopReceiveWithStatus:nil];
}



@end
