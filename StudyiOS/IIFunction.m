//
//  IIFunction.m
//  StudyiOS
//
//  Created by  on 11-10-14.
//  Copyright (c) 2011年 ZhangYiCheng. All rights reserved.
//

#import "IIFunction.h"

@implementation IIFunction

// 检查URL格式，并补完
+ (NSURL *)smartURLForString:(NSString *)str
{
    NSURL *     result;
    NSString *  trimmedStr;
    NSRange     schemeMarkerRange;
    NSString *  scheme;
    
    assert(str != nil);
    
    result = nil;
    
    trimmedStr = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if ( (trimmedStr != nil) && (trimmedStr.length != 0) ) {
        schemeMarkerRange = [trimmedStr rangeOfString:@"://"];
        
        if (schemeMarkerRange.location == NSNotFound) {
            result = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@", trimmedStr]];
        } else {
            scheme = [trimmedStr substringWithRange:NSMakeRange(0, schemeMarkerRange.location)];
            assert(scheme != nil);
            
            if ( ([scheme compare:@"http"  options:NSCaseInsensitiveSearch] == NSOrderedSame)
                || ([scheme compare:@"https" options:NSCaseInsensitiveSearch] == NSOrderedSame) ) {
                result = [NSURL URLWithString:trimmedStr];
            } else {
                // It looks like this is some unsupported URL scheme.
            }
        }
    }
    
    return result;
}

// 得到临时文件路径
+ (NSString *)pathForTemporaryFileWithPrefix:(NSString *)prefix
{
    NSString *  result;
    CFUUIDRef   uuid;
    CFStringRef uuidStr;
    
    uuid = CFUUIDCreate(NULL);
    assert(uuid != NULL);
    
    uuidStr = CFUUIDCreateString(NULL, uuid);
    assert(uuidStr != NULL);
    
    result = [NSTemporaryDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"%@-%@", prefix, uuidStr]];
    assert(result != nil);
    
    CFRelease(uuidStr);
    CFRelease(uuid);
    
    return result;
}

// 检查文件类型是否匹配
+ (BOOL)isHTTPContentType:(NSString *)prefixStr contextType:(NSString *)contextType
{
    BOOL    result;
    NSRange foundRange;
    
    result = NO;
    
    foundRange = [contextType rangeOfString:prefixStr options:NSAnchoredSearch | NSCaseInsensitiveSearch];
    if (foundRange.location != NSNotFound) {
        assert(foundRange.location == 0);            // because it's anchored
        if (foundRange.length == contextType.length) {
            result = YES;
        } else {
            unichar nextChar;
            
            nextChar = [contextType characterAtIndex:foundRange.length];
            result = nextChar <= 32 || nextChar >= 127 || (strchr("()<>@,;:\\<>/[]?={}", nextChar) != NULL);
        }
        /*
         From RFC 2616:
         
         token          = 1*<any CHAR except CTLs or separators>
         separators     = "(" | ")" | "<" | ">" | "@"
         | "," | ";" | ":" | "\" | <">
         | "/" | "[" | "]" | "?" | "="
         | "{" | "}" | SP | HT
         
         media-type     = type "/" subtype *( ";" parameter )
         type           = token
         subtype        = token
         */
    }
    return result;
}


@end
